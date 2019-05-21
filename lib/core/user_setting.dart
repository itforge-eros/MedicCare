///
/// `user_settings.dart`
/// Class contains data of user settings
///

class UserSettings {
  static final List<Duration> defaultTime = [
    Duration(hours: 7, minutes: 0),
    Duration(hours: 12, minutes: 0),
    Duration(hours: 18, minutes: 0),
    Duration(hours: 22, minutes: 0),
  ];

  bool _notificationOn;
  Duration _notifyAheadDuration;
  final List<Duration> _userTime = [
    null, // breakfast
    null, // lunch
    null, // dinner
    null, // sleep
  ];

  UserSettings({
    bool notificationOn = true,
    Duration notifyAheadDuration,
    Duration breakfastTime,
    Duration lunchTime,
    Duration dinnerTime,
    Duration sleepTime,
  }) {
    this._notificationOn = notificationOn;
    this._notifyAheadDuration = notifyAheadDuration ?? Duration(minutes: 30);
    this._userTime[0] = breakfastTime ?? UserSettings.defaultTime[0];
    this._userTime[1] = lunchTime ?? UserSettings.defaultTime[1];
    this._userTime[2] = dinnerTime ?? UserSettings.defaultTime[2];
    this._userTime[3] = sleepTime ?? UserSettings.defaultTime[3];
  }

  UserSettings.fromMap(Map<String, dynamic> map) {
    this._notificationOn = map['notificationOn'];
    this._notifyAheadDuration = map['notifyAheadDuration'].split(':');
    this._userTime[0] = map['userTime'][0] ?? UserSettings.defaultTime[0];
    this._userTime[1] = map['userTime'][1] ?? UserSettings.defaultTime[1];
    this._userTime[2] = map['userTime'][2] ?? UserSettings.defaultTime[2];
    this._userTime[3] = map['userTime'][3] ?? UserSettings.defaultTime[3];
  }

  List<Duration> get userTime => this._userTime;

  bool get notificationOn => this._notificationOn;
  set notificationOn(bool notificationOn) => this._notificationOn = notificationOn;

  Duration get notifyAheadDuration => this._notifyAheadDuration;
  set notifyAheadDuration(Duration notifyAheadDuration) => this._notifyAheadDuration = notifyAheadDuration;

  Duration get breakfastTime => this._userTime[0];
  set breakfastTime(Duration breakfastTime) => this._userTime[0] = breakfastTime;

  Duration get lunchTime => this._userTime[1];
  set lunchTime(Duration lunchTime) => this._userTime[1] = lunchTime;

  Duration get dinnerTime => this._userTime[2];
  set dinnerTime(Duration dinnerTime) => this._userTime[2] = dinnerTime;

  Duration get sleepTime => this._userTime[3];
  set sleepTime(Duration sleepTime) => this._userTime[3] = sleepTime;

  void resetDefault() {
    this._notificationOn = true;
    this._notifyAheadDuration = Duration(minutes: 30);
    this._userTime[0] = UserSettings.defaultTime[0];
    this._userTime[1] = UserSettings.defaultTime[1];
    this._userTime[2] = UserSettings.defaultTime[2];
    this._userTime[3] = UserSettings.defaultTime[3];
  }

  String durationToString(Duration duration) {
    return duration.inHours.toString() + ':' + (duration.inMinutes % 60).toString();
  }

  Duration stringToDuration(String time) {
    return Duration(
      hours: int.parse(time.split(':')[0]),
      minutes: int.parse(time.split(':')[1]),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationOn': this._notificationOn,
      'notifyAheadDuration': durationToString(this._notifyAheadDuration),
      'userTime': this._userTime.map((e) => durationToString(e)).toList(),
    };
  }
}
