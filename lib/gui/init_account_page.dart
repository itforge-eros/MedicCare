///
/// `init_account_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

class InitAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InitAccountPageState();
  }
}

class _InitAccountPageState extends State<InitAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerFirstName = TextEditingController();
  static final TextEditingController _controllerLastName = TextEditingController();
  static final TextEditingController _controllerHeight = TextEditingController();
  static final TextEditingController _controllerWeight = TextEditingController();
  String _currentGender;
  DateTime _currentBirthDate;
  String _currentBloodGroup;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void clearFields() {
    _controllerFirstName.text = '';
    _controllerLastName.text = '';
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
          'Account Initiation',
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
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
              TextFormField(
                controller: _controllerFirstName,
                decoration: InputDecoration(labelText: 'First name'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill first name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerLastName,
                decoration: InputDecoration(labelText: 'Last name'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill last name';
                  }
                },
              ),
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
                initialValue: DateTime.now(),
                initialDate: DateTime.now(),
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
                child: Text('Start using MedicCare'),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    // TODO: Implements account initiation
                    if (this._currentGender == null) {
                      Alert.displayAlert(
                        context,
                        title: 'Missing Information',
                        content: 'Please select gender.',
                      );
                    } else if (this._currentBloodGroup == null) {
                      Alert.displayAlert(
                        context,
                        title: 'Missing Information',
                        content: 'Please select blood group.',
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, 'Homepage');
                    }
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
