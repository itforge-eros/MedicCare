///
/// `medicine.dart`
/// Class contains data of medicine
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/exceptions.dart';

class Medicine {
  String _id;
  String _name;
  String _description;
  String _type;
  Image _image;
  int _doseAmount;
  int _totalAmount;
  int _remainingAmount;
  int _skippedTimes;
  MedicineSchedule _medicineSchedule;
  DateTime _dateAdded = DateTime.now();

  Medicine({
    String id,
    String name,
    String description,
    String type,
    Image image,
    int doseAmount = 1,
    int totalAmount = 10,
    MedicineSchedule medicineSchedule,
    DateTime dateAdded,
  }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._type = type;
    this._image = image;
    this._doseAmount = doseAmount;
    this._totalAmount = totalAmount;
    this._remainingAmount = totalAmount;
    this._skippedTimes = 0;
    this._medicineSchedule = medicineSchedule ?? MedicineSchedule();
    this._dateAdded = dateAdded ?? DateTime.now();
  }

  Medicine.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._description = map['description'];
    this._type = map['type'];
    this._image = map['image']; //TODO: Check Image properties
    this._doseAmount = map['doseAmount'];
    this._totalAmount = map['totalAmount'];
    this._remainingAmount = map['totalAmount'];
    this._skippedTimes = map['skippedTimes'];

    this._medicineSchedule = MedicineSchedule.fromMap(map['medicineSchedule']);
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get description => this._description;
  set description(String description) => this._description = description;

  String get type => this._type;
  set type(String type) => this._type = type;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  int get doseAmount => this._doseAmount;
  set doseAmount(int doseAmount) => this._doseAmount = doseAmount;

  int get totalAmount => this._totalAmount;
  set totalAmount(int totalAmount) => this._totalAmount = totalAmount;

  int get remainingAmount => this._remainingAmount;
  set remainingAmount(int remainingAmount) =>
      this._remainingAmount = remainingAmount;

  int get skippedTimes => this._skippedTimes;

  MedicineSchedule get medicineSchedule => this._medicineSchedule;
  set medicineSchedule(MedicineSchedule medicineSchedule) =>
      this._medicineSchedule = medicineSchedule;

  DateTime get dateAdded => this._dateAdded;
  set dateAdded(DateTime dateAdded) => this._dateAdded = dateAdded;

  void takeMedicine() {
    if (this._remainingAmount == 0) {
      throw OutOfMedicineException();
    } else if (this._remainingAmount - this._doseAmount < 0) {
      this._remainingAmount = 0;
    } else {
      this._remainingAmount -= this._doseAmount;
    }
  }

  void skipMedicine() {
    this._skippedTimes++;
  }

  void updateTime() {
    this._dateAdded = DateTime.now();
  }

  String getSubtitle() {
    switch (this._type) {
      case 'capsule':
      case 'drop':
      case 'lozenge':
      case 'tablet':
        return ' ' +
            this._remainingAmount.toString() +
            ' ' +
            ((this._remainingAmount == 1) ? this._type : this._type + 's') +
            ' remaining.';
      case 'cream':
      case 'spray':
        return ' ' +
            this._remainingAmount.toString() +
            ' ' +
            ((this._remainingAmount == 1) ? 'time' : 'times') +
            ' remaining.';
      case 'liquid':
        return ' ' + this._remainingAmount.toString() + ' ml remaining.';
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this._id,
      'name': this._name,
      'description': this._description,
      'type': this._type,
      'image': this._image, //TODO: Check Image properties
      'doseAmount': this._doseAmount,
      'totalAmount': this._totalAmount,
      'remainingAmount': this._remainingAmount,
      'skippedTimes': this._skippedTimes,
      'medicineSchedule': this._medicineSchedule.toMap(),
      'dateAdded': this._dateAdded.toString(),
    };
  }
}
