import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes/services/connection/i_connection_service.dart';

class ConnectionService implements IConnectionService {
  @override
  late final Connectivity connectivity;
  bool _wasOffline = false;

  ConnectionService({required this.connectivity});

  // TODO implements
  void _sincData() {}

  @override
  Stream<bool> onChange() {
    return connectivity.onConnectivityChanged.map(
      (event) {
        final isOnline = event != ConnectivityResult.none;
        if (_wasOffline && isOnline) _sincData();
        _wasOffline = !isOnline;
        return isOnline;
      },
    );
  }
}
