///
/// `medicine_overview_data.dart`
/// Class contains data of medicine overview data
/// 

import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/exceptions.dart';

class MedicineOverviewData {
  Medicine _medicine;
  DateTime _dateTime;
  bool _isDone;

  MedicineOverviewData({
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

  bool isDisplayable() {
    return !this._isDone ||
        this._dateTime.compareTo(DateTime.now().add(Duration(days: 1))) < 0;
  }

  String toString() {
    return this._medicine.name + ' ' + this._dateTime.toString();
  }
}
