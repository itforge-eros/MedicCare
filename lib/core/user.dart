///
/// user.dart
/// Class contains data of user
///

import 'package:flutter/material.dart';
import 'appointment.dart';
import 'doctor.dart';
import 'hospital.dart';
import 'medicine.dart';
import 'user_settings.dart';

class User {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  DateTime _birthDate;
  double _height;
  double _weight;
  Image _image;
  List<Medicine> _medicineList;
  List<Appointment> _appointmentList;
  List<Doctor> _doctorList;
  List<Hospital> _hospitalList;
  UserSettings _userSettings;

  User({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime birthDate,
    String gender,
    double height,
    double weight,
    Image image,
    List<Medicine> medicineList,
    List<Appointment> appointmentList,
    List<Doctor> doctorList,
    List<Hospital> hospitalList,
    UserSettings userSettings,
  }) {
    this._id = id;
    this._email = email;
    this._firstName = firstName;
    this._lastName = lastName;
    this._birthDate = birthDate;
    this._gender = gender;
    this._height = height;
    this._weight = weight;
    this._image = image;
    this._medicineList = medicineList;
    this._appointmentList = appointmentList;
    this._doctorList = doctorList;
    this._hospitalList = hospitalList;
    this._userSettings = userSettings;
  }

  String get id => this._id;
  set id(id) => this._id = id;

  String get email => this._email;
  set email(email) => this._email = email;

  String get firstName => this._firstName;
  set firstName(firstName) => this._firstName = firstName;

  String get lastName => this._lastName;
  set lastName(lastName) => this._lastName = lastName;

  String get gender => this._gender;
  set gender(gender) => this._gender = gender;

  DateTime get birthDate => this._birthDate;
  set birthDate(birthDate) => this._birthDate = birthDate;

  double get height => this._height;
  set height(height) => this._height = height;

  double get weight => this._weight;
  set weight(weight) => this._weight = weight;

  Image get image => this._image;
  set image(image) => this._image = image;

  List<Medicine> get medicineList => this._medicineList;
  set medicineList(medicineList) => this._medicineList = medicineList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(appointmentList) => this._appointmentList = appointmentList;

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(doctorList) => this._doctorList = doctorList;

  List<Hospital> get hospitalList => this._hospitalList;
  set hospitalList(hospitalList) => this._hospitalList = hospitalList;

  List<DateTime> getMedicineTime(Medicine medicine) {
    final List<DateTime> firstDayMedicineTime = List<DateTime>();
    final List<Duration> durations = List<Duration>();
    final List<DateTime> medicineTime = List<DateTime>();

    DateTime firstMedicineTime;
    final int times = medicine.totalAmount ~/ medicine.doseAmount;
    int offset;

    // Logic: Calculate `firstDayMedicineTime`
    if (medicine.medicineTime.breakfast) {
      firstDayMedicineTime.add(
        DateTime(
          medicine.dateAdded.year,
          medicine.dateAdded.month,
          medicine.dateAdded.day,
          this._userSettings.breakfastTime.inHours,
          this._userSettings.breakfastTime.inMinutes % 60,
        ),
      );
    }
    if (medicine.medicineTime.lunch) {
      firstDayMedicineTime.add(
        DateTime(
          medicine.dateAdded.year,
          medicine.dateAdded.month,
          medicine.dateAdded.day,
          this._userSettings.lunchTime.inHours,
          this._userSettings.lunchTime.inMinutes % 60,
        ),
      );
    }
    if (medicine.medicineTime.dinner) {
      firstDayMedicineTime.add(
        DateTime(
          medicine.dateAdded.year,
          medicine.dateAdded.month,
          medicine.dateAdded.day,
          this._userSettings.dinnerTime.inHours,
          this._userSettings.dinnerTime.inMinutes % 60,
        ),
      );
    }
    if (medicine.medicineTime.night) {
      firstDayMedicineTime.add(
        DateTime(
          medicine.dateAdded.year,
          medicine.dateAdded.month,
          medicine.dateAdded.day,
          this._userSettings.nightTime.inHours,
          this._userSettings.nightTime.inMinutes % 60,
        ),
      );
    }

    // Logic: Calculate `durations`
    for (int i = 0; i < firstDayMedicineTime.length - 1; i++) {
      durations.add(
        Duration(
              hours: firstDayMedicineTime[i + 1].hour,
              minutes: firstDayMedicineTime[i + 1].minute,
            ) -
            Duration(
              hours: firstDayMedicineTime[i].hour,
              minutes: firstDayMedicineTime[i].minute,
            ),
      );
    }
    durations.add(
      Duration(days: 1) -
          Duration(
            hours: firstDayMedicineTime[firstDayMedicineTime.length - 1].hour,
            minutes: firstDayMedicineTime[firstDayMedicineTime.length - 1].minute,
          ) +
          Duration(
            hours: firstDayMedicineTime[0].hour,
            minutes: firstDayMedicineTime[0].minute,
          ),
    );

    // Logic: Calculate `firstMedicineTime`
    for (int i = 0; i < firstDayMedicineTime.length; i++) {
      if (medicine.dateAdded.compareTo(firstDayMedicineTime[i]) < 0) {
        firstMedicineTime = firstDayMedicineTime[i];
        offset = i;
        break;
      }
    }
    if (medicine.dateAdded.compareTo(firstDayMedicineTime[firstDayMedicineTime.length - 1]) >= 0) {
      firstMedicineTime = firstDayMedicineTime[0].add(Duration(days: 1));
      offset = 0;
    }

    // Logic: Calculate `medicineTime` (Using `durations` and `firstMedicineTime`)
    for (int i = 0; i < times; i++) {
      medicineTime.add(firstMedicineTime);
      firstMedicineTime = firstMedicineTime.add(durations[(i + offset) % durations.length]);
    }

    return medicineTime;
  }
}
