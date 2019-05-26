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

class AddDoctorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddDoctorPageState();
  }
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerPrefix =
      TextEditingController();
  static final TextEditingController _controllerFirstName =
      TextEditingController();
  static final TextEditingController _controllerLastName =
      TextEditingController();
  static final TextEditingController _controllerWard = TextEditingController();
  static final TextEditingController _controllerHospital =
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
    _controllerHospital.text = '';
    _controllerPhone.text = '';
    _controllerNotes.text = '';
  }

  @override
  void initState() {
    super.initState();
    this.clearFields();
  }

  @override
  Widget build(BuildContext context) {
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
                            backgroundColor: Color(0xff476cfb),
                            child: ClipOval(
                              child: SizedBox(
                                width: 150.0,
                                height: 150.0,
                                child: (_image != null)
                                    ? Image.file(_image, fit: BoxFit.fill)
                                    : Image.network(
                                        "https://image.flaticon.com/icons/png/512/64/64572.png",
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
                        hospital: _controllerHospital.text,
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
