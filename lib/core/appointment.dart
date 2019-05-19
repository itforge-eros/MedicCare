///
/// `appointment.dart`
/// Class contains data of appointment
///

import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';

class Appointment {
  String _id;
  String _title;
  String _description;
  Doctor _doctor;
  String _hospital;
  DateTime _dateTime;

  Appointment({
    String id,
    String title,
    String description,
    Doctor doctor,
    String hospital,
    DateTime dateTime,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._doctor = doctor;
    this._hospital = hospital;
    this._dateTime = dateTime;
  }

  Appointment.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._doctor = Doctor.fromMap(map['doctor']);
    this._hospital = map['hospital'];
    this._dateTime = DateTime.parse(map['dateTime']);
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get title => this._title;
  set title(String title) => this._title = title;

  String get description => this._description;
  set description(String description) => this._description = description;

  Doctor get doctor => this._doctor;
  set doctor(Doctor doctor) => this._doctor = doctor;

  String get hospital => this._hospital;
  set hospital(String hospital) => this._hospital = hospital;

  DateTime get dateTime => this._dateTime;
  set dateTime(DateTime dateTime) => this._dateTime = dateTime;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this._id,
      'title': this._title,
      'description': this._description,
      'doctor': this._doctor.toMap(),
      'hospital': this._hospital,
      'dateTime': this._dateTime.toString(),
    };
  }
}
