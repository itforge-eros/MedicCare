///
/// `test.dart`
/// File for testing application logics and algorithms
///

import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine_overview_data.dart';
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
    id: '',
    email: 'teerapat_saint@hotmail.com',
    firstName: 'Teerapat',
    lastName: 'Kraisrisirikul',
    gender: 'male',
    bloodGroup: 'O+',
    birthDate: DateTime(1999, 6, 15),
    height: 172.0,
    weight: 53.0,
    image: null,
    medicineList: <Medicine>[
      Medicine(
        id: '1',
        name: 'Dibendryl',
        description: 'Cures coughing.',
        type: 'tablet',
        image: null,
        doseAmount: 1,
        totalAmount: 10,
        medicineSchedule: MedicineSchedule(
          time: [true, true, true, false],
          day: [true, true, true, true, true, true, true],
          isBeforeMeal: false,
        ),
        dateAdded: DateTime(2019, 5, 18),
      ),
      Medicine(
        id: '2',
        name: 'Isotetronoine',
        description:
            'Cures pimples. Do not take this medicine during or within 1 month before pregnancy.',
        type: 'tablet',
        image: null,
        doseAmount: 1,
        totalAmount: 10,
        medicineSchedule: MedicineSchedule(
          time: [false, false, true, false],
          day: [true, false, true, false, true, false, true],
          isBeforeMeal: false,
        ),
        dateAdded: DateTime(2019, 5, 20),
      ),
    ],
    appointmentList: List<Appointment>(),
    doctorList: List<Doctor>(),
    hospitalList: List<Hospital>(),
    userSettings: UserSettings(
      notificationOn: true,
      notifyAheadDuration: Duration(minutes: 30),
      breakfastTime: Duration(hours: 7, minutes: 15),
      lunchTime: Duration(hours: 12, minutes: 0),
      dinnerTime: Duration(hours: 19, minutes: 0),
      sleepTime: Duration(hours: 23, minutes: 0),
    ),
  );

  List<MedicineOverviewData> medicineOverview = user.getMedicineOverview();

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
