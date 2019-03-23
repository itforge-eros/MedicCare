///
///
///

import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/exceptions.dart';

class MedicineOverviewItem {
  Medicine _medicine;
  DateTime _dateTime;
  bool _isDone;

  MedicineOverviewItem({
    Medicine medicine,
    DateTime dateTime,
  }) {
    if (medicine == null || dateTime == null) {
      throw IncompleteDataException();
    }
    this._medicine = medicine;
    this._dateTime = dateTime;
    this._isDone = false;
  }

  Medicine get medicine => this._medicine;

  DateTime get dateTime => this._dateTime;

  bool get isDone => this._isDone;
  set isDone(bool isDone) => this._isDone = isDone;

  String toString() {
    return this._medicine.name + ' ' + this._dateTime.toString();
  }
}
