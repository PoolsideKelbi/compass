import 'package:compass_try03/utility/network_handler.dart';
import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants show ResponseErrors, Defaults;

import 'dart:async';



class ThyRestDatasource {


  static ThyRestDatasource _instance = new ThyRestDatasource.internal();
  ThyRestDatasource.internal();
  factory ThyRestDatasource() => _instance;


  ThyNetworkHandler _networkHandler = new ThyNetworkHandler();


  String _baseURL;
  String _loginURL;
  String _scanBaseURL;


  set baseURL(baseURL) {
    _baseURL = 'http://' + (baseURL == '' ? constants.Defaults.default_base_url : baseURL);
    _loginURL = _baseURL + '/mobile/login';
    _scanBaseURL = _baseURL + '/system/redeem';
  }


  Future<ThyUser> login(String email, String password) {
    return _networkHandler.post(
      _loginURL,
      headers: {"Content-Type": "application/json"},
      body: {"email": email, "password": password},
    ).then((dynamic data) {
      if (data["request"]) return new ThyUser(data["name"], data["email"]);
      else throw new Exception(constants.ResponseErrors.login_error_incorrect);
    });
  }
  

  Future<String> scan(String email, String qrResult) {
    String scanURL = _scanBaseURL + '/' + qrResult + '/' + email;
    print(scanURL);
    return _networkHandler.get(
      scanURL,
      headers: {"Content-Type": "application/json"},
    ).then((dynamic data) {
      if (data["request"]) return data["message"];
      //TODO handling this exception's message
      else throw new Exception(data["message"]);
    });
  }


}