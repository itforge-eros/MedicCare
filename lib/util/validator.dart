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
    } else if (password.length < 8) {
      throw PasswordLengthException();
    }
    return true;
  }

  static bool isEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());
  }

  static String validatePassword(String password, int level) {
    switch (level) {
      case 1:
        return Validator._validatePasswordLow(password);
        break;
      case 2:
        return Validator._validatePasswordMedium(password);
        break;
      case 3:
        return Validator._validatePasswordHigh(password);
        break;
      default:
        return null;
    }
  }

  static String _validatePasswordLow(String password) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String _validatePasswordMedium(String password) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!(password.contains(RegExp(r'\d'), 0) &&
        (password.contains(RegExp(r'[a-z]'), 0) || password.contains(RegExp(r'[A-Z]'), 0)))) {
      return 'Password must contain both numbers and characters';
    }
    return null;
  }

  static String _validatePasswordHigh(String password) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!(password.contains(RegExp(r'\d'), 0) &&
        password.contains(RegExp(r'[a-z]'), 0) &&
        password.contains(RegExp(r'[A-Z]'), 0))) {
      return '''Password must contain the following.
• Numbers
• Lowercase characters
• Uppercase characters''';
    }
    return null;
  }
}
