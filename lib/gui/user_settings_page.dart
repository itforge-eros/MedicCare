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
  final User _user;

  UserSettingsPage(this._user);

  @override
  State<StatefulWidget> createState() {
    return _UserSettingsPageState();
  }
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                initialValue: durationToDateTime(widget._user.userSettings.breakfastTime),
                initialTime: durationToTimeOfDay(widget._user.userSettings.breakfastTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Breakfast Time',
                  prefixIcon: Icon(Icons.free_breakfast),
                ),
                onChanged: (time) {
                  try {
                    widget._user.userSettings.breakfastTime = Duration(
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
                initialValue: durationToDateTime(widget._user.userSettings.lunchTime),
                initialTime: durationToTimeOfDay(widget._user.userSettings.lunchTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Lunch Time',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                onChanged: (time) {
                  try {
                    widget._user.userSettings.lunchTime = Duration(
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
                initialValue: durationToDateTime(widget._user.userSettings.dinnerTime),
                initialTime: durationToTimeOfDay(widget._user.userSettings.dinnerTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Dinner Time',
                  prefixIcon: Icon(Icons.local_dining),
                ),
                onChanged: (time) {
                  widget._user.userSettings.dinnerTime = Duration(
                    hours: time.hour,
                    minutes: time.minute,
                  );
                },
                validator: (time) {
                  try {
                    widget._user.userSettings.dinnerTime = Duration(
                      hours: time.hour,
                      minutes: time.minute,
                    );
                  } catch (e) {}
                },
              ),
              DateTimePickerFormField(
                initialValue: durationToDateTime(widget._user.userSettings.sleepTime),
                initialTime: durationToTimeOfDay(widget._user.userSettings.sleepTime),
                format: DateFormat('HH:mm'),
                inputType: InputType.time,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Bedtime',
                  prefixIcon: Icon(Icons.brightness_3),
                ),
                onChanged: (time) {
                  try {
                    widget._user.userSettings.sleepTime = Duration(
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
