import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/auth_handler.dart';
import 'package:compass_try03/utility/scan_handler.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants show HomeScreen, Assets;
import 'package:compass_try03/view/dialog_widget.dart' show showResponseDialogSaying;

import 'package:flutter/material.dart';



class ThyHomeScreen extends StatefulWidget {
  ThyHomeScreenState createState() => new ThyHomeScreenState(loggedInUser);
}



class ThyHomeScreenState extends State<ThyHomeScreen> implements ThyScanContract {


  ThyUser _user;

  bool _isLoading = false;


  ThyScanHandler _scanHandler;
  ThyHomeScreenState(this._user) { _scanHandler = new ThyScanHandler(this); }


  @override
  Widget build(context) {

    var logoImage = new Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
      child: new Image(
        image: new AssetImage(constants.Assets.compass_logo_image_path),
      ),
    );

    var scanImage = new Expanded(
      child: new Center(
        child: new Padding(
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
      child: new Text(_user.email),
    );

    var logoutButton = new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new RaisedButton(
        onPressed: _isLoading ? null 
                              : () {
          loggedInUser = null;
          Navigator.of(context).pushReplacementNamed('login');
        },
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
            logoImage,
            scanImage,
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


  @override
  void onScanSuccess(String message) {
    setState(() => _isLoading = false);
    showResponseDialogSaying('yes',
      context: context,
      message: message
    );
  }

  @override
  void onScanFailure(Exception exception) {
    setState(() => _isLoading = false);
    showResponseDialogSaying('no',
      context: context,
      message: exception.toString().substring(11)
    );
  }

  @override
  void onScanCancelled() {
    setState(() => _isLoading = false);
  }


}