///
/// user.dart
/// Class contains data of user
///

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
  List<Medicine> _medicineList;
  List<Doctor> _doctorList;
  List<Appointment> _appointmentList;

  User({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime birthDate,
    String gender,
    double height,
    double weight,
    List<Medicine> medicineList,
    List<Doctor> doctorList,
    List<Appointment> appointmentList,
  }) {
    this._id = id;
    this._email = email;
    this._firstName = firstName;
    this._lastName = lastName;
    this._birthDate = birthDate;
    this._gender = gender;
    this._height = height;
    this._weight = weight;
    this._medicineList = medicineList;
    this._doctorList = doctorList;
    this._appointmentList = appointmentList;
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

  List<Medicine> get medicineList => this._medicineList;
  set medicineList(medicineList) => this._medicineList = medicineList;

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(doctorList) => this._doctorList = doctorList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(appointmentList) => this._appointmentList = appointmentList;
}
