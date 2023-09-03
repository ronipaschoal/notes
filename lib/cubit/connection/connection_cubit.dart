import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/services/connection/i_connection_service.dart';

part 'connection_state.dart';

class AppConnectionCubit extends Cubit<AppConnectionState> {
  final IConnectionService connectionService;

  AppConnectionCubit({required this.connectionService})
      : super(ConnectionInitialState());

  void _connectionState(bool isOnline) {
    isOnline ? emit(ConnectionOnlineState()) : emit(ConnectionOfflineState());
  }

  void init() {
    connectionService.init().then((isOnline) => _connectionState(isOnline));
    connectionService.stream().listen((isOnline) => _connectionState(isOnline));
  }
}
