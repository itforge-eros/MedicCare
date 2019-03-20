///
/// medicine.dart
/// Class contains data of medicine
///

import 'package:flutter/material.dart';
import 'exceptions.dart';
import 'medicine_time.dart';

class Medicine {
  String _id;
  String _name;
  String _description;
  Image _image;
  int _doseAmount;
  int _totalAmount;
  int _remainingAmount;
  MedicineTime _medicineTime;
  final DateTime _dateAdded = DateTime.now();

  Medicine({
    String id,
    String name,
    String description,
    Image image,
    int doseAmount,
    int totalAmount,
    int remainingAmount,
    MedicineTime medicineTime,
  }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._image = image;
    this._doseAmount = doseAmount;
    this._totalAmount = totalAmount;
    this._remainingAmount = remainingAmount;
    this._medicineTime = medicineTime;
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get description => this._description;
  set description(String description) => this._description = description;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  int get doseAmount => this._doseAmount;
  set doseAmount(int doseAmount) => this._doseAmount = doseAmount;

  int get totalAmount => this._totalAmount;
  set totalAmount(int totalAmount) => this._totalAmount = totalAmount;

  int get remainingAmount => this._remainingAmount;
  set remainingAmount(int remainingAmount) => this._remainingAmount = remainingAmount;

  MedicineTime get medicineTime => this._medicineTime;
  set medicineTime(MedicineTime medicineTime) => this._medicineTime = medicineTime;

  DateTime get dateAdded => this._dateAdded;

  void takeMedicine() {
    if (this._remainingAmount - this._doseAmount < 0) {
      throw OutOfMedicineException();
    } else {
      this._remainingAmount -= this._doseAmount;
    }
  }
}
