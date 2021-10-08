import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info.dart';

class NetworkInfoImplementation extends INetworkInfo {

  final InternetConnectionChecker networkConnection;

  NetworkInfoImplementation(this.networkConnection);

  @override
  Future<bool> get isConnected => networkConnection.hasConnection;

}
