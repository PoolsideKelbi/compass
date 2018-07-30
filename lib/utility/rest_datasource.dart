import 'package:compass_try03/utility/network_handler.dart';
import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants show ResponseErrors;

import 'dart:async';



class ThyRestDatasource {


  ThyNetworkHandler _networkHandler = new ThyNetworkHandler();

  static final baseUrl = 'http://82.165.206.127';
  static final loginURL = baseUrl + '/mobile/login';
  static final scanBaseURL = baseUrl + '/system/redeem';


  Future<ThyUser> login(String email, String password) {
    return _networkHandler.post(
      loginURL,
      headers: {"Content-Type": "application/json"},
      body: {"email": email, "password": password},
    ).then((dynamic data) {
      if (data["request"]) return new ThyUser(data["name"], data["email"]);
      //TODO handling this exception' message
      else throw new Exception(constants.ResponseErrors.login_error_incorrect);
    });
  }
  

  Future<String> scan(String email, String qrResult) {
    String scanURL = scanBaseURL + '/' + qrResult + '/' + email;
    print(scanURL);
    return _networkHandler.get(scanURL).then((dynamic data) {
      if (data["request"]) return data["message"];
      //TODO handling this exception's message
      else throw new Exception(data["message"]);
    });
  }


}