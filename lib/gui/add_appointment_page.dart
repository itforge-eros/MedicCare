///
/// `add_appointment_page.dart`
/// Class for appointment addition page GUI
///

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

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
                decoration: InputDecoration(labelText: 'Appointment Title'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill appointment title';
                  }
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Doctor'),
              ),
              TextFormField(
                controller: _controllerHospital,
                decoration: InputDecoration(labelText: 'Hospital'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill hospital';
                  }
                },
              ),
              DateTimePickerFormField(
                initialValue: DateTime.now().add(Duration(days: 1)),
                initialDate: DateTime.now().add(Duration(days: 1)),
                format: DateFormat('yyyy-MM-dd HH:mm'),
                inputType: InputType.both,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Date and Time',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onChanged: (DateTime dateTime) {},
                validator: (DateTime dateTime) {
                  try {
                    if (dateTime.compareTo(DateTime.now()) < 0) {
                      return 'Appointment date and time must be in the future';
                    }
                  } catch (e) {
                    return 'Invalid date and time format';
                  }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Save'),
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
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
