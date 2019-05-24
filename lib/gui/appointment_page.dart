import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/add_appointment_page.dart';

class AppointmentPage extends StatefulWidget {
  Function _refreshState;
  User _user;
  Appointment _appointment;

  AppointmentPage({Function refreshState, User user, Appointment appointment}) {
    this._refreshState = refreshState;
    this._user = user;
    this._appointment = appointment;
  }

  @override
  State<StatefulWidget> createState() {
    return AppointmentPageState();
  }
}

class AppointmentPageState extends State<AppointmentPage> {
  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.blueGrey),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAppointmentPage.editMode(
                    refreshState: this.refreshState,
                    user: widget._user,
                    appointment: widget._appointment,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    widget._appointment.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Date and Time',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    widget._appointment.dateTime.toString().replaceAll(':00.000', ''),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Description',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    widget._appointment.description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Hospital',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    widget._appointment.hospital,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Doctor',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget._appointment.doctor.fullName,
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: Text(
                        'Picture',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    Text(
                      widget._appointment.doctor.ward,
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
