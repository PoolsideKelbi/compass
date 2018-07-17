import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/login_handler.dart';
import 'package:compass_try03/utility/auth_handler.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants;
import 'package:compass_try03/utility/connectivity_handler.dart' show isOffline;

import 'package:flutter/material.dart';



class ThyLoginScreen extends StatefulWidget {
  @override
  ThyLoginScreenState createState() => new ThyLoginScreenState();
}



class ThyLoginScreenState extends State<ThyLoginScreen> implements ThyLoginContract {


  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;
  bool _isLoading = false;
  bool _isFailure = false;


  ThyLoginHandler _loginHandler;
  ThyLoginScreenState() { _loginHandler = new ThyLoginHandler(this); }


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  String emailValidator(value) {
    String exp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(exp);
    if (isOffline) return constants.Connection.connection_none;
    else if (value.isEmpty) return constants.LoginScreen.email_error_empty;
    else if (!regExp.hasMatch(value)) return constants.LoginScreen.email_error_invalid;
    else if (_isFailure) return constants.LoginScreen.email_error_incorrect;
    else return null;
  }

  String passwordValidator(value) {
    String exp = r'^[a-zA-Z0-9_]*$';
    RegExp regExp = new RegExp(exp);
    if (isOffline) return null;
    else if (value.isEmpty) return constants.LoginScreen.password_error_empty;
    else if (value.length < 8) return constants.LoginScreen.password_error_short;
    else if (!regExp.hasMatch(value)) return constants.LoginScreen.password_error_alphanum;
    else return null;
  }


  @override
  Widget build(context) {

    var logoImage = new Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 10.0),
      child: new Image(
        image: new AssetImage(constants.Assets.compass_logo_image_path),
      ),
    );

    var loginLabel = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Text(
        constants.LoginScreen.login_label_text,
        style: Theme.of(context).textTheme.title,
      ),
    );

    var emailField = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new TextFormField(
        controller: emailController,
        validator: emailValidator,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _email = value,
        style: Theme.of(context).textTheme.body1,
        decoration: new InputDecoration(
          hintText: constants.LoginScreen.email_hinttext,
        ),
      ),
    );

    var passwordField = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new TextFormField(
        controller: passwordController,
        validator: passwordValidator,
        obscureText: true,
        keyboardType: TextInputType.text,
        onSaved: (value) => _password = value,
        style: Theme.of(context).textTheme.body1,
        decoration: new InputDecoration(
          hintText: constants.LoginScreen.password_hinttext,
        ),
      ),
    );

    var loginButton = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new RaisedButton(
        onPressed: _isLoading ? null 
                              : _submit,
        child: _isLoading
            ? new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new LinearProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation(Colors.teal[200]),
                ),
              )
            : new Text(
                constants.LoginScreen.login_button_text,
                style: Theme.of(context).textTheme.button,
              ),
      ),
    );

    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: AssetImage(constants.Assets.background_path),
          fit: BoxFit.cover)),
        child: new Scaffold(
          key: _scaffoldKey,
          body: new Column(
          children: <Widget>[
            new Expanded(child: logoImage),
            new Form(
              key: _formKey,
              child: new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    loginLabel,
                    emailField,
                    passwordField,
                    loginButton
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _submit() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      setState(() => _isLoading = true);
      formState.save();
      _loginHandler.performLogin(_email, _password);
    }
  }


  @override
  void onLoginSuccess(ThyUser user) {
    setState(() => _isLoading = false);
    loggenInUser = user;
    emailController.clear();
    passwordController.clear();
    Navigator.of(context).pushReplacementNamed('home');
  }

  @override
  void onLoginFailure(String errorText) {
    setState(() => _isLoading = false);
    _isFailure = true;
    _formKey.currentState.validate();
    _isFailure = false;
  }

  
}