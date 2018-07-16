import 'package:compass_try03/utility/rest_datasource.dart';

import 'dart:async';

import 'package:qr_reader/qr_reader.dart';



abstract class ThyScanContract {
  void onScanSuccess(String qrText);
  void onScanFailure(Exception exception);
}



class ThyScanHandler {

  
  ThyScanContract _contract;
  ThyScanHandler(this._contract);

  ThyRestDatasource api = new ThyRestDatasource();


  Future<String> _scan() {
    return new QRCodeReader()
        .setAutoFocusIntervalInMs(5000)
        .setTorchEnabled(false)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan().catchError((exception) => throw new Exception("User permission to access the camera is needed."));
  }

  performScan(String email) async {
    _scan().then((qrText) {
      api.scan(email, qrText)
      .then((_) => _contract.onScanSuccess(qrText))
      .catchError((exception) => _contract.onScanFailure(exception));
    })
    .catchError((exception) => _contract.onScanFailure(exception));
  }


}