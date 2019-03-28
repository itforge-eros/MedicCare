///
/// `login_page.dart`
/// Class for login page GUI
///

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static final TextEditingController _controllerEmail = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextFormField textFormFieldEmail = TextFormField(
      keyboardType: TextInputType.text,
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

    final RaisedButton buttonLogin = RaisedButton(
      child: Text('LOGIN'),
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, 'Homepage');
        // TODO: Implements login
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

    return Scaffold(
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
    );
  }
}
