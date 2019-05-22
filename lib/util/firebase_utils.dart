///
/// `firestore_utils.dart`
/// Class contains Firestore utils
///

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';

class FirebaseUtils {
  static Future<User> getUser() async {
    FirebaseUser firebaseUSer = await FirebaseAuth.instance.currentUser();

    var firestore = Firestore.instance;

    DocumentSnapshot userProfile =
        await firestore.collection('users').document(firebaseUSer.uid).get();

    print(userProfile['userSettings']);

    UserSettings userSetting =
        UserSettings.fromMap(userProfile['userSettings']);

    User user = User(
        email: firebaseUSer.email,
        firstName: userProfile['firstName'],
        lastName: userProfile['lastName'],
        birthDate: DateTime.parse(userProfile['birthDate']),
        bloodGroup: userProfile['bloodGroup'],
        gender: userProfile['gender'],
        height: userProfile['height'].toDouble(),
        weight: userProfile['weight'].toDouble(),
        userSettings: userSetting,
        id: firebaseUSer.uid);

    return user;
  }

  static void createUserData(String id, String email) {
    Map<String, dynamic> map = User(email: email).toMap();
    map.remove('id');

    Firestore.instance.collection('users').document(id).setData(map);
  }
}
