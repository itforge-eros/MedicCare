///
/// `add_appointment_page.dart`
/// Class for appointment addition page GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/util/alert.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddAppointmentPage extends StatefulWidget {
  Function _refreshState;
  Appointment _appointment;

  AddAppointmentPage(Function refreshState) {
    this._refreshState = refreshState;
  }

  AddAppointmentPage.editMode(Function refreshState, Appointment appointment) {
    this._refreshState = refreshState;
    this._appointment = appointment;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddAppointmentPageState();
  }
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerTitle = TextEditingController();
  static final TextEditingController _controllerDescription = TextEditingController();
  static final TextEditingController _controllerHospital = TextEditingController();
  static final TextEditingController _controllerDateTime = TextEditingController();

  void clearFields() {
    _controllerTitle.text = '';
    _controllerDescription.text = '';
    _controllerHospital.text = '';
    _controllerDateTime.text = '';
  }

  void loadFields() {
    if (widget._appointment != null) {
      _controllerTitle.text = widget._appointment.title;
      _controllerDescription.text = widget._appointment.description;
      _controllerHospital.text = widget._appointment.hospital;
      _controllerDateTime.text = widget._appointment.dateTime.toString().replaceAll('.000', '');
    }
  }

  DateTime loadTime() {
    try {
      return DateTime.parse(_controllerDateTime.text);
    } catch (e) {
      _controllerDateTime.text = '';
      return DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    this.clearFields();
    this.loadFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          (widget._appointment == null) ? 'Add Appointment' : 'Edit Appointment',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
        actions: (widget._appointment == null)
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Alert.displayConfirmDelete(
                      context,
                      title: 'Delete Appointment?',
                      content:
                          'Deleting this appointment will permanently remove it from your appointment list.',
                      onPressedConfirm: () {
                        // TODO: Implements appointment deletion
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                        widget._refreshState();
                      },
                    );
                  },
                ),
              ],
      ),
      body: Form(
        key: this._formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
            children: <Widget>[
              TextFormField(
                controller: _controllerTitle,
                decoration: InputDecoration(hintText: 'Appointment Title'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill appointment title';
                  }
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Doctor'),
              ),
              TextFormField(
                controller: _controllerHospital,
                decoration: InputDecoration(hintText: 'Hospital'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill hospital';
                  }
                },
              ),
              TextFormField(
                controller: _controllerDateTime,
                enabled: true,
                decoration: InputDecoration(hintText: 'Date and time'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please select date and time';
                  }

                  try {
                    if (DateTime.parse(text).compareTo(DateTime.now()) < 0) {
                      return 'Appointment date and time must be in the future';
                    }
                  } catch (e) {
                    return 'Invalid date and time format';
                  }
                },
              ),
              FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    theme: DatePickerTheme(
                      itemStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                      ),
                    ),
                    showTitleActions: true,
                    onChanged: (DateTime value) {},
                    onConfirm: (DateTime value) {
                      _controllerDateTime.text = value.toString().replaceAll('.000', '');
                    },
                    currentTime: loadTime(),
                    locale: LocaleType.en,
                  );
                },
                child: Text(
                  'Select appointment date and time',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Save'),
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    // TODO: Implements add appointment
                    widget._refreshState();
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
