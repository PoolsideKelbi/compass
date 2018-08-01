import 'package:compass_try03/view/home_screen.dart';
import 'package:compass_try03/view/login_screen.dart';
import 'package:compass_try03/view/settings_widget.dart';

import 'package:flutter/material.dart';


class _ThyPageRoute<T> extends MaterialPageRoute<T> {


  _ThyPageRoute({RouteSettings settings, WidgetBuilder builder, bool fullscreenDialog})
  : super(settings: settings, builder: builder, fullscreenDialog: fullscreenDialog);


  Duration transitionDuration = new Duration(milliseconds: 400);


  @override
  Widget buildTransitions(context, enterAnimation, exitAnimation, child) {
    if(fullscreenDialog) return new SlideTransition(
      position: new Tween<Offset>(
        begin: new Offset(0.0, 1.0),
        end: Offset.zero
      ).animate(new CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn
      )),
      child: child,
    );
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
    case 'settings': return _buildRoute(settings, new ThyAdvancedSettingsScreen(), fullscreenDialog: true);
    default      : return null;
  }
}

_ThyPageRoute _buildRoute(RouteSettings settings, Widget child, {bool fullscreenDialog = false}) {
  return new _ThyPageRoute(
    settings: settings,
    builder: (context) => child,
    fullscreenDialog: fullscreenDialog
  );
}