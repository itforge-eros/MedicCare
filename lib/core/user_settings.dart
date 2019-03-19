///
/// user_settings.dart
/// Class contains data of settings of user
/// 

class UserSettings {
  static const Duration _defaultBreakfastTime = Duration(
    hours: 7,
    minutes: 0,
  );
  static const Duration _defaultLunchTime = Duration(
    hours: 12,
    minutes: 0,
  );
  static const Duration _defaultDinnerTime = Duration(
    hours: 18,
    minutes: 0,
  );
  static const Duration _defaultNightTime = Duration(
    hours: 22,
    minutes: 0,
  );

  Duration _breakfastTime;
  Duration _lunchTime;
  Duration _dinnerTime;
  Duration _nightTime;

  UserSettings({
    Duration breakfastTime = UserSettings._defaultBreakfastTime,
    Duration lunchTime = UserSettings._defaultLunchTime,
    Duration dinnerTime = UserSettings._defaultDinnerTime,
    Duration nightTime = UserSettings._defaultNightTime,
  }) {
    this._breakfastTime = breakfastTime;
    this._lunchTime = lunchTime;
    this._dinnerTime = dinnerTime;
    this._nightTime = nightTime;
  }

  Duration get breakfastTime => this._breakfastTime;
  set breakfastTime(breakfastTime) => this._breakfastTime = breakfastTime;

  Duration get lunchTime => this._lunchTime;
  set lunchTime(lunchTime) => this._lunchTime = lunchTime;

  Duration get dinnerTime => this._dinnerTime;
  set dinnerTime(dinnerTime) => this._dinnerTime = dinnerTime;

  Duration get nightTime => this._nightTime;
  set nightTime(nightTime) => this._nightTime = nightTime;

  void resetDefault() {
    this._breakfastTime = UserSettings._defaultBreakfastTime;
    this._lunchTime = UserSettings._defaultLunchTime;
    this._dinnerTime = UserSettings._defaultDinnerTime;
    this._nightTime = UserSettings._defaultNightTime;
  }
}
