import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  static final TextEditingController _controllerEmail = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();
  static final TextEditingController _controllerPasswordConfirm = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        print(user);
      }
    });
  }

  void signUpWithEmail() async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
      }
    }
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    final TextFormField textFormFieldEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _controllerEmail,
      decoration: InputDecoration(
        icon: Icon(Icons.mail),
        hintText: 'Email Address',
      ),
    );

    final TextFormField textFormFieldPassword = TextFormField(
      keyboardType: TextInputType.text,
      controller: _controllerPassword,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Password',
      ),
    );

    final TextFormField textFormFieldPasswordConfirm = TextFormField(
      keyboardType: TextInputType.text,
      controller: _controllerPasswordConfirm,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Confirm Password',
      ),
    );

    final RaisedButton buttonRegister = RaisedButton(
      child: Text("REGISTER"),
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        // TODO: Implements register
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
          children: <Widget>[
            textFormFieldEmail,
            SizedBox(height: 10.0),
            textFormFieldPassword,
            SizedBox(height: 10.0),
            textFormFieldPasswordConfirm,
            SizedBox(height: 20.0),
            buttonRegister,
          ],
        ),
      ),
    );
  }
}
