import 'package:compass_try03/model/user_model.dart';
import 'package:compass_try03/utility/auth_handler.dart';
import 'package:compass_try03/utility/scan_handler.dart';
import 'package:compass_try03/utility/constants_handler.dart' as constants;
import 'package:compass_try03/utility/connectivity_handler.dart' show isOffline;
import 'package:compass_try03/view/dialog_widget.dart';

import 'package:flutter/material.dart';



class ThyHomeScreen extends StatefulWidget {
  ThyHomeScreenState createState() => new ThyHomeScreenState(loggenInUser);
}



class ThyHomeScreenState extends State<ThyHomeScreen> implements ThyScanContract {


  ThyUser _user;

  bool _isLoading = false;


  ThyScanHandler _scanHandler;
  ThyHomeScreenState(this._user) { _scanHandler = new ThyScanHandler(this); }


  @override
  Widget build(context) {

    var logoImage = new Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 60.0, 50.0, 30.0),
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
              isOffline ? this.onScanFailure(Exception(constants.Connection.connection_none)) 
                        : _scanHandler.performScan(_user.email);
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
          loggenInUser = null;
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
      body: new Ink(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: AssetImage(constants.Assets.background_path),
                fit: BoxFit.cover)),
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
  void onScanSuccess(String qrText) {
    setState(() => _isLoading = false);
    qrText == null ? null 
                   : showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new SimpleDialog(
            children: <Widget>[new ThyDialogContent.sayingYes(qrText)],
            contentPadding: EdgeInsets.all(0.0),
      ),
    );
  }

  @override
  void onScanFailure(Exception exception) {
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new SimpleDialog(
        children: <Widget>[new ThyDialogContent.sayingNo(exception.toString().substring(11))],
        contentPadding: EdgeInsets.all(0.0),
      ),
    );
  }


}
