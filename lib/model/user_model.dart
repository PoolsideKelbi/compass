class ThyUser {


  String _name;
  String _email;


  String get email => _email;
  String get name => _name;


  ThyUser(this._name, this._email);

  ThyUser.fromMap(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
  }

  
}