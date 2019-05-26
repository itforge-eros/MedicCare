///
/// `add_medicine_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/gui/homepage.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/api_util.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';
import 'package:mediccare/util/firebase_utils.dart';

class AddMedicinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddMedicinePageState();
  }
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerMedicineName =
      TextEditingController();
  static final TextEditingController _controllerDescription =
      TextEditingController();
  static final TextEditingController _controllerDoseAmount =
      TextEditingController();
  static final TextEditingController _controllerTotalAmount =
      TextEditingController();
  String _currentMedicineType = 'capsule';
  DateTime _currentDateAdded;
  MedicineSchedule _currentMedicineSchedule = MedicineSchedule();
  File _currentImage;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _currentImage = image;
    });
  }

  Future uploadPic(String medicineId) async {
    String userId = await FirebaseUtils.getUserId();

    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$userId/medicine/$medicineId');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_currentImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    setState(() {});
  }

  void clearFields() {
    _controllerMedicineName.text = '';
    _controllerDescription.text = '';
    _controllerDoseAmount.text = '';
    _controllerTotalAmount.text = '';
    this._currentMedicineType = 'capsule';
    this._currentDateAdded = null;
    this._currentMedicineSchedule = MedicineSchedule();
  }

  // Utility Method
  String getUnit() {
    switch (this._currentMedicineType) {
      case 'capsule':
      case 'drop':
      case 'lozenge':
      case 'tablet':
        return this._currentMedicineType + '(s)';
      case 'cream':
      case 'spray':
        return 'time(s)';
      case 'liquid':
        return 'ml';
    }
    return null;
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
          'Add Medicine',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
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
                            backgroundColor: Color(0xffffffff),
                            child: ClipOval(
                              child: SizedBox(
                                width: 150.0,
                                height: 150.0,
                                child: (_currentImage != null)
                                    ? Image.file(_currentImage,
                                        fit: BoxFit.fill)
                                    : Image.asset(
                                        "assets/medicine.png",
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
              SizedBox(height: 10.0),
              FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _controllerMedicineName,
                  decoration: InputDecoration(labelText: 'Medicine Name'),
                ),
                suggestionsCallback: (String pattern) async {
                  return await APIUtil.getMedicineNameList(pattern: pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _controllerMedicineName.text = suggestion;
                },
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill medicine name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill description';
                  }
                },
              ),
              DropdownButton(
                isExpanded: true,
                value: this._currentMedicineType,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'capsule',
                    child: Text('Capsule'),
                  ),
                  DropdownMenuItem(
                    value: 'cream',
                    child: Text('Cream / Ointment'),
                  ),
                  DropdownMenuItem(
                    value: 'drop',
                    child: Text('Drop'),
                  ),
                  DropdownMenuItem(
                    value: 'liquid',
                    child: Text('Liquid / Syrup'),
                  ),
                  DropdownMenuItem(
                    value: 'lozenge',
                    child: Text('Lozenge'),
                  ),
                  DropdownMenuItem(
                    value: 'spray',
                    child: Text('Spray'),
                  ),
                  DropdownMenuItem(
                    value: 'tablet',
                    child: Text('Tablet'),
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    this._currentMedicineType = value;
                  });
                },
              ),
              TextFormField(
                controller: _controllerDoseAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Dose Amount',
                  suffixText: getUnit(),
                ),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill dose amount';
                  } else {
                    try {
                      int _ = int.parse(text);
                      if (_ <= 0) {
                        return 'Dose amount must be at least 1';
                      }
                    } catch (e) {
                      return 'Dose amount must be integer';
                    }
                  }
                },
              ),
              TextFormField(
                controller: _controllerTotalAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Amount',
                  suffixText: getUnit(),
                ),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill total amount';
                  } else {
                    try {
                      int _ = int.parse(text);
                      if (_ <= 0) {
                        return 'Total amount must be at least 1';
                      }
                    } catch (e) {
                      return 'Total amount must be an integer';
                    }
                  }
                },
              ),
              DateTimePickerFormField(
                initialDate: DateTime.now(),
                format: DateFormat('yyyy-MM-dd HH:mm'),
                inputType: InputType.both,
                decoration: InputDecoration(
                  labelText: 'Date Added',
                  helperText: 'Leave blank to use the current time.',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onChanged: (DateTime dateTime) {
                  try {
                    this._currentDateAdded = dateTime;
                  } catch (e) {}
                },
                validator: (DateTime dateTime) {},
              ),
              SizedBox(height: 20.0),
              Text('Before/After Meal'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        value: true,
                        groupValue: this._currentMedicineSchedule.isBeforeMeal,
                        onChanged: (bool value) {
                          setState(() {
                            this._currentMedicineSchedule.isBeforeMeal = value;
                          });
                        },
                      ),
                      Text('Before Meal'),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: false,
                        groupValue: this._currentMedicineSchedule.isBeforeMeal,
                        onChanged: (bool value) {
                          setState(() {
                            this._currentMedicineSchedule.isBeforeMeal = value;
                          });
                        },
                      ),
                      Text('After Meal'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text('Medicine Time'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.time[0],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.time[0] = value;
                                });
                              }),
                          Text('Breakfast'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.time[2],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.time[2] = value;
                                });
                              }),
                          Text('Dinner'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.time[1],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.time[1] = value;
                                });
                              }),
                          Text('Lunch'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.time[3],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.time[3] = value;
                                });
                              }),
                          Text('Bedtime'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text('Medicine Schedule'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[0],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[0] = value;
                                });
                              }),
                          Text('Monday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[1],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[1] = value;
                                });
                              }),
                          Text('Tuesday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[2],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[2] = value;
                                });
                              }),
                          Text('Wednesday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[3],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[3] = value;
                                });
                              }),
                          Text('Thursday'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[4],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[4] = value;
                                });
                              }),
                          Text('Friday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[5],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[5] = value;
                                });
                              }),
                          Text('Saturday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: this._currentMedicineSchedule.day[6],
                              onChanged: (bool value) {
                                setState(() {
                                  this._currentMedicineSchedule.day[6] = value;
                                });
                              }),
                          Text('Sunday'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    if (int.parse(_controllerDoseAmount.text) >
                        int.parse(_controllerTotalAmount.text)) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Amount',
                        content:
                            'Dose amount must be less than or equal to total amount.',
                      );
                    }
                    if (int.parse(_controllerTotalAmount.text) %
                            int.parse(_controllerDoseAmount.text) !=
                        0) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Dose',
                        content:
                            'Total amount must be able to divide by dose amount.',
                      );
                    } else if (!_currentMedicineSchedule.time.contains(true)) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Time',
                        content:
                            'Medicine must be taken at least once per day to be taken.',
                      );
                    } else if (!_currentMedicineSchedule.day.contains(true)) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Day',
                        content:
                            'Medicine must be taken at least one day per week.',
                      );
                    } else {
                      void doAddMedicine() async {
                        Medicine medicine = Medicine(
                          name: _controllerMedicineName.text,
                          description: _controllerDescription.text,
                          type: this._currentMedicineType,
                          doseAmount: int.parse(_controllerDoseAmount.text),
                          totalAmount: int.parse(_controllerTotalAmount.text),
                          medicineSchedule: this._currentMedicineSchedule,
                          dateAdded: this._currentDateAdded,
                        );

                        String medicineId =
                            await FirebaseUtils.addMedicine(medicine);

                        if (_currentImage != null) {
                          await uploadPic(medicineId);
                        }

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage(
                                      initialIndex: 0,
                                    )),
                            ModalRoute.withName('LoginPage'));
                      }

                      doAddMedicine();
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
