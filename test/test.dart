///
/// `test.dart`
/// File for testing application logics and algorithms
///

import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/util/validator.dart';

void main() {
  medicineScheduleTest();
  // emailTest();
}

void medicineScheduleTest() {
  User user = User(
    id: '60070183',
    email: 'teerapat_saint@hotmai.com',
    firstName: 'Teerapat',
    lastName: 'Kraisrisirikul',
    birthDate: DateTime(1999, 6, 15),
    gender: 'male',
    height: 172.0,
    weight: 53.0,
    image: null,
    medicineList: <Medicine>[
      Medicine(
        id: '1',
        name: 'Dibendryl',
        description: '',
        type: 'tablet',
        image: null,
        doseAmount: 1,
        totalAmount: 10,
        medicineSchedule: MedicineSchedule(
          time: [true, true, true, false],
          day: [true, true, true, true, true, true, true],
          isBeforeMeal: false,
        ),
      ),
      Medicine(
        id: '2',
        name: 'Isotetronoine',
        description: '',
        type: 'tablet',
        image: null,
        doseAmount: 1,
        totalAmount: 10,
        medicineSchedule: MedicineSchedule(
          time: [false, false, true, false],
          day: [true, false, true, false, true, false, true],
          isBeforeMeal: false,
        ),
      ),
    ],
    appointmentList: List<Appointment>(),
    doctorList: List<Doctor>(),
    hospitalList: List<Hospital>(),
    userSettings: UserSettings(),
  );

  List<MedicineOverviewItem> medicineOverview = user.getMedicineOverview();

  for (int i = 0; i < medicineOverview.length; i++) {
    print(medicineOverview[i].toString());
  }
}

void emailTest() {
  List<String> emails = [
    'teerapat_saint@hotmail.com',
    'wiput.pootong@gmail.com',
    '60070183@kmitl.ac.th',
    'hello@mail.com',
    'hello@mail',
    'hello@.com',
    'hello.mail.com',
    '@mail.com',
    '@.com',
    '@',
  ];

  for (int i = 0; i < emails.length; i++) {
    print(emails[i] + ' is ' + Validator.isEmail(emails[i]).toString());
  }
}
