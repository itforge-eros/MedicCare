///
/// `add_medicine_page.dart`
/// Class for medicine addition page GUI
///

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';

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
  DateTime _currentDateAdded;
  MedicineSchedule _currentMedicineSchedule = MedicineSchedule();
  File _currentImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _currentImage = image;
    });
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

  void loadFields() {
    if (widget._medicine != null) {
      _controllerMedicineName.text = widget._medicine.name;
      _controllerDescription.text = widget._medicine.description;
      _controllerDoseAmount.text = widget._medicine.doseAmount.toString();
      _controllerTotalAmount.text = widget._medicine.totalAmount.toString();
      this._currentMedicineType = widget._medicine.type;
      this._currentDateAdded = widget._medicine.dateAdded;
      this._currentMedicineSchedule = widget._medicine.medicineSchedule;
    }
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
                decoration: InputDecoration(labelText: 'Medicine Name'),
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
                enabled: (widget._medicine == null),
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
                enabled: (widget._medicine == null),
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
              (widget._medicine == null)
                  ? DateTimePickerFormField(
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
                    )
                  : TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date Added',
                      ),
                      initialValue: widget._medicine.dateAdded.toString().replaceRange(16, 23, ''),
                      enabled: false,
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
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.time[0] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Breakfast'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.time[2],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.time[2] = value;
                                    });
                                  }
                                : null,
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
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.time[1] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Lunch'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.time[3],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.time[3] = value;
                                    });
                                  }
                                : null,
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
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[0] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Monday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.day[1],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[1] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Tuesday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.day[2],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[2] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Wednesday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.day[3],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[3] = value;
                                    });
                                  }
                                : null,
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
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[4] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Friday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.day[5],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[5] = value;
                                    });
                                  }
                                : null,
                          ),
                          Text('Saturday'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: this._currentMedicineSchedule.day[6],
                            onChanged: (widget._medicine == null)
                                ? (bool value) {
                                    setState(() {
                                      this._currentMedicineSchedule.day[6] = value;
                                    });
                                  }
                                : null,
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
                        title: 'Invalid Medicine Amount',
                        content: 'Dose amount must be less than or equal to total amount.',
                      );
                    }
                    if (int.parse(_controllerTotalAmount.text) %
                            int.parse(_controllerDoseAmount.text) !=
                        0) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Dose',
                        content: 'Total amount must be able to divide by dose amount.',
                      );
                    } else if (!_currentMedicineSchedule.time.contains(true)) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Time',
                        content: 'Medicine must be taken at least once per day to be taken.',
                      );
                    } else if (!_currentMedicineSchedule.day.contains(true)) {
                      Alert.displayAlert(
                        context,
                        title: 'Invalid Medicine Day',
                        content: 'Medicine must be taken at least one day per week.',
                      );
                    } else {
                      Image image;

                      try {
                        image = Image.file(this._currentImage);
                      } catch (e) {
                        image = null;
                      }

                      if (widget._medicine == null) {
                        widget._user.medicineList.add(
                          Medicine(
                            name: _controllerMedicineName.text,
                            description: _controllerDescription.text,
                            type: this._currentMedicineType,
                            image: image,
                            doseAmount: int.parse(_controllerDoseAmount.text),
                            totalAmount: int.parse(_controllerTotalAmount.text),
                            medicineSchedule: this._currentMedicineSchedule,
                            dateAdded: this._currentDateAdded,
                          ),
                        );
                      } else {
                        widget._medicine.name = _controllerMedicineName.text;
                        widget._medicine.description = _controllerDescription.text;
                        widget._medicine.type = this._currentMedicineType;
                        widget._medicine.image = image;
                        widget._medicine.medicineSchedule.isBeforeMeal = this._currentMedicineSchedule.isBeforeMeal;
                      }
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
