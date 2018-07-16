import 'package:compass_try03/utility/rest_datasource.dart';

import 'dart:async';

import 'package:qr_reader/qr_reader.dart';



abstract class ThyScanContract {
  void onScanSuccess(String qrText);
  void onScanFailure(String errorText);
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
        .scan();
  }

  performScan(String email) async {
    String qrText = await _scan();
    api.scan(email, qrText)
    .then((filler) => _contract.onScanSuccess(qrText))
    .catchError((exception) => _contract.onScanFailure(exception.toString().substring(11)));
  }


}
