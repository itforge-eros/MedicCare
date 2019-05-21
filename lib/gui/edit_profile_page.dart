import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

class EditProfilePage extends StatefulWidget {
  final Function _refreshState;
  final User _user;

  EditProfilePage(this._refreshState, this._user);

  @override
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerFirstName = TextEditingController();
  static final TextEditingController _controllerLastName = TextEditingController();
  static final TextEditingController _controllerHeight = TextEditingController();
  static final TextEditingController _controllerWeight = TextEditingController();
  DateTime _currentBirthDate;
  String _currentGender;
  String _currentBloodGroup;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void updateProfile() {
    widget._user.firstName = _controllerFirstName.text;
    widget._user.lastName = _controllerLastName.text;
    widget._user.gender = this._currentGender;
    widget._user.birthDate = this._currentBirthDate;
    widget._user.height = (double.parse(_controllerHeight.text) * 10).roundToDouble() / 10;
    widget._user.weight = (double.parse(_controllerWeight.text) * 10).roundToDouble() / 10;
    widget._user.bloodGroup = this._currentBloodGroup;
  }

  @override
  void initState() {
    super.initState();
    _controllerFirstName.text = widget._user.firstName;
    _controllerLastName.text = widget._user.lastName;
    _controllerHeight.text = widget._user.height.toString();
    _controllerWeight.text = widget._user.weight.toString();
    _currentBirthDate = widget._user.birthDate;
    _currentGender = widget._user.gender;
    _currentBloodGroup = widget._user.bloodGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Edit Profile',
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
              FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Change Image',
                child: Icon(Icons.add_a_photo),
              ),
              TextFormField(
                controller: _controllerFirstName,
                decoration:
                    InputDecoration(labelText: 'First Name', prefixIcon: Icon(Icons.person)),
                keyboardType: TextInputType.text,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill first name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerLastName,
                decoration: InputDecoration(labelText: 'Last Name', prefixIcon: Icon(Icons.person)),
                keyboardType: TextInputType.text,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill last name';
                  }
                },
              ),
              SizedBox(height: 10.0),
              DropdownButton(
                isExpanded: true,
                hint: Text('Gender'),
                value: this._currentGender,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'others',
                    child: Text('Others'),
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    this._currentGender = value;
                  });
                },
              ),
              DateTimePickerFormField(
                initialValue:
                    (widget._user.birthDate != null) ? widget._user.birthDate : DateTime.now(),
                initialDate:
                    (widget._user.birthDate != null) ? widget._user.birthDate : DateTime.now(),
                format: DateFormat('yyyy-MM-dd'),
                inputType: InputType.date,
                editable: true,
                decoration: InputDecoration(
                  labelText: 'Birthdate',
                  prefixIcon: Icon(Icons.cake),
                ),
                onChanged: (DateTime date) {
                  _currentBirthDate = date;
                },
                validator: (DateTime time) {
                  if (time == null) {
                    return 'Please fill birthdate';
                  } else if (time.compareTo(DateTime.now()) > 0) {
                    return 'Invalid birthdate';
                  }
                },
              ),
              TextFormField(
                controller: _controllerHeight,
                decoration: InputDecoration(
                  hintText: 'Height',
                  prefixIcon: Icon(Icons.assessment),
                  suffixText: 'cm',
                ),
                keyboardType: TextInputType.number,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill height';
                  }
                  try {
                    if (double.parse(text) <= 0) {
                      return 'Invalid height';
                    }
                  } catch (e) {
                    return 'Height must be a valid number';
                  }
                },
              ),
              TextFormField(
                controller: _controllerWeight,
                decoration: InputDecoration(
                  hintText: 'Weight',
                  prefixIcon: Icon(Icons.assessment),
                  suffixText: 'kg',
                ),
                keyboardType: TextInputType.number,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill weight';
                  }
                  try {
                    if (double.parse(text) <= 0) {
                      return 'Invalid weight';
                    }
                  } catch (e) {
                    return 'Weight must be a valid number';
                  }
                },
              ),
              DropdownButton(
                isExpanded: true,
                hint: Text('Blood Group'),
                value: this._currentBloodGroup,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'O+',
                    child: Text('O+'),
                  ),
                  DropdownMenuItem(
                    value: 'O-',
                    child: Text('O-'),
                  ),
                  DropdownMenuItem(
                    value: 'A+',
                    child: Text('A+'),
                  ),
                  DropdownMenuItem(
                    value: 'A-',
                    child: Text('A-'),
                  ),
                  DropdownMenuItem(
                    value: 'B+',
                    child: Text('B+'),
                  ),
                  DropdownMenuItem(
                    value: 'B-',
                    child: Text('B-'),
                  ),
                  DropdownMenuItem(
                    value: 'AB+',
                    child: Text('AB+'),
                  ),
                  DropdownMenuItem(
                    value: 'AB-',
                    child: Text('AB-'),
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    this._currentBloodGroup = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Save'),
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    this.updateProfile();
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
