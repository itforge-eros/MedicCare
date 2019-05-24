///
/// `welcome_page.dart`
/// Class for intro page GUI
///

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Welcome to MedicCare',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30.0,
              fontFamily: 'Raleway'
            ),
          ),
        ),
      ),
    );
  }
}
