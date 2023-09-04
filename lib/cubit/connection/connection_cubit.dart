import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/datasources/repositories/note/i_note_repositorie.dart';
import 'package:notes/services/connection/i_connection_service.dart';

part 'connection_state.dart';

class AppConnectionCubit extends Cubit<AppConnectionState> {
  final IConnectionService connectionService;
  final INoteRepository repository;
  bool _wasOffline = false;

  AppConnectionCubit({
    required this.connectionService,
    required this.repository,
  }) : super(ConnectionInitialState());

  void _connectionState(bool isOnline) {
    isOnline ? emit(ConnectionOnlineState()) : emit(ConnectionOfflineState());
  }

  void _syncData() => repository.sync();

  void init() {
    connectionService.init().then((isOnline) => _connectionState(isOnline));
    connectionService.stream().listen((isOnline) {
      if (_wasOffline && isOnline) _syncData();
      _wasOffline = !isOnline;
      _connectionState(isOnline);
    });
  }
}
