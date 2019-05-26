///
/// `add_doctor_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/homepage.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/firebase_utils.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'location.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyA2B775mUfKZPORyzvlUjxlyyalfx0Qd_E";

class AddDoctorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddDoctorPageState();
  }
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  static final TextEditingController _controllerPrefix =
      TextEditingController();
  static final TextEditingController _controllerFirstName =
      TextEditingController();
  static final TextEditingController _controllerLastName =
      TextEditingController();
  static final TextEditingController _controllerWard = TextEditingController();
  static final TextEditingController _controllerHospitalId =
      TextEditingController();
  static final TextEditingController _controllerHospitalName =
      TextEditingController();
  static final TextEditingController _controllerPhone = TextEditingController();
  static final TextEditingController _controllerNotes = TextEditingController();
  File _image;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadPic(String doctorId) async {
    String userId = await FirebaseUtils.getUserId();

    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$userId/doctor/$doctorId');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("profile pic is uploaded");
    });
  }

  void clearFields() {
    _controllerPrefix.text = '';
    _controllerFirstName.text = '';
    _controllerLastName.text = '';
    _controllerWard.text = '';
    _controllerHospitalId.text = '';
    _controllerHospitalName.text = '';
    _controllerPhone.text = '';
    _controllerNotes.text = '';
  }

  @override
  void initState() {
    super.initState();
    this.clearFields();
  }

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

  Future<Null> savePlace(String placeId, String placeName) async {
    if (placeId != null) {
      _controllerHospitalId.text = placeId;
      _controllerHospitalName.text = placeName;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      savePlace(p.placeId, p.description);
    } catch (e) {
      return;
    }
  }

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text(
            'Add Doctor',
            style: TextStyle(color: Colors.blueGrey),
          ),
          backgroundColor: Colors.white.withOpacity(0.9),
          elevation: 0.1,
          actions: <Widget>[]),
      body: Form(
        key: this._formKey,
        child: Center(
          child: ListView(
            padding:
                EdgeInsets.only(left: 30.0, top: 1, right: 30.0, bottom: 15.0),
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Color(0xffffffff),
                            child: ClipOval(
                              child: SizedBox(
                                width: 150.0,
                                height: 150.0,
                                child: (_image != null)
                                    ? Image.file(_image, fit: BoxFit.fill)
                                    : Image.asset(
                                        "assets/person.png",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
              TextFormField(
                controller: _controllerPrefix,
                decoration: InputDecoration(hintText: 'Prefix'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill doctor\'s prefix';
                  }
                },
              ),
              TextFormField(
                controller: _controllerFirstName,
                decoration: InputDecoration(hintText: 'First name'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill doctor\'s first name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerLastName,
                decoration: InputDecoration(hintText: 'Last name'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill doctor\'s last name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerWard,
                decoration: InputDecoration(hintText: 'Ward'),
              ),
              RaisedButton(
                child: Text(_controllerHospitalName.text),
                  onPressed: () {
                    _handlePressButton();
                  },
              ),
              TextFormField(
                controller: _controllerPhone,
                decoration: InputDecoration(hintText: 'Phone'),
              ),
              TextFormField(
                controller: _controllerNotes,
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Notes'),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    void addNewDoctor() async {
                      Doctor newDoctor = Doctor(
                        prefix: _controllerPrefix.text,
                        firstName: _controllerFirstName.text,
                        lastName: _controllerLastName.text,
                        ward: _controllerWard.text,
                        hospital: _controllerHospitalId.text,
                        phone: _controllerPhone.text,
                        notes: _controllerNotes.text,
                        image: null,
                      );
                      String doctorId =
                          await FirebaseUtils.addDoctor(newDoctor);

                      if (_image != null) {
                        await uploadPic(doctorId);
                      }

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage(
                                    initialIndex: 3,
                                  )),
                          ModalRoute.withName('LoginPage'));
                    }

                    addNewDoctor();
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
