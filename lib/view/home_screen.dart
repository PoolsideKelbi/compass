import 'package:compassscan/model/user_model.dart';
import 'package:compassscan/utility/auth_handler.dart';
import 'package:compassscan/utility/scan_handler.dart';
import 'package:compassscan/utility/constants_handler.dart' as constants show HomeScreen, Assets;
import 'package:compassscan/view/dialog_widget.dart' show showResponseDialogWithColor;

import 'package:flutter/material.dart';



class ThyHomeScreen extends StatefulWidget {
  ThyHomeScreenState createState() => new ThyHomeScreenState(loggedInUser);
}



class ThyHomeScreenState extends State<ThyHomeScreen> implements ThyScanContract {


  ThyScanHandler _scanHandler;
  ThyHomeScreenState(this._user) { _scanHandler = new ThyScanHandler(this); }


  ThyUser _user;
  bool _isLoading = false;


  @override
  Widget build(context) {

    var logoImage = new Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 10.0),
      child: new Image(
        image: new AssetImage(constants.Assets.compass_logo_image_path),
      ),
    );

    var scanImage = new Padding(
      padding: const EdgeInsets.all(50.0),
      child: new InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          setState(() => _isLoading = true);
          _scanHandler.performScan(_user.email);
        },
        child: new Image(
          image: new AssetImage(constants.Assets.qr_image_path),
          height: 200.0,
          width: 200.0,
        ),
      ),
    );

    var nameLabel = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new Text(
        _user.name,
        style: Theme.of(context).textTheme.title,
      ),
    );

    var emailLabel = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: new Text(
        'Email: ' + _user.email,
        style: Theme.of(context).textTheme.body2,
      ),
    );

    var logoutButton = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new RaisedButton(
        onPressed: _isLoading ? null 
                              : onLogOut,
        child: _isLoading
        ? new Padding(
          padding: const EdgeInsets.all(2.0),
          child: new LinearProgressIndicator(
            valueColor: new AlwaysStoppedAnimation(Colors.teal[200]),
          ),
        )
        : new Text(
          constants.HomeScreen.logout_button_text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Ink(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage(constants.Assets.background_path),
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft
          )
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  logoImage,
                  scanImage
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  nameLabel,
                  emailLabel,
                  logoutButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void onLogOut() {
    loggedInUser = ThyUser.mock();
    Navigator.of(context).pushReplacementNamed('login');
  }


  @override
  void onRedeemSuccess(String message) {
    setState(() => _isLoading = false);
    showResponseDialogWithColor('green',
      context: context,
      message: message
    );
  }

  @override
  void onRedeemFailure(String message) {
    setState(() => _isLoading = false);
    showResponseDialogWithColor('red',
      context: context,
      message: message,
    );
  }

  @override
  void onScanFailure(Exception exception) {
    setState(() => _isLoading = false);
    showResponseDialogWithColor('red',
      context: context,
      message: exception.toString().substring(11)
    );
  }

  @override
  void onScanCancelled() {
    setState(() => _isLoading = false);
  }


}