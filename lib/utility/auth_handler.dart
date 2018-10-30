import 'package:compassscan/model/user_model.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';



ThyUser _loggedInUser;

ThyUser get loggedInUser => _loggedInUser;
set loggedInUser(ThyUser user) {
  _loggedInUser = user;
  setLoggedInUser(user);
}


initialize() async {
  await getLoggedInUser().then((thing) {
    thing['name'] == null ? loggedInUser = ThyUser.mock() : loggedInUser = ThyUser(thing['name'],thing['email']);
  });
}


setLoggedInUser(ThyUser user) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('name', user.name);
  preferences.setString('email', user.email);
}

Future<Map> getLoggedInUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String name = preferences.getString('name');
  String email = preferences.getString('email');
  return {'name' : name, 'email' : email};
}