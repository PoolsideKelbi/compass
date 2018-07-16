import 'package:connectivity/connectivity.dart';



bool isOffline = false;

void initialize() {
  final Connectivity connectivity = new Connectivity();
  connectivity.onConnectivityChanged.listen((newState) {
    isOffline = (newState == ConnectivityResult.none);
  });
}