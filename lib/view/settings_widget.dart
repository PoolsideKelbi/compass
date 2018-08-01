import 'package:compass_try03/utility/constants_handler.dart' as constants show Defaults, SettingsWidget;

import 'package:flutter/material.dart';



class ThyAdvancedSettingsScreen extends StatefulWidget {
  @override
  _ThyAdvancedSettingsScreenState createState() => _ThyAdvancedSettingsScreenState();
}

class _ThyAdvancedSettingsScreenState extends State<ThyAdvancedSettingsScreen> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _isDefault = true;

  TextEditingController _serverAddressController = new TextEditingController();

  String _serverAddressValidator(String value) {
    String exp = r'[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';
    RegExp regExp = new RegExp(exp);
    if(value.isEmpty) return constants.SettingsWidget.server_error_empty;
    //TODO better regex for the url
    //else if(!regExp.hasMatch(value)) return constants.SettingsWidget.server_error_invalid;
    return null;
  }

  @override
  Widget build(BuildContext context) {

    var bar = new AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: new Text(
        constants.SettingsWidget.appbar_title,
        style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black),
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.check),
          onPressed: () {
            if(_isDefault) {
              Navigator.of(context).pop(constants.Defaults.default_base_url);
            }
            else {
              if(_formKey.currentState.validate()) {
                Navigator.of(context).pop(_serverAddressController.text);
              }
            }
          },
        )
      ],
    );

    var serverSettings = new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              constants.SettingsWidget.default_server_label,
              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black),
            ),
            new Switch(
              activeColor: Colors.teal[200],
              value: _isDefault,
              onChanged: (value) => setState(() =>_isDefault = value),
            )
          ],
        ),
        new Divider(
          color: Colors.grey,
          height: 5.0,
        ),
        _isDefault ? new Center() : new Form(
          key: _formKey,
          child: new TextFormField(
            decoration: new InputDecoration(
              hintStyle: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
              hintText: constants.SettingsWidget.server_hinttext,
            ),
            keyboardType: TextInputType.url,
            validator: _serverAddressValidator,
            controller: _serverAddressController,
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black),
          ),
        )
      ],
    );

    var body = new Padding(
      padding: const EdgeInsets.all(10.0),
      child: serverSettings,
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      appBar: bar,
      body: body,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _serverAddressController.dispose();
  }

}



