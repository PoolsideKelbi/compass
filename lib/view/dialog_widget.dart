import 'package:compass_try03/utility/constants_handler.dart' as constants show DialogWidget;

import 'package:flutter/material.dart';



class _ThyDialogContent extends StatelessWidget {


  final MaterialColor thyColor;
  final IconData thyIcon;
  final String thyTitle;
  final String thyDescription;


  _ThyDialogContent({this.thyColor , this.thyIcon , this.thyTitle , this.thyDescription});


  @override
  Widget build(BuildContext context) {

    var iconContainer = new Container(
      height: 100.0,
      width: 100.0,
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

    return new Container(
      width: 300.0,
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          iconContainer,
          new Column(
            children: <Widget>[titleLabel, descriptionLabel, okButton],
          )
        ],
      ),
    );
  }


}



void showResponseDialogSaying(String answer, {@required BuildContext context, String message}) {
  switch (answer) {
    case 'yes' : showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new SimpleDialog(
        contentPadding: const EdgeInsets.all(0.0),
        children: <Widget>[new _ThyDialogContent(
          thyColor: Colors.green,
          thyIcon: Icons.check_circle,
          thyTitle: constants.DialogWidget.yes_title_text,
          thyDescription: message,
        )],
      )
    );break;
    case 'no' : showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new SimpleDialog(
        contentPadding: const EdgeInsets.all(0.0),
        children: <Widget>[new _ThyDialogContent(
          thyColor: Colors.red,
          thyIcon: Icons.warning,
          thyTitle: constants.DialogWidget.no_title_text,
          thyDescription: message,
        )],
      )
    );break;
  }
}