///
/// `add_medicine_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/util/alert.dart';

class AddMedicinePage extends StatefulWidget {
  Function _refreshState;
  User _user;
  Medicine _medicine;

  AddMedicinePage({Function refreshState, User user}) {
    this._refreshState = refreshState;
    this._user = user;
  }

  AddMedicinePage.editMode({Function refreshState, User user, Medicine medicine}) {
    this._refreshState = refreshState;
    this._user = user;
    this._medicine = medicine;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddMedicinePageState();
  }
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerMedicineName = TextEditingController();
  static final TextEditingController _controllerDescription = TextEditingController();
  static final TextEditingController _controllerDoseAmount = TextEditingController();
  static final TextEditingController _controllerTotalAmount = TextEditingController();
  String _currentMedicineType = 'capsule';
  MedicineSchedule _currentMedicineSchedule = MedicineSchedule();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void clearFields() {
    _controllerMedicineName.text = '';
    _controllerDescription.text = '';
    _controllerDoseAmount.text = '';
    _controllerTotalAmount.text = '';
    this._currentMedicineType = 'capsule';
    this._currentMedicineSchedule = MedicineSchedule();
  }

  void loadFields() {
    if (widget._medicine != null) {
      _controllerMedicineName.text = widget._medicine.name;
      _controllerDescription.text = widget._medicine.description;
      _controllerDoseAmount.text = widget._medicine.doseAmount.toString();
      _controllerTotalAmount.text = widget._medicine.totalAmount.toString();
      this._currentMedicineType = widget._medicine.type;
      this._currentMedicineSchedule = widget._medicine.medicineSchedule;
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
          (widget._medicine == null) ? 'Add Medicine' : 'Edit Medicine',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
        actions: (widget._medicine == null)
            ? <Widget>[]
            : <Widget>[
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Alert.displayConfirmDelete(
                      context,
                      title: 'Delete Medicine?',
                      content:
                          'Deleting this medicine will permanently remove it from your medicine list.',
                      onPressedConfirm: () {
                        widget._user.medicineList.remove(widget._medicine);
                        Navigator.of(context).pop();
                        Navigator.pop(context);
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
                decoration: InputDecoration(hintText: 'Medicine Name'),
                controller: _controllerMedicineName,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill medicine name';
                  }
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Description'),
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'Please fill description';
                  }
                },
              ),
              DropdownButton(
                isExpanded: true,
                value: this._currentMedicineType,
                items: [
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
                decoration: InputDecoration(labelText: 'Dose Amount'),
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
                decoration: InputDecoration(labelText: 'Total Amount'),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                            },
                          ),
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
                        title: 'Invalid Data',
                        content: 'Dose amount must be less than or equal to total amount.',
                      );
                    } else {
                      widget._user.medicineList.add(Medicine(
                        name: _controllerMedicineName.text,
                        description: _controllerDescription.text,
                        type: this._currentMedicineType,
                        image: Image.file(this._image),
                        doseAmount: int.parse(_controllerDoseAmount.text),
                        totalAmount: int.parse(_controllerTotalAmount.text),
                        medicineSchedule: this._currentMedicineSchedule,
                      ));
                      widget._refreshState();
                      Navigator.pop(context);
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
