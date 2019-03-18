///
/// appointment.dart
/// Class contains data of appointment
///

import 'doctor.dart';
import 'hospital.dart';

class Appointment {
  String _title;
  String _description;
  Doctor _doctor;
  Hospital _hospital;
  DateTime _dateTime;

  Appointment({
    String title,
    String description,
    Doctor doctor,
    Hospital hospital,
    DateTime dateTime,
  }) {
    this._title = title;
    this._description = description;
    this._doctor = doctor;
    this._hospital = hospital;
    this._dateTime = dateTime;
  }

  String get title => this._title;
  set title(title) => this._title = title;

  String get description => this._description;
  set description(description) => this._description = description;

  Doctor get doctor => this._doctor;
  set doctor(doctor) => this._doctor = doctor;

  Hospital get hospital => this._hospital;
  set hospital(hospital) => this._hospital = hospital;

  DateTime get dateTime => this._dateTime;
  set dateTime(dateTime) => this._dateTime = dateTime;
}
