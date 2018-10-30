import 'package:compassscan/utility/constants_handler.dart' as constants show ResponseErrors;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;



class ThyNetworkHandler {


  static ThyNetworkHandler _instance = new ThyNetworkHandler.internal();
  ThyNetworkHandler.internal();
  factory ThyNetworkHandler() => _instance;

  
  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();


  Future<dynamic> post(String url, {headers, body, encoding}) {
    return http
      .post(
        url,
        headers: headers,
        body: _encoder.convert(body),
        encoding: encoding,
      )
      .then((http.Response response) {
        final String data = response.body;
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception(constants.ResponseErrors.generic_error);
        }
        return _decoder.convert(data);
      }).catchError((exception) => throw new Exception(constants.ResponseErrors.server_error_invalid));
  }


  Future<dynamic> get(String url, {headers}) {
    return http
      .get(
        url,
        headers: headers,
      )
      .then((http.Response response) {
        final String data = response.body;
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception(constants.ResponseErrors.generic_error);
        }
        return _decoder.convert(data);
      });
  }

  
}