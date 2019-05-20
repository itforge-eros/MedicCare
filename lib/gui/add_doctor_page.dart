///
/// `add_doctor_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/util/alert.dart';

class AddDoctorPage extends StatefulWidget {
  Function _refreshState;
  Doctor _doctor;

  AddDoctorPage(Function refreshState) {
    this._refreshState = refreshState;
  }

  AddDoctorPage.editMode(Function refreshState, Doctor doctor) {
    this._refreshState = refreshState;
    this._doctor = doctor;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddDoctorPageState();
  }
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerPrefix = TextEditingController();
  static final TextEditingController _controllerFirstName = TextEditingController();
  static final TextEditingController _controllerLastName = TextEditingController();
  static final TextEditingController _controllerWard = TextEditingController();
  static final TextEditingController _controllerHospital = TextEditingController();
  static final TextEditingController _controllerPhone = TextEditingController();
  static final TextEditingController _controllerNotes = TextEditingController();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
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
    if (widget._doctor != null) {
      _controllerPrefix.text = widget._doctor.prefix;
      _controllerFirstName.text = widget._doctor.firstName;
      _controllerLastName.text = widget._doctor.lastName;
      _controllerWard.text = widget._doctor.ward;
      _controllerHospital.text = widget._doctor.hospital;
      _controllerPhone.text = widget._doctor.phone;
      _controllerNotes.text = widget._doctor.notes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          (widget._doctor == null) ? 'Add Doctor' : 'Edit Doctor',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
        actions: (widget._doctor == null)
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Alert.displayConfirmDelete(
                      context,
                      title: 'Delete Doctor',
                      content: 'Are you sure you want to delete this doctor?',
                      onPressedConfirm: () {
                        // TODO: Implements doctor deletion
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
