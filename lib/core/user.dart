///
/// user.dart
/// Class contains data of user
///

import 'package:flutter/material.dart';
import 'medicine.dart';
import 'doctor.dart';
import 'appointment.dart';

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
  List<Doctor> _doctorList;
  List<Appointment> _appointmentList;
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
    List<Doctor> doctorList,
    List<Appointment> appointmentList,
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
    this._doctorList = doctorList;
    this._appointmentList = appointmentList;
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

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(doctorList) => this._doctorList = doctorList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(appointmentList) => this._appointmentList = appointmentList;

  List<DateTime> getMedicineTime(Medicine medicine) {
    List<DateTime> medicineTime = List<DateTime>();
    DateTime firstTime;
    int times = medicine.totalAmount ~/ medicine.doseAmount;

    DateTime breakfastDateTime = DateTime(
      medicine.dateAdded.year,
      medicine.dateAdded.month,
      medicine.dateAdded.day,
      this._userSettings.breakfastTime.inHours,
      this._userSettings.breakfastTime.inMinutes % 60,
    );

    DateTime lunchDateTime = DateTime(
      medicine.dateAdded.year,
      medicine.dateAdded.month,
      medicine.dateAdded.day,
      this._userSettings.lunchTime.inHours,
      this._userSettings.lunchTime.inMinutes % 60,
    );

    DateTime dinnerDateTime = DateTime(
      medicine.dateAdded.year,
      medicine.dateAdded.month,
      medicine.dateAdded.day,
      this._userSettings.dinnerTime.inHours,
      this._userSettings.dinnerTime.inMinutes % 60,
    );

    DateTime nightDateTime = DateTime(
      medicine.dateAdded.year,
      medicine.dateAdded.month,
      medicine.dateAdded.day,
      this._userSettings.nightTime.inHours,
      this._userSettings.nightTime.inMinutes % 60,
    );

    if (medicine.dateAdded.compareTo(breakfastDateTime) < 0) {
      firstTime = breakfastDateTime;
    } else if (medicine.dateAdded.compareTo(lunchDateTime) < 0) {
      firstTime = lunchDateTime;
    } else if (medicine.dateAdded.compareTo(dinnerDateTime) < 0) {
      firstTime = dinnerDateTime;
    } else if (medicine.dateAdded.compareTo(nightDateTime) < 0) {
      firstTime = nightDateTime;
    } else {
      firstTime = breakfastDateTime.add(Duration(days: 1));
    }

    List<Duration> durations = <Duration>[
      this._userSettings.lunchTime - this._userSettings.breakfastTime,
      this._userSettings.dinnerTime - this._userSettings.lunchTime,
      this._userSettings.nightTime - this._userSettings.dinnerTime,
      Duration(days: 1) - this._userSettings.nightTime + this._userSettings.breakfastTime,
    ];

    for (int i = 0; i < times; i++) {
      medicineTime.add(firstTime);
      firstTime.add(durations[i % 4]);
    }

    return medicineTime;
  }
}

class UserSettings {
  static const Duration _defaultBreakfastTime = Duration(
    hours: 7,
    minutes: 0,
  );
  static const Duration _defaultLunchTime = Duration(
    hours: 12,
    minutes: 0,
  );
  static const Duration _defaultDinnerTime = Duration(
    hours: 18,
    minutes: 0,
  );
  static const Duration _defaultNightTime = Duration(
    hours: 22,
    minutes: 0,
  );

  Duration _breakfastTime;
  Duration _lunchTime;
  Duration _dinnerTime;
  Duration _nightTime;

  UserSettings({
    Duration breakfastTime,
    Duration lunchTime,
    Duration dinnerTime,
    Duration nightTime,
  }) {
    this._breakfastTime = breakfastTime;
    this._lunchTime = lunchTime;
    this._dinnerTime = dinnerTime;
    this._nightTime = nightTime;
  }

  Duration get breakfastTime => this._breakfastTime;
  set breakfastTime(breakfastTime) => this._breakfastTime = breakfastTime;

  Duration get lunchTime => this._lunchTime;
  set lunchTime(lunchTime) => this._lunchTime = lunchTime;

  Duration get dinnerTime => this._dinnerTime;
  set dinnerTime(dinnerTime) => this._dinnerTime = dinnerTime;

  Duration get nightTime => this._nightTime;
  set nightTime(nightTime) => this._nightTime = nightTime;

  void resetDefault() {
    this._breakfastTime = UserSettings._defaultBreakfastTime;
    this._lunchTime = UserSettings._defaultLunchTime;
    this._dinnerTime = UserSettings._defaultDinnerTime;
    this._nightTime = UserSettings._defaultNightTime;
  }
}
