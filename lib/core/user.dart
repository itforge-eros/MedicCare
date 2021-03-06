import 'package:equatable/equatable.dart';

///
/// `user.dart`
/// Class contains data of user
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine_overview_data.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/exceptions.dart';

class User extends Equatable {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  String _bloodGroup;
  DateTime _birthDate;
  double _height;
  double _weight;
  String _image;
  List<Medicine> _medicineList;
  List<Appointment> _appointmentList;
  List<Doctor> _doctorList;
  List<Hospital> _hospitalList;
  UserSettings _userSettings;

  User({
    String id = '',
    String email = '',
    String firstName = '',
    String lastName = '',
    String gender = '',
    String bloodGroup = '',
    double height,
    double weight,
    DateTime birthDate,
    String image,
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
    this._gender = gender;
    this._bloodGroup = bloodGroup;
    this._height = height;
    this._weight = weight;
    this._birthDate = birthDate;
    this._image = image;
    this._medicineList = medicineList ?? List<Medicine>();
    this._appointmentList = appointmentList ?? List<Appointment>();
    this._doctorList = doctorList ?? List<Doctor>();
    this._hospitalList = hospitalList ?? List<Hospital>();
    this._userSettings = userSettings ?? UserSettings();
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._email = map['email'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._birthDate = DateTime.parse(map['birthDate']);
    this._gender = map['gender'];
    this._height = map['height'];
    this._weight = map['weight'];
    this._image = map['image']; //TODO: Check Image properties
    // this._medicineList =
    //     map['medicineList'].map((e) => Medicine.fromMap(e)).toList() ??
    //         List<Medicine>();
    // this._appointmentList =
    //     map['appointmentList'].map((e) => Appointment.fromMap(e)).toList() ??
    //         List<Appointment>();
    // this._doctorList =
    //     map['doctorList'].map((e) => Doctor.fromMap(e)).toList() ??
    //         List<Doctor>();
    // this._hospitalList =
    //     map['hospitalList'].map((e) => Hospital.fromMap(e)).toList() ??
    //         List<Hospital>();
    this._userSettings =
        UserSettings.fromMap(map['userSettings']) ?? UserSettings();
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
  set gender(String gender) {
    if (<String>['male', 'female', 'others'].contains(gender.toLowerCase())) {
      this._gender = gender.toLowerCase();
    } else {
      throw InvalidGenderException();
    }
  }

  String get bloodGroup => this._bloodGroup;
  set bloodGroup(String bloodGroup) {
    if (<String>['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
        .contains(bloodGroup.toUpperCase())) {
      this._bloodGroup = bloodGroup.toUpperCase();
    } else {
      throw InvalidBloodGroupException();
    }
  }

  double get height => this._height;
  set height(double height) => this._height = height;

  double get weight => this._weight;
  set weight(double weight) => this._weight = weight;

  DateTime get birthDate => this._birthDate;
  set birthDate(DateTime birthDate) => this._birthDate = birthDate;

  String get image => this._image;
  set image(String image) => this._image = image;

  List<Medicine> get medicineList => this._medicineList;
  set medicineList(List<Medicine> medicineList) =>
      this._medicineList = medicineList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(List<Appointment> appointmentList) =>
      this._appointmentList = appointmentList;

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(List<Doctor> doctorList) => this._doctorList = doctorList;

  List<Hospital> get hospitalList => this._hospitalList;
  set hospitalList(List<Hospital> hospitalList) =>
      this._hospitalList = hospitalList;

  UserSettings get userSettings => this._userSettings;
  set userSettings(UserSettings userSettings) =>
      this._userSettings = userSettings;

  String getFormattedBirthDate() {
    String month;

    switch (this._birthDate.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
    }
    return this._birthDate.day.toString() +
        ' ' +
        month +
        ' ' +
        this._birthDate.year.toString();
  }

  void addMedicine(Medicine medicine) {
    this._medicineList.add(medicine);
  }

  bool removeMedicine(String id) {
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

  bool removeAppointment(String id) {
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

  bool removeDoctor(String id) {
    for (int i = 0; i < this._doctorList.length; i++) {
      if (id == this._doctorList[i].id) {
        this._doctorList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  bool containsRemainingMedicine() {
    for (int i = 0; i < this._medicineList.length; i++) {
      if (this._medicineList[i].remainingAmount > 0) {
        return true;
      }
    }
    return false;
  }

  bool containsEmptyMedicine() {
    for (int i = 0; i < this._medicineList.length; i++) {
      if (this._medicineList[i].remainingAmount == 0) {
        return true;
      }
    }
    return false;
  }

  bool containsComingAppointments() {
    for (int i = 0; i < this._appointmentList.length; i++) {
      if (this._appointmentList[i].status == 0) {
        return true;
      }
    }
    return false;
  }

  bool containsCompletedAppointments() {
    for (int i = 0; i < this._appointmentList.length; i++) {
      if (this._appointmentList[i].status == 1) {
        return true;
      }
    }
    return false;
  }

  bool containsSkippedAppointments() {
    for (int i = 0; i < this._appointmentList.length; i++) {
      if (this._appointmentList[i].status == 2) {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this._id,
      'email': this._email,
      'firstName': this._firstName,
      'lastName': this._lastName,
      'gender': this._gender,
      'bloodGroup': this._bloodGroup,
      'birthDate': this._birthDate,
      'height': this._height,
      'weight': this._weight,
      'image': this._image, //TODO: Check Image property
      'medicineList': this._medicineList.map((e) => e.toMap()).toList(),
      'appointment': this._appointmentList.map((e) => e.toMap()).toList(),
      // 'doctorList': this._doctorList.map((e) => e.toMap()).toList(),
      'hospitalList': this._hospitalList.map((e) => e.toMap()).toList(),
      'userSettings': this._userSettings.toMap(),
    };
  }
}
