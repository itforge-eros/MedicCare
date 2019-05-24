import 'dart:async';

import 'package:mediccare/bloc/user_provider.dart';
import 'package:mediccare/core/user.dart';

class Repository {
  final UserProvider userProvider;

  Repository(this.userProvider);

  Future<User> getUser() async {}
}
