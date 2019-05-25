///
/// `register_page.dart`
///  Class contain GUI for register page
///

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/firebase_utils.dart';
import 'package:mediccare/util/validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerEmail = TextEditingController();
  static final TextEditingController _controllerPassword =
      TextEditingController();
  static final TextEditingController _controllerPasswordConfirm =
      TextEditingController();

  void signUpWithEmail() async {
    FirebaseUser user;
    this._trimEmailField();
    try {
      user = await _auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // Event: sign up successful
        Alert.displayAlert(
          context,
          title: 'Registration Success',
          content:
              'New account created, you are now able to use this new account to login.',
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
        );
        FirebaseUtils.createUserData(user.uid, _controllerEmail.text);
      } else {
        // Event: Sign up failed
        Alert.displayAlert(
          context,
          title: 'Registration failed',
          content:
              'This email address has already been registered. Please try again with a different email address.',
        );
      }
      this._clearFields();
    }
  }

  void _clearFields() {
    _RegisterPageState._controllerEmail.text = '';
    _RegisterPageState._controllerPassword.text = '';
    _RegisterPageState._controllerPasswordConfirm.text = '';
  }

  void _trimEmailField() {
    _RegisterPageState._controllerEmail.text =
        _RegisterPageState._controllerEmail.text.trim();
  }

  @override
  void initState() {
    super.initState();
    FirebaseUtils.isLogin().then((isLogin) async {
      if (isLogin) {
        bool exist = await FirebaseUtils.getUserExist();
        if (exist) {
          Navigator.pushReplacementNamed(context, 'Homepage');
        } else {
          Navigator.pushReplacementNamed(context, 'InitAccountPage');
        }
      } else {
        return;
      }
    });
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
      validator: (String email) {
        if (!Validator.isEmail(email)) {
          return 'Please enter a valid email address';
        }
      },
    );

    final TextFormField textFormFieldPassword = TextFormField(
      keyboardType: TextInputType.text,
      controller: _controllerPassword,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Password',
      ),
      validator: (String password) {
        return Validator.validatePassword(password, 3);
      },
    );

    final TextFormField textFormFieldPasswordConfirm = TextFormField(
      keyboardType: TextInputType.text,
      controller: _controllerPasswordConfirm,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Confirm Password',
      ),
      validator: (String passwordConfirm) {
        if (passwordConfirm != _controllerPassword.text) {
          return 'Passwords mismatch';
        }
      },
    );

    final RaisedButton buttonRegister = RaisedButton(
      child: Text("REGISTER"),
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          this.signUpWithEmail();
        }
      },
    );

    return Form(
      key: this._formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.only(
                left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
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
      ),
    );
  }
}
