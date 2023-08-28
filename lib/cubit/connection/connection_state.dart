part of 'connection_cubit.dart';

@immutable
abstract interface class AppConnectionState {}

class ConnectionInitialState extends AppConnectionState {}

class ConnectionOnlineState extends AppConnectionState {}

class ConnectionOfflineState extends AppConnectionState {}
