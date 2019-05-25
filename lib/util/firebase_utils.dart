///
/// `firestore_utils.dart`
/// Class contains Firestore utils
///

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';

class FirebaseUtils {
  // User
  static Future<User> getUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    var firestore = Firestore.instance;

    DocumentSnapshot userProfile =
        await firestore.collection('users').document(firebaseUser.uid).get();

    UserSettings userSetting =
        UserSettings.fromMap(userProfile['userSettings']);

    User user = User(
      email: firebaseUser.email,
      firstName: userProfile['firstName'],
      lastName: userProfile['lastName'],
      birthDate: userProfile['birthDate'],
      bloodGroup: userProfile['bloodGroup'],
      gender: userProfile['gender'],
      height: userProfile['height'].toDouble(),
      weight: userProfile['weight'].toDouble(),
      userSettings: userSetting,
      id: firebaseUser.uid,
    );

    return user;
  }

  static Future<bool> getUserExist() async {
    FirebaseUser firebaseUSer = await FirebaseAuth.instance.currentUser();

    var firestore = Firestore.instance;

    DocumentSnapshot userProfile =
        await firestore.collection('users').document(firebaseUSer.uid).get();

    return userProfile.exists;
  }

  static Future<String> getUserId() async {
    FirebaseUser firebaseUSer = await FirebaseAuth.instance.currentUser();

    return firebaseUSer.uid;
  }

  static Future<bool> isLogin() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

    return firebaseUser != null;
  }

  static void updateUserData(User user) {
    Map<String, dynamic> map = user.toMap();
    map.remove('id');

    Firestore.instance.collection('users').document(user.id).setData(map);
  }

  static void createUserData(String id, String email) {
    Map<String, dynamic> map = User(email: email).toMap();
    map.remove('id');

    Firestore.instance.collection('users').document(id).setData(map);
  }

  // End User

  // Doctor

  static Future<List<Doctor>> getDoctors() async {
    String userId = await getUserId();

    var firestore = Firestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection('users')
        .document(userId)
        .collection('doctors')
        .getDocuments();

    List<Doctor> doctors = List();

    snapshot.documents.forEach((d) {
      Doctor doctor = Doctor.fromMap(d.data);

      doctor.id = d.documentID;

      doctors.add(doctor);
    });

    return doctors;
  }

  static Future<String> addDoctor(Doctor doctor) async {
    String userId = await getUserId();

    Map<String, dynamic> map = doctor.toMap();
    map.remove('id');

    var firestore = Firestore.instance;

    DocumentReference doctorRef = await firestore
        .collection('users')
        .document(userId)
        .collection('doctors')
        .add(map);

    String doctorId = doctorRef.documentID;

    return doctorId;
  }

  static void updateDoctor(Doctor doctor) async {
    String userId = await getUserId();

    Map<String, dynamic> map = doctor.toMap();
    String doctorId = doctor.id;
    map.remove('id');

    var firestore = Firestore.instance;

    firestore
        .collection('users')
        .document(userId)
        .collection('doctors')
        .document(doctorId)
        .setData(map);
  }

  static void deleteDoctor(Doctor doctor) async {
    String userId = await getUserId();

    Map<String, dynamic> map = doctor.toMap();
    String doctorId = doctor.id;
    map.remove('id');

    var firestore = Firestore.instance;

    firestore
        .collection('users')
        .document(userId)
        .collection('doctors')
        .document(doctorId)
        .delete();
  }

  // End Doctor

}
