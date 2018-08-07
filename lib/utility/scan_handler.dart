import 'package:compass_try03/utility/rest_datasource.dart';
import 'package:compass_try03/utility/connectivity_handler.dart' show isOffline;
import 'package:compass_try03/utility/constants_handler.dart' as constants show Connection, DialogWidget;

import 'dart:async';

import 'package:qrcode_reader/QRCodeReader.dart';



abstract class ThyScanContract {
  void onRedeemSuccess(String message);
  void onRedeemFailure(String message);
  void onScanFailure(Exception exception);
  void onScanCancelled();
}



class ThyScanHandler {


  ThyScanContract _contract;
  ThyScanHandler(this._contract);
  
  ThyRestDatasource _api = new ThyRestDatasource();
  

  performScan(String email) async {
    isOffline ? _contract.onScanFailure(Exception(constants.Connection.connection_none)) :
    _scan().then((qrResult) {
      qrResult == null ? _contract.onScanCancelled() :
      _api.scan(email, qrResult)
      .then((message) => _isRedeemValid(message) ? _contract.onRedeemSuccess(message)
                                                 : _contract.onRedeemFailure(message))
      .catchError((exception) => _contract.onScanFailure(exception));
    })
    .catchError((exception) => _contract.onScanFailure(exception));
  }


  Future<String> _scan() {
    return new QRCodeReader()
        .setAutoFocusIntervalInMs(4000)
        .scan().catchError((exception) => throw new Exception(constants.DialogWidget.permission_error));
  }


  bool _isRedeemValid(String message) {
    //TODO better validation is necessary
    return message.length == 32;
  }


}