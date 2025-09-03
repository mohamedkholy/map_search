import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionObserver {
  ConnectionObserver._();

  static Future<InternetConnectionState> checkConnectivity() async {
    final List<ConnectivityResult> result = await (Connectivity()
        .checkConnectivity());
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      return InternetConnectionState.connected;
    } else {
      return InternetConnectionState.disconnected;
    }
  }
}

enum InternetConnectionState { connected, disconnected }
