///
/// medicine.dart
/// Class contains data of medicine
///

import 'package:flutter/material.dart';
import 'exceptions.dart';

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

  MedicineTime get medicineTime => this._medicineTime;
  set medicineTime(medicineTime) => this._medicineTime = medicineTime;

  DateTime get dateAdded => this._dateAdded;

  void takeMedicine() {
    if (this._remainingAmount - this._doseAmount < 0) {
      throw OutOfMedicineException();
    } else {
      this._remainingAmount -= this._doseAmount;
    }
  }
}

class MedicineTime {
  bool _breakfast;
  bool _lunch;
  bool _dinner;
  bool _night;
  bool _beforeMeal;

  MedicineTime({
    bool breakfast = false,
    bool lunch = false,
    bool dinner = false,
    bool night = false,
    bool beforeMeal = false,
  }) {
    this._breakfast = breakfast;
    this._lunch = lunch;
    this._dinner = dinner;
    this._night = night;
    this._beforeMeal = beforeMeal;
  }

  bool get breakfast => this._breakfast;
  set breakfast(breakfast) => this._breakfast = breakfast;

  bool get lunch => this._lunch;
  set lunch(lunch) => this._lunch = lunch;

  bool get dinner => this._dinner;
  set dinner(dinner) => this._dinner = dinner;

  bool get night => this._night;
  set night(night) => this._night = night;

  bool get beforeMeal => this._beforeMeal;
  set beforeMeal(beforeMeal) => this._beforeMeal = beforeMeal;
}
