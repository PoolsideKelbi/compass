import 'package:compass_try03/utility/rest_datasource.dart';
import 'package:compass_try03/utility/connectivity_handler.dart' show isOffline;
import 'package:compass_try03/utility/constants_handler.dart' as constants show Connection;

import 'dart:async';

import 'package:qr_reader/qr_reader.dart';



abstract class ThyScanContract {
  void onScanSuccess(String qrText);
  void onScanFailure(Exception exception);
  void onScanCancelled();
}



class ThyScanHandler {

  
  ThyScanContract _contract;
  ThyScanHandler(this._contract);

  ThyRestDatasource api = new ThyRestDatasource();


  Future<String> _scan() {
    return new QRCodeReader()
        .setAutoFocusIntervalInMs(4000)
        .scan().catchError((exception) => throw new Exception("User permission to access the camera is needed."));
  }
  

  performScan(String email) async {
    isOffline ? _contract.onScanFailure(Exception(constants.Connection.connection_none)) :
    _scan().then((qrResult) {
      qrResult == null ? _contract.onScanCancelled() :
      api.scan(email, qrResult)
      .then((message) => _contract.onScanSuccess(message))
      .catchError((exception) => _contract.onScanFailure(exception));
    })
    .catchError((exception) => _contract.onScanFailure(exception));
  }


}