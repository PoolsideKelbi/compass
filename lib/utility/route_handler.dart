import 'package:compass_try03/view/home_screen.dart';
import 'package:compass_try03/view/login_screen.dart';

import 'package:flutter/material.dart';


class _ThyPageRoute<T> extends MaterialPageRoute<T> {


  _ThyPageRoute({RouteSettings settings, WidgetBuilder builder})
  : super(settings: settings, builder: builder);


  Duration transitionDuration = new Duration(milliseconds: 400);


  @override
  Widget buildTransitions(context, enterAnimation, exitAnimation, child) {
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }


}



Route getRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login' : return _buildRoute(settings, new ThyLoginScreen());
    case 'home': return _buildRoute(settings, new  ThyHomeScreen());
    default      : return null;
  }
}

_ThyPageRoute _buildRoute(RouteSettings settings, Widget child) {
  return new _ThyPageRoute(
    settings: settings,
    builder: (context) => child,
  );
}