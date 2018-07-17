import 'package:compass_try03/view/home_screen.dart';
import 'package:compass_try03/view/login_screen.dart';

import 'package:flutter/material.dart';



Route getRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login' : return _buildRoute(settings, new ThyLoginScreen());
    case 'home': return _buildRoute(settings, new  ThyHomeScreen());
    default      : return null;
  }
}

PageRouteBuilder _buildRoute(RouteSettings settings, Widget builder) {
  return new PageRouteBuilder(
    opaque: true,
    settings: settings,
    pageBuilder: (context, animation, secondAnimation) => builder,
  );
}