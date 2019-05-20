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
                initialValue: durationToDateTime(_userSettings.breakfastTime),
                initialTime: durationToTimeOfDay(_userSettings.breakfastTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Breakfast Time',
                  prefixIcon: Icon(Icons.free_breakfast),
                ),
                onChanged: (time) {
                  try {
                    _userSettings.breakfastTime = Duration(
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
                initialValue: durationToDateTime(_userSettings.lunchTime),
                initialTime: durationToTimeOfDay(_userSettings.lunchTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Lunch Time',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                onChanged: (time) {
                  try {
                    _userSettings.lunchTime = Duration(
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
                initialValue: durationToDateTime(_userSettings.dinnerTime),
                initialTime: durationToTimeOfDay(_userSettings.dinnerTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Dinner Time',
                  prefixIcon: Icon(Icons.local_dining),
                ),
                onChanged: (time) {
                  _userSettings.dinnerTime = Duration(
                    hours: time.hour,
                    minutes: time.minute,
                  );
                },
                validator: (time) {
                  try {
                    _userSettings.dinnerTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
              ),
              DateTimePickerFormField(
                initialValue: durationToDateTime(_userSettings.sleepTime),
                initialTime: durationToTimeOfDay(_userSettings.sleepTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Bedtime',
                  prefixIcon: Icon(Icons.brightness_3),
                ),
                onChanged: (time) {
                  try {
                    _userSettings.sleepTime = Duration(
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
                    // TODO: Implements saving data to FireStore
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
