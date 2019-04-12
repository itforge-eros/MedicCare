// Test for User class

import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user_settings.dart';
import 'package:mediccare/core/user.dart';

import 'package:test/test.dart';

void main() {
  User user;

  test('Create User', () {
    user = User(
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
      ],
      appointmentList: List<Appointment>(),
      doctorList: List<Doctor>(),
      hospitalList: List<Hospital>(),
      userSettings: UserSettings(),
    );
  });

  test('Get User ID', () {
    expect(user.id, '60070183');
  });
}
