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

  void _setConnectionState(bool isOnline) {
    isOnline ? emit(ConnectionOnlineState()) : emit(ConnectionOfflineState());
  }

  void _changeConnectionState(bool isOnline) {
    if (_wasOffline && isOnline) _syncData();
    _wasOffline = !isOnline;
    _setConnectionState(isOnline);
  }

  void _syncData() => repository.sync();

  void init() {
    connectionService //
        .init()
        .then((isOnline) => _setConnectionState(isOnline));

    connectionService //
        .stream()
        .listen((bool isOnline) => _changeConnectionState(isOnline));
  }
}
