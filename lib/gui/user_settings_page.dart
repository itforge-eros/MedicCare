///
/// `profile_page.dart`
/// Class for profile page GUI
///

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

class UserSettingsPage extends StatefulWidget {
  UserSettingsPage();

  @override
  State<StatefulWidget> createState() {
    return _UserSettingsPageState();
  }
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserSettings _currentUserSettings = UserSettings();
  static final TextEditingController _controllerNotifyAheadDuration =
      TextEditingController();

  // Utility Method
  DateTime durationToDateTime(Duration duration) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      duration.inHours % 24,
      duration.inMinutes % 60,
    );
  }

  // Utility Method
  TimeOfDay durationToTimeOfDay(Duration duration) {
    return TimeOfDay(
      hour: duration.inHours % 24,
      minute: duration.inMinutes % 60,
    );
  }

  @override
  void initState() {
    super.initState();
    // this._currentUserSettings.notificationOn = widget._user.userSettings.notificationOn;
    // _controllerNotifyAheadDuration.text =
    //     widget._user.userSettings.notifyAheadDuration.inMinutes.toString();
    // this._currentUserSettings.breakfastTime = widget._user.userSettings.breakfastTime;
    // this._currentUserSettings.lunchTime = widget._user.userSettings.lunchTime;
    // this._currentUserSettings.dinnerTime = widget._user.userSettings.dinnerTime;
    // this._currentUserSettings.sleepTime = widget._user.userSettings.sleepTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'User Settings',
          style: TextStyle(color: Colors.blueGrey),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  SizedBox(width: 12.0),
                  (this._currentUserSettings.notificationOn)
                      ? Icon(
                          Icons.notifications_active,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(Icons.notifications_off, color: Colors.grey),
                  SizedBox(width: 12.0),
                  Text('Notifications'),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Switch(
                      value: this._currentUserSettings.notificationOn,
                      onChanged: (value) {
                        setState(() {
                          this._currentUserSettings.notificationOn = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _controllerNotifyAheadDuration,
                keyboardType: TextInputType.number,
                enabled: this._currentUserSettings.notificationOn,
                decoration: InputDecoration(
                  labelText: 'Notify Ahead Time',
                  prefixIcon: Icon(Icons.timer),
                  suffixText: 'Minutes',
                ),
                validator: (String text) {
                  if (this._currentUserSettings.notificationOn) {
                    if (text.isEmpty) {
                      return 'Please fill notify ahead time';
                    } else {
                      try {
                        int time = int.parse(text);
                        if (time <= 0) {
                          return 'Notify ahead time must be at least 1';
                        } else if (time > 120) {
                          return 'Notify ahead time must be not exceed 2 hours';
                        }
                      } catch (e) {
                        return 'Notify ahead time must be an integer';
                      }
                    }
                  }
                },
              ),
              DateTimePickerFormField(
                initialValue:
                    durationToDateTime(this._currentUserSettings.breakfastTime),
                initialTime: durationToTimeOfDay(
                    this._currentUserSettings.breakfastTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Breakfast Time',
                  prefixIcon: Icon(Icons.free_breakfast),
                ),
                onChanged: (time) {
                  try {
                    this._currentUserSettings.breakfastTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
                validator: (time) {
                  if (time == null) {
                    return 'Please pick breakfast time';
                  }
                },
              ),
              DateTimePickerFormField(
                initialValue:
                    durationToDateTime(this._currentUserSettings.lunchTime),
                initialTime:
                    durationToTimeOfDay(this._currentUserSettings.lunchTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Lunch Time',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                onChanged: (time) {
                  try {
                    this._currentUserSettings.lunchTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
                validator: (time) {
                  if (time == null) {
                    return 'Please pick lunch time';
                  }
                },
              ),
              DateTimePickerFormField(
                initialValue:
                    durationToDateTime(this._currentUserSettings.dinnerTime),
                initialTime:
                    durationToTimeOfDay(this._currentUserSettings.dinnerTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Dinner Time',
                  prefixIcon: Icon(Icons.local_dining),
                ),
                onChanged: (time) {
                  try {
                    this._currentUserSettings.dinnerTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
                validator: (time) {
                  if (time == null) {
                    return 'Please pick dinner time';
                  }
                },
              ),
              DateTimePickerFormField(
                initialValue:
                    durationToDateTime(this._currentUserSettings.sleepTime),
                initialTime:
                    durationToTimeOfDay(this._currentUserSettings.sleepTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Bedtime',
                  prefixIcon: Icon(Icons.brightness_3),
                ),
                onChanged: (time) {
                  try {
                    this._currentUserSettings.sleepTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
                validator: (time) {
                  if (time == null) {
                    return 'Please pick bedtime';
                  }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Save'),
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    if (this._currentUserSettings.notificationOn) {
                      // If notification is on, save value normally. (Already validated)
                      this._currentUserSettings.notifyAheadDuration = Duration(
                        minutes: int.parse(_controllerNotifyAheadDuration.text),
                      );
                    } else {
                      // If notification is off, save value manually. (Validate again)
                      try {
                        // Try saving the value, if over 120, force to save as 120.
                        if (int.parse(_controllerNotifyAheadDuration.text) >
                            120) {
                          this._currentUserSettings.notifyAheadDuration =
                              Duration(
                            minutes: 120,
                          );
                        } else {
                          this._currentUserSettings.notifyAheadDuration =
                              Duration(
                            minutes:
                                int.parse(_controllerNotifyAheadDuration.text),
                          );
                        }
                      } catch (e) {
                        // If parsing error, reset notify ahead time to 30 minutes.
                        this._currentUserSettings.notifyAheadDuration =
                            Duration(
                          minutes: 30,
                        );
                      }
                    }

                    // widget._user.userSettings = this._currentUserSettings;

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
