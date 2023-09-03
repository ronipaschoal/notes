import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes/services/connection/i_connection_service.dart';

class ConnectionService implements IConnectionService {
  @override
  late final Connectivity connectivity;
  bool _wasOffline = false;

  ConnectionService({required this.connectivity});

  // TODO implements
  void _sincData() {}

  bool _isOnline(ConnectivityResult connectivityResult) {
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<bool> init() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return _isOnline(connectivityResult);
  }

  @override
  Stream<bool> stream() {
    return connectivity.onConnectivityChanged.map(
      (connectivityResult) {
        final isOnline = _isOnline(connectivityResult);
        if (_wasOffline && isOnline) _sincData();
        _wasOffline = !isOnline;
        return isOnline;
      },
    );
  }
}
