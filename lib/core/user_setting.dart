///
/// `user_settings.dart`
/// Class contains data of user settings
///

class UserSettings {
  static final List<Duration> defaultTime = [
    Duration(
      hours: 7,
      minutes: 0,
    ),
    Duration(
      hours: 12,
      minutes: 0,
    ),
    Duration(
      hours: 18,
      minutes: 0,
    ),
    Duration(
      hours: 22,
      minutes: 0,
    ),
  ];

  final List<Duration> _userTime = [
    null, // breakfast
    null, // lunch
    null, // dinner
    null, // sleep
  ];

  UserSettings({
    Duration breakfastTime,
    Duration lunchTime,
    Duration dinnerTime,
    Duration sleepTime,
  }) {
    this._userTime[0] = breakfastTime ?? UserSettings.defaultTime[0];
    this._userTime[1] = lunchTime ?? UserSettings.defaultTime[1];
    this._userTime[2] = dinnerTime ?? UserSettings.defaultTime[2];
    this._userTime[3] = sleepTime ?? UserSettings.defaultTime[3];
  }

  List<Duration> get userTime => this._userTime;

  Duration get breakfastTime => this._userTime[0];
  set breakfastTime(Duration breakfastTime) => this._userTime[0] = breakfastTime;

  Duration get lunchTime => this._userTime[1];
  set lunchTime(Duration lunchTime) => this._userTime[1] = lunchTime;

  Duration get dinnerTime => this._userTime[2];
  set dinnerTime(Duration dinnerTime) => this._userTime[2] = dinnerTime;

  Duration get sleepTime => this._userTime[3];
  set sleepTime(Duration sleepTime) => this._userTime[3] = sleepTime;

  void resetDefault() {
    this._userTime[0] = UserSettings.defaultTime[0];
    this._userTime[1] = UserSettings.defaultTime[1];
    this._userTime[2] = UserSettings.defaultTime[2];
    this._userTime[3] = UserSettings.defaultTime[3];
  }

  String _toTime(Duration duration) {
    return duration.inHours.toString() + ':' + (duration.inMinutes % 60).toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userTime': this._userTime.map((e) => _toTime(e)).toList(),
    };
  }

  UserSettings.fromMap(Map<String, dynamic> map) {
    this._userTime[0] = map['userTime'][0] ?? UserSettings.defaultTime[0];
    this._userTime[1] = map['userTime'][1] ?? UserSettings.defaultTime[1];
    this._userTime[2] = map['userTime'][2] ?? UserSettings.defaultTime[2];
    this._userTime[3] = map['userTime'][3] ?? UserSettings.defaultTime[3];
  }
}
