///
/// `profile_page.dart`
/// Class for profile page GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _refreshState() {
    // TODO: Implements method
    setState(() {});
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Profile",
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
              Navigator.pushNamed(context, 'UserSettingsPage');
            },
          ),
        ],
      ),
      body: Padding(
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
              "Rawit",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Lohakhachornphan",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Rawitgun@gmail.com",
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
                children: <Widget>[titleText(title: "Gender"), contextText(context: "Male")],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  titleText(title: "Date of Birth"),
                  contextText(context: "4 April 1999")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[titleText(title: "Height"), contextText(context: "170 cm")],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[titleText(title: "Weight"), contextText(context: "60 kg")],
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
                              this._refreshState,
                              User(),
                            ),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Color.fromRGBO(216, 32, 32, 1), fontSize: 15),
                  ),
                  color: Colors.white,
                  elevation: 4.0,
                  splashColor: Colors.redAccent,
                  onPressed: () {
                    _auth.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('LoginPage', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
