import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IConnectionService {
  late final Connectivity connectivity;
  Future<bool> init();
  Stream<bool> stream();
}
