///
/// `add_doctor_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/gui/homepage.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/firebase_utils.dart';

class EditDoctorPage extends StatefulWidget {
  Doctor _doctor;

  EditDoctorPage({Doctor doctor}) {
    this._doctor = doctor;
  }

  @override
  State<StatefulWidget> createState() {
    return _EditDoctorPageState();
  }
}

class _EditDoctorPageState extends State<EditDoctorPage> {
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
  String _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    String userId = await FirebaseUtils.getUserId();

    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('$userId/doctor/${widget._doctor.id}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    String imageUrl = await firebaseStorageRef.getDownloadURL();

    setState(() {
      _image = imageUrl;
      widget._doctor.image = imageUrl;
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

  void loadFields() {
    if (widget._doctor != null) {
      _controllerPrefix.text = widget._doctor.prefix;
      _controllerFirstName.text = widget._doctor.firstName;
      _controllerLastName.text = widget._doctor.lastName;
      _controllerWard.text = widget._doctor.ward;
      _controllerHospital.text = widget._doctor.hospital;
      _controllerPhone.text = widget._doctor.phone;
      _controllerNotes.text = widget._doctor.notes;
      _image =
          widget._doctor.image; // TODO: Implements image adding and loading
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
          'Edit Doctor',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () {
              Alert.displayConfirmDelete(
                context,
                title: 'Delete Doctor?',
                content:
                    'Deleting this doctor will permanently remove it from your doctor list.',
                onPressedConfirm: () {
                  FirebaseUtils.deleteDoctor(widget._doctor);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage(
                                initialIndex: 3,
                              )),
                      ModalRoute.withName('LoginPage'));
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
            padding: EdgeInsets.only(
                left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
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
                                      ? Image.network(_image, fit: BoxFit.fill)
                                      : Image.network(
                                          "https://image.flaticon.com/icons/png/512/64/64572.png",
                                          fit: BoxFit.fill,
                                        )),
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
                    widget._doctor.prefix = _controllerPrefix.text;
                    widget._doctor.firstName = _controllerFirstName.text;
                    widget._doctor.lastName = _controllerLastName.text;
                    widget._doctor.ward = _controllerWard.text;
                    widget._doctor.hospital = _controllerHospital.text;
                    widget._doctor.phone = _controllerPhone.text;
                    widget._doctor.notes = _controllerNotes.text;
                    // TODO: Implements image adding and loading

                    FirebaseUtils.updateDoctor(widget._doctor);
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
