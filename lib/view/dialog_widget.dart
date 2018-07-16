import 'package:compass_try03/utility/constants_handler.dart' as constants;

import 'package:flutter/material.dart';



class ThyDialogContent extends StatelessWidget {


  MaterialColor thyColor;
  IconData thyIcon;
  String thyTitle;
  String thyDescription;


  ThyDialogContent.sayingYes(String qrText) {
    thyColor = Colors.green;
    thyIcon = Icons.check;
    thyTitle = constants.DialogWidget.yes_title_text;
    thyDescription = constants.DialogWidget.yes_description_text.replaceFirst('{r}', qrText);
  }

  ThyDialogContent.sayingNo(String errorText) {
    thyColor = Colors.red;
    thyIcon = Icons.warning;
    thyTitle = constants.DialogWidget.no_title_text;
    thyDescription = constants.DialogWidget.no_description_text.replaceFirst('{r}', errorText);
  }


  @override
  Widget build(BuildContext context) {

    var logoContainer = new Ink(
      height: 100.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [thyColor[500], thyColor[300]])
      ),
      child: new Icon(thyIcon),
    );

    var titleLabel = new Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
      child: new Text(
        thyTitle,
        style: new TextStyle(color: thyColor[400], fontSize: 25.0),
        textAlign: TextAlign.center,
      ),
    );

    var descriptionLabel = new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: new Text(
        thyDescription,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );

    var okButton = new Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
      child: new RaisedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: new Text(
          constants.DialogWidget.ok_button_text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        logoContainer,
        new Column(
          children: <Widget>[titleLabel, descriptionLabel, okButton],
        )
      ],
    );
  }


}
