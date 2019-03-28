///
/// `homepage.dart`
/// Class for homepage GUI
///

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    Text('#1'),
    Text('#2'),
    Text('#3'),
    Text('#4'),
    Text('#5'),
    Text('#6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedicCare'),
        centerTitle: true,
      ),
      body: this._pages[this._currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int i) {
            setState(() {
              this._currentIndex = i;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Overview'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.battery_unknown),
              title: Text('Medicine'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_circle),
              title: Text('Appointment'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Doctor'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text('Hospital'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
