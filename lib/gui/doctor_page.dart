import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/add_doctor_page.dart';
import 'package:mediccare/gui/edit_doctor_page.dart';
import 'package:mediccare/util/custom_icons.dart';
import 'package:mediccare/util/firebase_utils.dart';

class DoctorPage extends StatefulWidget {
  Doctor _doctor;

  DoctorPage({Doctor doctor}) {
    this._doctor = doctor;
  }

  @override
  State<StatefulWidget> createState() {
    return DoctorPageState();
  }
}

class DoctorPageState extends State<DoctorPage> {
  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Doctor Profile',
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
                  builder: (context) => EditDoctorPage(doctor: widget._doctor),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                // TODO: Implements doctor's image
                tag: widget._doctor.image,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget._doctor.image),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                widget._doctor.fullName,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.local_hospital,
                            color: Theme.of(context).primaryColor),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget._doctor.hospital,
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[800]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(CustomIcons.medical_kit,
                            color: Theme.of(context).primaryColor),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget._doctor.ward,
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone,
                            color: Theme.of(context).primaryColor),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget._doctor.phone,
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[800]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
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
                      'Notes',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        (widget._doctor.notes.isNotEmpty)
                            ? widget._doctor.notes
                            : 'No additional notes specified.',
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
          )
        ],
      ),
    );
  }
}
