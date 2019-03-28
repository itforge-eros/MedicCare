///
/// `validator.dart`
/// Class contains static methods to validate values
///

import 'package:mediccare/exceptions.dart';

class Validator {
  static bool validateRegister(String email, String password, String passwordConfirm) {
    if (email.trim() == '' || password == '' || passwordConfirm == '') {
      throw EmptyFieldException();
    } else if (!isEmail(email.trim())) {
      throw InvalidEmailAddressException();
    } else if (password != passwordConfirm) {
      throw MismatchPasswordFieldsException();
    } else if (password.length < 6) {
      throw PasswordLengthException();
    }
    return true;
  }

  static bool isEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());
  }
}
