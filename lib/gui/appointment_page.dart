import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/gui/edit_appointment_page.dart';
import 'package:mediccare/util/firebase_utils.dart';

class AppointmentPage extends StatefulWidget {
  Appointment _appointment;

  AppointmentPage({Appointment appointment}) {
    this._appointment = appointment;
  }

  @override
  State<StatefulWidget> createState() {
    return AppointmentPageState();
  }
}

class AppointmentPageState extends State<AppointmentPage> {
  Future<Doctor> _getDoctor;

  void refreshState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _getDoctor = FirebaseUtils.getDoctor(widget._appointment.doctor);
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
                  builder: (context) => EditAppointmentPage(
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
              SizedBox(height: 20.0),
              Column(
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
                      widget._appointment.dateTime
                          .toString()
                          .replaceAll(':00.000', ''),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black45),
                    ),
                  ),
                ],
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
            ] +
            ((widget._appointment.doctor != null)
                ? [
                    FutureBuilder(
                        future: _getDoctor,
                        builder: (_, doctor) {
                          if (doctor.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text('Loading...'),
                            );
                          } else if (doctor.connectionState ==
                              ConnectionState.done) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Doctor',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      doctor.data.fullName,
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 30, 10, 30),
                                      child: Text(
                                        // TODO: Implements doctor's image
                                        'Picture',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      doctor.data.ward,
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 15),
                                    )
                                  ],
                                ));
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ]
                : []) +
            [
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black45),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black45),
                      ),
                    ),
                  ],
                ),
              ),
            ],
      ),
    );
  }
}
