import 'package:compass_try03/view/home_screen.dart';
import 'package:compass_try03/view/login_screen.dart';
import 'package:compass_try03/utility/connectivity_handler.dart' show initialize;

import 'package:flutter/material.dart';



class ThyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initialize();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compass',
      home: new ThyLoginScreen(),
      routes: thyRoutes,
      theme: thyTheme,
    );
  }
}



void main() => runApp(new ThyApp());

final thyRoutes = {
  '/home': (_) => new ThyHomeScreen(),
  '/login': (_) => new ThyLoginScreen()
};

final thyTheme = new ThemeData(
    backgroundColor: Colors.transparent,
    splashColor: Colors.teal[100],
    buttonColor: Colors.teal[200],
    primaryColor: Colors.teal[200],
    errorColor: Colors.red[300],
    hintColor: Colors.teal[200],
    iconTheme: new IconThemeData(color: Colors.white, size: 50.0),
    inputDecorationTheme: new InputDecorationTheme(
        hintStyle: new TextStyle(
            fontFamily: 'Century Gothic', color: Colors.grey[400])),
    textTheme: new TextTheme(
        title: new TextStyle(
            fontFamily: 'Century Gothic',
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            color: Colors.white),
        button: new TextStyle(
            fontFamily: 'Century Gothic',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.white),
        body1: new TextStyle(
            fontFamily: 'Century Gothic', fontSize: 16.0, color: Colors.white),
        caption: new TextStyle(
            fontFamily: 'Century Gothic', fontSize: 10.0, color: Colors.grey)));
