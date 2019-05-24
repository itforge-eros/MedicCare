import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';

class UserProvider {
  Future<User> getUser() async {
    FirebaseUser firebaseUSer = await FirebaseAuth.instance.currentUser();

    var firestore = Firestore.instance;

    DocumentSnapshot userProfile =
        await firestore.collection('users').document(firebaseUSer.uid).get();

    UserSettings userSetting =
        UserSettings.fromMap(userProfile['userSettings']);

    User user = User(
      email: firebaseUSer.email,
      firstName: userProfile['firstName'],
      lastName: userProfile['lastName'],
      birthDate: userProfile['birthDate'],
      bloodGroup: userProfile['bloodGroup'],
      gender: userProfile['gender'],
      height: userProfile['height'].toDouble(),
      weight: userProfile['weight'].toDouble(),
      userSettings: userSetting,
      id: firebaseUSer.uid,
    );

    return user;
  }
}
