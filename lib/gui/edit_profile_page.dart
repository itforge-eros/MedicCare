import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/util/datetime_picker_formfield.dart';
import 'package:mediccare/util/firebase_utils.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage();

  @override
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  Future<User> _getUser;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser = getUser();
  }

  Future<User> getUser() async {
    FirebaseUser firebaseUSer = await FirebaseUtils.getUser();

    var firestore = Firestore.instance;

    DocumentSnapshot userProfile =
        await firestore.collection('users').document(firebaseUSer.uid).get();

    User user = User(
        email: firebaseUSer.email,
        firstName: userProfile['firstName'],
        lastName: userProfile['lastName'],
        birthDate: DateTime.parse(userProfile['birthDate']),
        bloodGroup: userProfile['bloodGroup'],
        gender: userProfile['gender'],
        height: userProfile['height'],
        weight: userProfile['weight'],
        id: firebaseUSer.uid);

    return user;
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
      body: FutureBuilder(
        future: _getUser,
        builder: (_, user) {
          if (user.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else if (user.connectionState == ConnectionState.done) {
            User userInstance = user.data;

            _controllerFirstName.text = userInstance.firstName;
            _controllerLastName.text = userInstance.lastName;
            _controllerHeight.text = userInstance.height.toString();
            _controllerWeight.text = userInstance.weight.toString();

            return Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: getImage,
                      tooltip: 'Change Image',
                      child: Icon(Icons.add_a_photo),
                    ),
                    TextFormField(
                      controller: _controllerFirstName,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: Icon(Icons.person)),
                      keyboardType: TextInputType.text,
                      validator: (String text) {
                        if (text.isEmpty) {
                          return 'Please fill first name';
                        }
                      },
                    ),
                    TextFormField(
                      controller: _controllerLastName,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          prefixIcon: Icon(Icons.person)),
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
                      value: userInstance.gender,
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
                          userInstance.gender = value;
                        });
                      },
                    ),
                    DateTimePickerFormField(
                      format: DateFormat('yyyy-MM-dd'),
                      initialValue: userInstance.birthDate,
                      inputType: InputType.date,
                      editable: true,
                      decoration: InputDecoration(
                        labelText: 'Birthdate',
                        prefixIcon: Icon(Icons.cake),
                      ),
                      onChanged: (DateTime date) {
                        userInstance.birthDate = date;
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
                      value: userInstance.bloodGroup,
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
                          userInstance.bloodGroup = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      // body: Form(
      //   key: this._formKey,
      //   child: Center(
      //     child: ListView(
      //       padding: EdgeInsets.only(
      //           left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
      //       children: <Widget>[
      //         FloatingActionButton(
      //           onPressed: getImage,
      //           tooltip: 'Change Image',
      //           child: Icon(Icons.add_a_photo),
      //         ),
      //         TextFormField(
      //           controller: _controllerFirstName,
      //           decoration: InputDecoration(
      //               labelText: 'First Name', prefixIcon: Icon(Icons.person)),
      //           keyboardType: TextInputType.text,
      //           validator: (String text) {
      //             if (text.isEmpty) {
      //               return 'Please fill first name';
      //             }
      //           },
      //         ),
      //         TextFormField(
      //           controller: _controllerLastName,
      //           decoration: InputDecoration(
      //               labelText: 'Last Name', prefixIcon: Icon(Icons.person)),
      //           keyboardType: TextInputType.text,
      //           validator: (String text) {
      //             if (text.isEmpty) {
      //               return 'Please fill last name';
      //             }
      //           },
      //         ),
      //         SizedBox(height: 10.0),
      //         DropdownButton(
      //           isExpanded: true,
      //           hint: Text('Gender'),
      //           value: this._currentGender,
      //           items: <DropdownMenuItem<String>>[
      //             DropdownMenuItem(
      //               value: 'male',
      //               child: Text('Male'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'female',
      //               child: Text('Female'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'others',
      //               child: Text('Others'),
      //             ),
      //           ],
      //           onChanged: (String value) {
      //             setState(() {
      //               this._currentGender = value;
      //             });
      //           },
      //         ),
      //         DateTimePickerFormField(
      //           format: DateFormat('yyyy-MM-dd'),
      //           inputType: InputType.date,
      //           editable: true,
      //           decoration: InputDecoration(
      //             labelText: 'Birthdate',
      //             prefixIcon: Icon(Icons.cake),
      //           ),
      //           onChanged: (DateTime date) {
      //             _currentBirthDate = date;
      //           },
      //           validator: (DateTime time) {
      //             if (time == null) {
      //               return 'Please fill birthdate';
      //             } else if (time.compareTo(DateTime.now()) > 0) {
      //               return 'Invalid birthdate';
      //             }
      //           },
      //         ),
      //         TextFormField(
      //           controller: _controllerHeight,
      //           decoration: InputDecoration(
      //             hintText: 'Height',
      //             prefixIcon: Icon(Icons.assessment),
      //             suffixText: 'cm',
      //           ),
      //           keyboardType: TextInputType.number,
      //           validator: (String text) {
      //             if (text.isEmpty) {
      //               return 'Please fill height';
      //             }
      //             try {
      //               if (double.parse(text) <= 0) {
      //                 return 'Invalid height';
      //               }
      //             } catch (e) {
      //               return 'Height must be a valid number';
      //             }
      //           },
      //         ),
      //         TextFormField(
      //           controller: _controllerWeight,
      //           decoration: InputDecoration(
      //             hintText: 'Weight',
      //             prefixIcon: Icon(Icons.assessment),
      //             suffixText: 'kg',
      //           ),
      //           keyboardType: TextInputType.number,
      //           validator: (String text) {
      //             if (text.isEmpty) {
      //               return 'Please fill weight';
      //             }
      //             try {
      //               if (double.parse(text) <= 0) {
      //                 return 'Invalid weight';
      //               }
      //             } catch (e) {
      //               return 'Weight must be a valid number';
      //             }
      //           },
      //         ),
      //         DropdownButton(
      //           isExpanded: true,
      //           hint: Text('Blood Group'),
      //           value: this._currentBloodGroup,
      //           items: <DropdownMenuItem<String>>[
      //             DropdownMenuItem(
      //               value: 'O+',
      //               child: Text('O+'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'O-',
      //               child: Text('O-'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'A+',
      //               child: Text('A+'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'A-',
      //               child: Text('A-'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'B+',
      //               child: Text('B+'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'B-',
      //               child: Text('B-'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'AB+',
      //               child: Text('AB+'),
      //             ),
      //             DropdownMenuItem(
      //               value: 'AB-',
      //               child: Text('AB-'),
      //             ),
      //           ],
      //           onChanged: (String value) {
      //             setState(() {
      //               this._currentBloodGroup = value;
      //             });
      //           },
      //         ),
      //         SizedBox(height: 20.0),
      //         RaisedButton(
      //           color: Theme.of(context).primaryColor,
      //           child: Text('Save'),
      //           onPressed: () {
      //             if (this._formKey.currentState.validate()) {
      //               this.updateProfile();
      //               widget._refreshState();
      //               Navigator.pop(context);
      //             }
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
