///
/// `medicine_schedule.dart`
/// Class contains data of medicine schedule
/// 

import 'package:mediccare/exceptions.dart';

class MedicineSchedule {
  List<bool> _time = [
    null, // breakfast
    null, // lunch
    null, // dinner
    null, // sleep
  ];
  List<bool> _day = [
    null, // monday
    null, // tuesday
    null, // wednesday
    null, // thursday
    null, // friday
    null, // saturday
    null, // sunday
  ];
  bool _isBeforeMeal;

  MedicineSchedule({
    List<bool> time,
    List<bool> day,
    bool isBeforeMeal = false,
  }) {
    if (time != null) {
      checkTimeException(time);
    }
    if (day != null) {
      checkDayException(day);
    }

    this._time = time ?? [true, true, true, false];
    this._day = day ?? [true, true, true, true, true, true, true];
    this._isBeforeMeal = isBeforeMeal;
  }

  MedicineSchedule.fromMap(Map<String, dynamic> map) {
    if (map['time'] != null) {
      checkTimeException(map['time']);
    }
    if (map['day'] != null) {
      checkDayException(day);
    }

    this._time = map['time'] ?? [true, true, true, false];
    this._day = map['day'] ?? [true, true, true, true, true, true, true];
    this._isBeforeMeal = map['isBeforeMeal'];
  }

  List<bool> get time => this._time;
  set time(List<bool> time) {
    checkTimeException(time);
    this._time = time;
  }

  List<bool> get day => this._day;
  set day(List<bool> day) {
    checkDayException(day);
    this._day = day;
  }

  bool get isBeforeMeal => this._isBeforeMeal;
  set isBeforeMeal(bool isBeforeMeal) => this._isBeforeMeal = isBeforeMeal;

  void checkTimeException(List<bool> time) {
    if (time.length != 4) {
      throw InvalidMedicineTimeException();
    } else if (!time.contains(true)) {
      throw NoMedicineTimeException();
    }
  }

  void checkDayException(List<bool> day) {
    if (day.length != 7) {
      throw InvalidMedicineDayException();
    } else if (!day.contains(true)) {
      throw NoMedicineDayException();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': this._time,
      'day': this._day,
      'isBeforeMeal': this._isBeforeMeal,
    };
  }
}
