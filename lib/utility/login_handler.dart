import 'package:compass_try03/utility/rest_datasource.dart';
import 'package:compass_try03/model/user_model.dart';



abstract class ThyLoginContract {
  void onLoginSuccess(ThyUser user);
  void onLoginFailure(String errorMessage);
}



class ThyLoginHandler {


  ThyLoginContract _contract;
  ThyLoginHandler(this._contract);

  ThyRestDatasource api = new ThyRestDatasource();


  performLogin(String email, String password) {
    api.login(email, password).then((ThyUser user) {
      _contract.onLoginSuccess(user);
    }).catchError((exception) => _contract.onLoginFailure(exception.toString()));
  }

  
}