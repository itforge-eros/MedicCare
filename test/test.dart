///
/// test.dart
/// File for testing application logics
///

import 'package:mediccare/core/user_settings.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/medicine_time.dart';
import 'package:mediccare/core/medicine.dart';

void main() {
  User user = User(
    medicineList: <Medicine>[
      Medicine(
        doseAmount: 3,
        totalAmount: 27,
        medicineTime: MedicineTime(
          breakfast: false,
          lunch: false,
          dinner: false,
          night: true,
          beforeMeal: false,
        ),
      ),
    ],
    userSettings: UserSettings(
      breakfastTime: Duration(
        hours: 7,
        minutes: 30,
      ),
    ),
  );

  for (int i = 0; i < user.getMedicineTime(user.medicineList[0]).length; i++) {
    print(user.getMedicineTime(user.medicineList[0])[i]);
  }
}
