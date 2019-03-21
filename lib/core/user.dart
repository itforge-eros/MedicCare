///
/// user.dart
/// Class contains data of user
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user_settings.dart';

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
    this._medicineList = medicineList ?? List<Medicine>();
    this._appointmentList = appointmentList ?? List<Appointment>();
    this._doctorList = doctorList ?? List<Doctor>();
    this._hospitalList = hospitalList ?? List<Hospital>();
    this._userSettings = userSettings ?? UserSettings();
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get email => this._email;
  set email(String email) => this._email = email;

  String get firstName => this._firstName;
  set firstName(String firstName) => this._firstName = firstName;

  String get lastName => this._lastName;
  set lastName(String lastName) => this._lastName = lastName;

  String get gender => this._gender;
  set gender(String gender) => this._gender = gender;

  DateTime get birthDate => this._birthDate;
  set birthDate(DateTime birthDate) => this._birthDate = birthDate;

  double get height => this._height;
  set height(double height) => this._height = height;

  double get weight => this._weight;
  set weight(double weight) => this._weight = weight;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  List<Medicine> get medicineList => this._medicineList;
  set medicineList(List<Medicine> medicineList) => this._medicineList = medicineList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(List<Appointment> appointmentList) => this._appointmentList = appointmentList;

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(List<Doctor> doctorList) => this._doctorList = doctorList;

  List<Hospital> get hospitalList => this._hospitalList;
  set hospitalList(List<Hospital> hospitalList) => this._hospitalList = hospitalList;

  void addMedicine(Medicine medicine) {
    this._medicineList.add(medicine);
  }

  bool removeMedicine(String id){
    for (int i = 0; i < this._medicineList.length; i++) {
      if (id == this._medicineList[i].id) {
        this._medicineList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addAppointment(Appointment appointment) {
    this._appointmentList.add(appointment);
  }

  bool removeAppointment(String id){
    for (int i = 0; i < this._appointmentList.length; i++) {
      if (id == this._appointmentList[i].id) {
        this._appointmentList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addDoctor(Doctor doctor) {
    this._doctorList.add(doctor);
  }

  bool removeDoctor(String id){
    for (int i = 0; i < this._doctorList.length; i++) {
      if (id == this._doctorList[i].id) {
        this._doctorList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addHospital(Hospital hospital) {
    this._hospitalList.add(hospital);
  }

  bool removeHospital(String id){
    for (int i = 0; i < this._hospitalList.length; i++) {
      if (id == this._hospitalList[i].id) {
        this._hospitalList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  getMedicineOverview() {
    // TODO: Implements method to return medicine in overview page
  }

  List<DateTime> getMedicineSchedule(Medicine medicine) {
    DateTime firstDay;
    Duration firstTime;
    final List<Duration> oneDayTime = List<Duration>();
    final List<Duration> durations = List<Duration>();
    final List<DateTime> medicineSchedule = List<DateTime>();
    int offset = 0;

    // Logic: Calculate `firstDay`
    firstDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    while (!medicine.medicineSchedule.day[firstDay.weekday - 1]) {
      firstDay = firstDay.add(Duration(days: 1));
    }

    // Logic: Calculate `firstTime`
    for (int i = 0; i < 4; i++) {
      if (DateTime.now().day != firstDay.day) {
        firstTime = this._userSettings.userTime[medicine.medicineSchedule.time.indexOf(true)];
        offset = 0;
        break;
      }

      if (!medicine.medicineSchedule.time[i]) {
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
      if (medicine.medicineSchedule.time[i]) {
        oneDayTime.add(this._userSettings.userTime[i]);
      }
    }

    // Logic: Calculate `durations`
    for (int i = 0; i < oneDayTime.length - 1; i++) {
      durations.add(oneDayTime[i + 1] - oneDayTime[i]);
    }
    durations.add(Duration(days: 1) - oneDayTime[oneDayTime.length - 1] + oneDayTime[0]);

    // Logic: Calculate `medicineSchedule`
    firstDay = firstDay.add(firstTime);
    for (int i = 0;
        i < (medicine.totalAmount / medicine.doseAmount).ceil() + medicine.skippedTimes;
        i++) {
      medicineSchedule.add(firstDay);
      firstDay = firstDay.add(durations[(i + offset) % durations.length]);

      while (!medicine.medicineSchedule.day[firstDay.weekday - 1]) {
        firstDay = firstDay.add(Duration(days: 1));
      }
    }

    return medicineSchedule;
  }
}
