///
/// `login_page.dart`
/// Class for login page GUI
///

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediccare/util/alert.dart';
import 'package:mediccare/util/firebase_utils.dart';
import 'package:mediccare/util/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerEmail = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseUtils.getUser().then((user) {
      if (user != null) {
        Navigator.pushNamed(context, 'Homepage');
      }
    });
  }

  void signInWithEmail() async {
    FirebaseUser user;
    this._trimEmailField();

    try {
      user = await _auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        Navigator.pushNamed(context, 'Homepage');
        this._clearFields();
      } else {
        Alert.displayConfirm(
          context: context,
          title: 'Login failed',
          content: 'Invalid email address or password.',
        );
        this._clearPasswordField();
      }
    }
  }

  void _clearFields() {
    _LoginPageState._controllerEmail.text = '';
    _LoginPageState._controllerPassword.text = '';
  }

  void _clearPasswordField() {
    _LoginPageState._controllerPassword.text = '';
  }

  void _trimEmailField() {
    _LoginPageState._controllerEmail.text = _LoginPageState._controllerEmail.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final TextFormField textFormFieldEmail = TextFormField(
      keyboardType: TextInputType.text,
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
        if (password.isEmpty) {
          return 'Please enter password';
        }
      },
    );

    final RaisedButton buttonLogin = RaisedButton(
      child: Text('LOGIN'),
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          signInWithEmail();
        }
      },
    );

    final FlatButton buttonRegister = FlatButton(
      child: Text('Register New Account'),
      textColor: Theme.of(context).primaryColorDark,
      padding: EdgeInsets.only(right: 0.0),
      onPressed: () {
        Navigator.pushNamed(context, 'RegisterPage');
      },
    );

    return Form(
      key: this._formKey,
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            children: <Widget>[
              Container(
                child: Image.asset('assets/logo_temporary.jpg'),
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
              ),
              SizedBox(height: 20.0),
              textFormFieldEmail,
              SizedBox(height: 10.0),
              textFormFieldPassword,
              SizedBox(height: 20.0),
              buttonLogin,
              Container(
                child: buttonRegister,
                alignment: Alignment.centerRight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
