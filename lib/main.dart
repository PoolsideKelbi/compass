import 'package:compass_try03/utility/connectivity_handler.dart' as connectivity show initialize;
import 'package:compass_try03/utility/route_handler.dart';
import 'package:compass_try03/utility/auth_handler.dart' as auth;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ThyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compass',
      initialRoute: auth.loggedInUser.isMock ? 'login' : 'home',
      onGenerateRoute: getRoute,
      theme: thyTheme,
    );
  }
}



void main() async{
  connectivity.initialize();
  await auth.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new ThyApp());
}



final thyTheme = new ThemeData(
  canvasColor: Color(0xF0B2DFDB),
  scaffoldBackgroundColor: Colors.transparent,
  backgroundColor: Colors.white,
  splashColor: Colors.teal[100],
  buttonColor: Colors.teal[200],
  primaryColor: Colors.teal[200],
  textSelectionColor: Colors.teal[200],
  errorColor: Colors.red[300],
  hintColor: Colors.teal[200],
  iconTheme: new IconThemeData(color: Colors.white, size: 50.0),
  textTheme: new TextTheme(
    title: new TextStyle(
      fontFamily: 'Century Gothic',
      fontSize: 20.0,
      color: Colors.white
    ),
    button: new TextStyle(
      fontFamily: 'Century Gothic',
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      color: Colors.white
    ),
    subhead: new TextStyle(
      fontFamily: 'Century Gothic',
      fontSize: 16.0,
      color: Colors.white
    ),
    body1: new TextStyle(
      fontFamily: 'Century Gothic',
      fontSize: 12.0,
      color: Colors.white
    ),
    body2: new TextStyle(
      fontFamily: 'Century Gothic',
      fontSize: 10.0,
      color: Colors.white
    ),
    caption: new TextStyle(
      fontFamily: 'Century Gothic',
      fontSize: 10.0,
      color: Colors.grey
    )
  ),
);