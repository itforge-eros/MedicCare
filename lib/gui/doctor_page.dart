import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/add_doctor_page.dart';
import 'package:mediccare/gui/edit_doctor_page.dart';
import 'package:mediccare/util/custom_icons.dart';
import 'package:mediccare/util/firebase_utils.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'location.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyA2B775mUfKZPORyzvlUjxlyyalfx0Qd_E";

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
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.overlay,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      print(" this is placeID ${p.placeId}");
      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

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
                tag: (widget._doctor.image != null)
                    ? widget._doctor.image
                    : "https://image.flaticon.com/icons/png/512/64/64572.png",
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (widget._doctor.image != null)
                          ? NetworkImage(widget._doctor.image)
                          : NetworkImage(
                              "https://image.flaticon.com/icons/png/512/64/64572.png"),
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
              RaisedButton(
                child: Text("map"),
                onPressed: () async {
                  await showDetailPlace(widget._doctor.hospitalId);
                },
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
