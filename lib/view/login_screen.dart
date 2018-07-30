import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/login_handler.dart';
import 'package:compass_try03/utility/auth_handler.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants show LoginScreen, Connection, Assets;
import 'package:compass_try03/utility/connectivity_handler.dart' show isOffline;

import 'package:flutter/material.dart';



class ThyLoginScreen extends StatefulWidget {
  @override
  ThyLoginScreenState createState() => new ThyLoginScreenState();
}



class ThyLoginScreenState extends State<ThyLoginScreen> implements ThyLoginContract {


  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool _isLoading = false;
  bool _isFailure = false;
  String _failureText;


  final FocusNode _passwordFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();


  ThyLoginHandler _loginHandler;
  ThyLoginScreenState() { _loginHandler = new ThyLoginHandler(this); }


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _serverController = new TextEditingController();


  String _emailValidator(value) {
    String exp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(exp);
    if (isOffline) return constants.Connection.connection_none;
    else if (value.isEmpty) return constants.LoginScreen.email_error_empty;
    else if (!regExp.hasMatch(value)) return constants.LoginScreen.email_error_invalid;
    else if (_isFailure) return _failureText;
    else return null;
  }

  String _passwordValidator(value) {
    String exp = r'^[a-zA-Z0-9_.@]*$';
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
        focusNode: _emailFocusNode,
        controller: _emailController,
        validator: _emailValidator,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.body1,
        decoration: new InputDecoration(
          hintText: constants.LoginScreen.email_hinttext,
          hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.white70)
        ),
        onFieldSubmitted: (value) {
          if(_passwordController.text == '') FocusScope.of(context).requestFocus(_passwordFocusNode);
          else {
            _submit();
          }
        },
      ),
    );

    var passwordField = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new TextFormField(
        focusNode: _passwordFocusNode,
        controller: _passwordController,
        validator: _passwordValidator,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body1,
        decoration: new InputDecoration(
          hintText: constants.LoginScreen.password_hinttext,
          hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.white70)
        ),
        onFieldSubmitted: (value) {
          if(_emailController.text == '') FocusScope.of(context).requestFocus(_emailFocusNode);
          else {
            _submit();
          }
        },
      ),
    );

    var serverField = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new TextFormField(
        controller: _serverController,
        obscureText: false,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.body1,
        decoration: new InputDecoration(
          hintText: constants.LoginScreen.server_hinttext,
          hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.white70)
        ),
        onFieldSubmitted: (value) {
          if(_emailController.text == '') FocusScope.of(context).requestFocus(_emailFocusNode);
          else if(_passwordController.text == '') FocusScope.of(context).requestFocus(_passwordFocusNode);
          else _submit();
        },
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
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerLeft
        )
      ),
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
                  serverField,
                  loginButton,
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@override
void dispose() {
  super.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  _serverController.dispose();
  _emailFocusNode.dispose();
  _passwordFocusNode.dispose();
}

  void _submit() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      setState(() => _isLoading = true);
      formState.save();
      _loginHandler.performLogin(_emailController.text, _passwordController.text);
    }
  }


  @override
  void onLoginSuccess(ThyUser user) {
    setState(() => _isLoading = false);
    loggedInUser = user;
    _emailController.clear();
    _passwordController.clear();
    _serverController.clear();
    Navigator.of(context).pushReplacementNamed('home');
  }

  @override
  void onLoginFailure(Exception exception) {
    setState(() => _isLoading = false);
    _isFailure = true;
    _failureText = exception.toString().substring(11);
    _formKey.currentState.validate();
    _isFailure = false;
  }

  
}