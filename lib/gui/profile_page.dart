import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

///
/// `profile_page.dart`
/// Class for profile page GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediccare/gui/user_settings_page.dart';
import 'package:mediccare/util/firebase_utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> _getUser;
  User _user;

  Text titleText({String title}) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text contextText({String context}) {
    return Text(
      context,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black54,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _getUser = FirebaseUtils.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.blueGrey),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettingsPage(
                        user: this._user,
                      ),
                ),
              );
            },
          ),
        ],
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

              this._user = userInstance;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: FlutterLogo(
                        size: 130,
                      ),
                    ),
                    Text(
                      userInstance.firstName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userInstance.lastName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        userInstance.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleText(title: 'Gender'),
                          contextText(
                            context: userInstance.gender[0].toUpperCase() +
                                userInstance.gender.replaceRange(0, 1, ''),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleText(title: 'Date of Birth'),
                          contextText(
                              context: userInstance.getFormattedBirthDate())
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleText(title: 'Height'),
                          contextText(
                              context: userInstance.height.toString() + ' cm'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleText(title: 'Weight'),
                          contextText(
                              context: userInstance.weight.toString() + ' kg'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleText(title: 'Blood Group'),
                          contextText(context: userInstance.bloodGroup),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                          color: Colors.white,
                          elevation: 4.0,
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                      user: userInstance,
                                    ),
                              ),
                            );
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Color.fromRGBO(216, 32, 32, 1),
                                fontSize: 15),
                          ),
                          color: Colors.white,
                          elevation: 4.0,
                          splashColor: Colors.redAccent,
                          onPressed: () {
                            _auth.signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'LoginPage', (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
