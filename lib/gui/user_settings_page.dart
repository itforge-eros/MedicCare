///
/// `profile_page.dart`
/// Class for profile page GUI
///

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserSettingsPageState();
  }
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserSettings _userSettings = UserSettings(
    breakfastTime: Duration(hours: 7, minutes: 30), // TODO: Loads user settings from FireStore
    lunchTime: Duration(hours: 11, minutes: 30), // TODO: Loads user settings from FireStore
    dinnerTime: Duration(hours: 18, minutes: 30), // TODO: Loads user settings from FireStore
    sleepTime: Duration(hours: 22, minutes: 30), // TODO: Loads user settings from FireStore
  );
  final UserSettings _userSettingsTemporary = UserSettings(
    breakfastTime: Duration(hours: 7, minutes: 30), // TODO: Loads user settings from FireStore
    lunchTime: Duration(hours: 11, minutes: 30), // TODO: Loads user settings from FireStore
    dinnerTime: Duration(hours: 18, minutes: 30), // TODO: Loads user settings from FireStore
    sleepTime: Duration(hours: 22, minutes: 30), // TODO: Loads user settings from FireStore
  );

  DateTime durationToDateTime(Duration duration) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      duration.inHours % 24,
      duration.inMinutes % 60,
    );
  }

  TimeOfDay durationToTimeOfDay(Duration duration) {
    return TimeOfDay(
      hour: duration.inHours % 24,
      minute: duration.inMinutes % 60,
    );
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
              DateTimePickerFormField(
                initialValue: durationToDateTime(_userSettingsTemporary.breakfastTime),
                initialTime: durationToTimeOfDay(_userSettingsTemporary.breakfastTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Breakfast Time',
                  prefixIcon: Icon(Icons.free_breakfast),
                ),
                onChanged: (time) {
                  try {
                    _userSettingsTemporary.breakfastTime = Duration(
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
                initialValue: durationToDateTime(_userSettingsTemporary.lunchTime),
                initialTime: durationToTimeOfDay(_userSettingsTemporary.lunchTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Lunch Time',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                onChanged: (time) {
                  try {
                    _userSettingsTemporary.lunchTime = Duration(
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
                initialValue: durationToDateTime(_userSettingsTemporary.dinnerTime),
                initialTime: durationToTimeOfDay(_userSettingsTemporary.dinnerTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Dinner Time',
                  prefixIcon: Icon(Icons.local_dining),
                ),
                onChanged: (time) {
                  _userSettingsTemporary.dinnerTime = Duration(
                    hours: time.hour,
                    minutes: time.minute,
                  );
                },
                validator: (time) {
                  try {
                    _userSettingsTemporary.dinnerTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
              ),
              DateTimePickerFormField(
                initialValue: durationToDateTime(_userSettingsTemporary.sleepTime),
                initialTime: durationToTimeOfDay(_userSettingsTemporary.sleepTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Bedtime',
                  prefixIcon: Icon(Icons.access_time),
                ),
                onChanged: (time) {
                  try {
                    _userSettingsTemporary.sleepTime = Duration(
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
                    _userSettings.breakfastTime = _userSettingsTemporary.breakfastTime;
                    _userSettings.lunchTime = _userSettingsTemporary.lunchTime;
                    _userSettings.dinnerTime = _userSettingsTemporary.dinnerTime;
                    _userSettings.sleepTime = _userSettingsTemporary.sleepTime;
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
