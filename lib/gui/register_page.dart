///
/// `register_page.dart`
/// Class for register page GUI
///

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static final TextEditingController _controllerEmail = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();
  static final TextEditingController _controllerPasswordConfirm = TextEditingController();

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
