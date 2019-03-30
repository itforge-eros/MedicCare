///
/// `session.dart`
/// Class contains data of application session
///

import 'package:mediccare/core/user.dart';

class Session {
  static User _user;

  User get user => Session._user;
  set user(User user) => Session._user = user;
}
