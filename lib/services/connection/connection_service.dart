import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes/services/connection/i_connection_service.dart';

class ConnectionService implements IConnectionService {
  @override
  late final Connectivity connectivity;

  ConnectionService({required this.connectivity});

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
      (connectivityResult) => _isOnline(connectivityResult),
    );
  }
}
