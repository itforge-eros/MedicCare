///
/// `add_appointment_page.dart`
/// Class for appointment addition page GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Add Appointment',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
      ),
      body: Form(
        key: this._formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Appointment Title'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill appointment title';
                  }
                },
              ),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Doctor'),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Time'),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Date'),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
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
