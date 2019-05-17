///
/// `firestore_utils.dart`
/// Class contains Firestore utils
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine_overview_data.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/core/user.dart';

class FirestoreUtils {
  static void createUser(String id, String email) {
    Map<String, dynamic> map = User(email: email).toMap();
    map.remove('id');

    Firestore.instance.collection('users').document(id).setData(map);
  }

  static Future<DocumentSnapshot> getUser(String id) async {
    return await Firestore.instance.collection('users').document(id).get();
  }
}
