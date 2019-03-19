///
/// medicine_time.dart
/// Class contains data of time of medicine
///

import 'exceptions.dart';

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
    _checkException();
  }

  bool get breakfast => this._breakfast;
  set breakfast(breakfast) {
    this._breakfast = breakfast;
    _checkException();
  }

  bool get lunch => this._lunch;
  set lunch(lunch) {
    this._lunch = lunch;
    _checkException();
  }

  bool get dinner => this._dinner;
  set dinner(dinner) {
    this._dinner = dinner;
    _checkException();
  }

  bool get night => this._night;
  set night(night) {
    this._night = night;
    _checkException();
  }

  bool get beforeMeal => this._beforeMeal;
  set beforeMeal(beforeMeal) => this._beforeMeal = beforeMeal;

  void _checkException() {
    if (!(this._breakfast || this._lunch || this._dinner || this._night)) {
      throw NoMedicineTimeException();
    }
  }
}
