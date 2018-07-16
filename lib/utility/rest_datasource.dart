import 'package:compass_try03/utility/network_handler.dart';
import 'package:compass_try03/model/user_model.dart';

import 'dart:async';



class ThyRestDatasource {


  ThyNetworkHandler _netHandler = new ThyNetworkHandler();

  static final baseUrl = 'http://compasss.mocklab.io';
  static final loginURL = baseUrl + '/login';
  static final scanURL = baseUrl + '/scan';


  Future<ThyUser> login(String email, String password) {
    return _netHandler.post(
      loginURL,
      headers: {"Content-Type": "application/json"},
      body: {"email": email, "password": password},
    ).then((dynamic data) {
      if (data["error"]) throw new Exception(data["message"]);
      return new ThyUser.fromMap(data["user"]);
    });
  }
  

  Future<Null> scan(String email, String qrText) {
    return _netHandler.post(scanURL,
        headers: {"Content-Type": "application/json"},
        body: {"email": email, "qr_string": qrText}).then((dynamic data) {
      if (data["error"]) throw new Exception(data["message"]);
      return null;
    });
  }


}
