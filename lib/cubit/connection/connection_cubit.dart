import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/services/connection/i_connection_service.dart';

part 'connection_state.dart';

class AppConnectionCubit extends Cubit<AppConnectionState> {
  final IConnectionService connectionService;

  AppConnectionCubit({required this.connectionService})
      : super(ConnectionInitialState());

  void init() {
    connectionService.onChange().listen(
          (event) => event
              ? emit(ConnectionOnlineState())
              : emit(ConnectionOfflineState()),
        );
  }
}
