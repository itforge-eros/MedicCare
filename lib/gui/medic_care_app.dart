///
/// `medic_scare_app.dart`
/// Main MedicCare application class
///

import 'package:flutter/material.dart';
import 'package:mediccare/gui/init_account_page.dart';
import 'package:mediccare/gui/intro_page.dart';
import 'package:mediccare/gui/login_page.dart';
import 'package:mediccare/gui/register_page.dart';
import 'package:mediccare/gui/homepage.dart';
import 'package:mediccare/gui/user_settings_page.dart';
import 'package:mediccare/gui/welcome_page.dart';

class MedicCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
      routes: {
        'LoginPage': (context) => LoginPage(),
        'RegisterPage': (context) => RegisterPage(),
        'InitAccountPage': (context) => InitAccountPage(),
        'WelcomePage': (context) => WelcomePage(),
        'Homepage': (context) => Homepage(),
        'IntroPage': (context) => IntroPage(),
      },
    );
  }
}
