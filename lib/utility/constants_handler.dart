abstract class LoginScreen {
  static const String email_hinttext = 'Email';
  static const String email_error_empty = 'Email field is left empty.';
  static const String email_error_invalid = 'Email is not valid.';

  static const String password_hinttext = 'Password';
  static const String password_error_empty = 'Password field is left empty.';
  static const String password_error_short = 'Password must contain 8 characters or more.';
  static const String password_error_alphanum = 'Password must contain only alphanumeric characters.';

  static const String server_hinttext = 'Server address';

  static const String login_button_text = 'LOGIN';
  static const String login_label_text = 'Please login';
}



abstract class HomeScreen {
  static const String logout_button_text = 'LOGOUT';
}



abstract class Connection {
  static const String connection_none = 'You are not connected to the internet.';
}




abstract class DialogWidget {
  static const String yes_title_text = 'Thank You!';
  static const String yes_description_text = 'Your scan result:\n\n{r}';

  static const String no_title_text = 'Warning!';
  static const String no_description_text = 'A problem occured during your QR scan. {r}';

  static const String ok_button_text = 'OK';
}



abstract class Assets {
  static const String compass_logo_image_path = 'assets/compass.png';
  static const String qr_image_path = 'assets/qr-code.png';
  static const String background_path = 'assets/background.jpg';
}



abstract class ResponseErrors {
  static const String login_error_incorrect = 'Email or password is incorrect.';
}