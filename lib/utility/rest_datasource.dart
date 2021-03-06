import 'package:compassscan/utility/network_handler.dart';
import 'package:compassscan/model/user_model.dart';
import 'package:compassscan/utility/constants_handler.dart' as constants show ResponseErrors;

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
    _baseURL = baseURL;
    _loginURL = _baseURL + '/mobile/login';
    _scanBaseURL = _baseURL + '/system/redeem';
  }


  Future<ThyUser> login(String email, String password) {
    return _networkHandler.post(
      _loginURL,
      headers: {"Content-Type": "application/json"},
      body: {"email": email, "password": password},
    ).then((dynamic data) {
      if (data["request"]) return new ThyUser.fromMap(data);
      else throw new Exception(constants.ResponseErrors.login_error_incorrect);
    });
  }
  

  Future<String> scan(String email, String qrResult) {
    String scanURL = _scanBaseURL + '/' + qrResult + '/' + email;
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