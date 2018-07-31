class ThyUser {


  String _name;
  String _email;
  String _serverName;


  String get email => _email;
  String get name => _name;
  String get server => _serverName;


  ThyUser(this._name, this._email, this._serverName);

  ThyUser.fromMap(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
  }

  
}