class ThyUser {


  bool _isMock = false;
  String _name;
  String _email;


  bool get isMock => _isMock;
  String get email => _email;
  String get name => _name;


  ThyUser(this._name, this._email);
  
  ThyUser.mock() { this._isMock = true; }

  ThyUser.fromMap(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
  }

  
}