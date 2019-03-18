///
/// medicine.dart
/// Class contains data of medicine
///

import 'package:flutter/material.dart';
import 'exceptions/medicine_exceptions.dart';

class Medicine {
  String _id;
  String _name;
  String _description;
  Image _image;
  int _doseAmount;
  int _totalAmount;
  int _remainingAmount;
  DateTime _dateAdded;
  List<DateTime> _medicineTime;

  Medicine({
    String id,
    String name,
    String description,
    Image image,
    int doseAmount,
    int totalAmount,
    int remainingAmount,
    DateTime dateAdded,
    List<DateTime> medicineTime,
  }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._image = image;
    this._doseAmount = doseAmount;
    this._totalAmount = totalAmount;
    this._remainingAmount = remainingAmount;
    this._dateAdded = dateAdded;
    this._medicineTime = medicineTime;
  }

  String get id => this._id;
  set id(id) => this._id = id;

  String get name => this._name;
  set name(name) => this._name = name;

  String get description => this._description;
  set description(description) => this._description = description;

  Image get image => this._image;
  set image(image) => this._image = image;

  int get doseAmount => this._doseAmount;
  set doseAmount(doseAmount) => this._doseAmount = doseAmount;

  int get totalAmount => this._totalAmount;
  set totalAmount(totalAmount) => this._totalAmount = totalAmount;

  int get remainingAmount => this._remainingAmount;
  set remainingAmount(remainingAmount) => this._remainingAmount = remainingAmount;

  DateTime get dateAdded => this._dateAdded;
  set dateAdded(dateAdded) => this._dateAdded = dateAdded;

  List<DateTime> get medicineTime => this._medicineTime;
  set medicineTime(medicineTime) => this._medicineTime = medicineTime;

  void takeMedicine(int amount) {
    if (this._remainingAmount - amount < 0) {
      throw OutOfMedicineException();
    } else {
      this._remainingAmount -= amount;
    }
  }
}
