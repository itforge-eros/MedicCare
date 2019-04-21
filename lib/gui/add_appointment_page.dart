///
/// `add_appointment_page.dart`
/// Class for appointment addition page GUI
///

import 'package:flutter/material.dart';

class AddAppointmentPage extends StatefulWidget {
  final Function _refreshState;

  AddAppointmentPage(this._refreshState);

  @override
  State<StatefulWidget> createState() {
    return _AddAppointmentPageState();
  }
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
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
      body: Center(
        child: ListView(
          padding:
              EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
          children: <Widget>[
            // TODO: Completes form
            TextFormField(
              decoration: InputDecoration(hintText: 'Appointment Topic'),
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
                widget._refreshState();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
