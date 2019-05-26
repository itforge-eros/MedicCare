///
/// `medicine.dart`
/// Class contains data of medicine
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/user_setting.dart';
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

    Map<String, dynamic> medicineSchedule = new Map<String, dynamic>.from(map['medicineSchedule']);

    this._medicineSchedule = MedicineSchedule.fromMap(medicineSchedule);
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
  set remainingAmount(int remainingAmount) => this._remainingAmount = remainingAmount;

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

  // Data Method: Get medicine schedule of a single medicine
  List<DateTime> getMedicineSchedule(UserSettings userSettings) {
    DateTime firstDay;
    Duration firstTime;
    final List<Duration> oneDayTime = List<Duration>();
    final List<Duration> durations = List<Duration>();
    final List<DateTime> medicineSchedule = List<DateTime>();
    int offset = 0;

    // Logic: Calculate `firstDay`
    firstDay = DateTime(this._dateAdded.year, this._dateAdded.month, this._dateAdded.day);
    bool _availableFirstDay = false;

    for (int i = 0; i < 4; i++) {
      if (Duration(hours: this._dateAdded.hour, minutes: this._dateAdded.minute) <
              userSettings.userTime[i] &&
          this._medicineSchedule.time[i]) {
        _availableFirstDay = true;
        break;
      }
    }

    if (!_availableFirstDay) {
      // If not able to take any medicine on the first day, skip a day.
      firstDay = firstDay.add(Duration(days: 1));
    }

    while (!this._medicineSchedule.day[firstDay.weekday - 1]) {
      firstDay = firstDay.add(Duration(days: 1));
    }

    // Logic: Calculate `firstTime`
    for (int i = 0; i < 4; i++) {
      if (this._dateAdded.day != firstDay.day) {
        firstTime = userSettings.userTime[this._medicineSchedule.time.indexOf(true)];
        break;
      }

      if (this._medicineSchedule.time[i] &&
          this._dateAdded.compareTo(
                    DateTime(
                      firstDay.year,
                      firstDay.month,
                      firstDay.day,
                      userSettings.userTime[i].inHours % 24,
                      userSettings.userTime[i].inMinutes % 60,
                    ),
                  ) <
              0) {
        if (firstTime == null) {
          firstTime = userSettings.userTime[i];
        } else if (userSettings.userTime[i].compareTo(firstTime) < 0) {
          firstTime = userSettings.userTime[i];
        }
      }
    }

    // Logic: Calculate `oneDayTime`
    for (int i = 0; i < 4; i++) {
      if (this._medicineSchedule.time[i]) {
        oneDayTime.add(userSettings.userTime[i]);
      }
    }

    // Logic: Calculate `durations`
    for (int i = 0; i < oneDayTime.length - 1; i++) {
      if ((oneDayTime[i + 1] - oneDayTime[i]).isNegative) {
        durations.add(oneDayTime[i + 1] - oneDayTime[i] + Duration(days: 1));
      } else {
        durations.add(oneDayTime[i + 1] - oneDayTime[i]);
      }
    }

    if ((oneDayTime[0] - oneDayTime[oneDayTime.length - 1]).isNegative ||
        (oneDayTime[0] - oneDayTime[oneDayTime.length - 1]) == Duration(seconds: 0)) {
      durations.add(oneDayTime[0] - oneDayTime[oneDayTime.length - 1] + Duration(days: 1));
    } else {
      durations.add(oneDayTime[0] - oneDayTime[oneDayTime.length - 1]);
    }

    // Logic: Calculate `offset`
    for (int i = 0; i < oneDayTime.length; i++) {
      if (firstTime.compareTo(oneDayTime[i]) != 0) {
        offset++;
      } else {
        break;
      }
    }

    // Logic: Calculate `medicineSchedule`
    firstDay = firstDay.add(firstTime);
    for (int i = 0; i < (this._totalAmount / this._doseAmount).ceil() + this._skippedTimes; i++) {
      medicineSchedule.add(firstDay);
      firstDay = firstDay.add(durations[(i + offset) % durations.length]);

      while (!this._medicineSchedule.day[firstDay.weekday - 1]) {
        firstDay = firstDay.add(Duration(days: 1));
      }
    }

    // Logic: Remove taken and skipped medicine
    for (int i = 0;
        i < (this._totalAmount - this._remainingAmount) / this._doseAmount + this._skippedTimes;
        i++) {
      medicineSchedule.removeAt(0);
    }

    return medicineSchedule;
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
