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
    DateTime firstDay;
    Duration firstTime;
    final List<Duration> oneDayTime = List<Duration>();
    final List<Duration> durations = List<Duration>();
    final List<DateTime> medicineTime = List<DateTime>();
    int offset = 0;

    // Logic: Calculate `firstDay`
    firstDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    while (!medicine.medicineTime.day[firstDay.weekday - 1]) {
      firstDay = firstDay.add(Duration(days: 1));
    }

    // Logic: Calculate `firstTime`
    for (int i = 0; i < 4; i++) {
      if (DateTime.now().day != firstDay.day) {
        firstTime = this._userSettings.userTime[medicine.medicineTime.time.indexOf(true)];
        offset = 0;
        break;
      }

      if (!medicine.medicineTime.time[i]) {
        offset--;
      } else if (Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
          ) <
          this._userSettings.userTime[i]) {
        firstTime = this._userSettings.userTime[i];
        offset += i;
        break;
      }
    }

    // Logic: Calculate `oneDayTime`
    for (int i = 0; i < 4; i++) {
      if (medicine.medicineTime.time[i]) {
        oneDayTime.add(this._userSettings.userTime[i]);
      }
    }

    // Logic: Calculate `durations`
    for (int i = 0; i < oneDayTime.length - 1; i++) {
      durations.add(oneDayTime[i + 1] - oneDayTime[i]);
    }
    durations.add(Duration(days: 1) -
        oneDayTime[oneDayTime.length - 1] +
        oneDayTime[0]);

    // Logic: Calculate `medicineTime`
    firstDay = firstDay.add(firstTime);
    for (int i = 0; i < (medicine.totalAmount / medicine.doseAmount).ceil(); i++) {
      medicineTime.add(firstDay);
      firstDay = firstDay.add(durations[(i + offset) % durations.length]);

      while (!medicine.medicineTime.day[firstDay.weekday - 1]) {
        firstDay = firstDay.add(Duration(days: 1));
      }
    }

    return medicineTime;
  }
}
