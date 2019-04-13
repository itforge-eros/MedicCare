///
/// `homepage.dart`
/// Class for homepage GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/gui/add_medicine_page.dart';
import './overviewpage.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 2;

  final List<Widget> _pages = <Widget>[
    // TODO: Implements pages
    Text('#0'),
    Text('#1'),
    body,
    Text('#3'),
    Text('#4'),
  ];

  void _refreshState() {
    // TODO: Implements method
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    final List<List<IconButton>> actions = <List<IconButton>>[
      // Index 0 : Overview
      <IconButton>[],

      // Index 1 : Medicine
      <IconButton>[
        IconButton(
          icon: Icon(Icons.add, color: color,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMedicinePage(_refreshState)),
            );
          },
        ),
      ],

      // Index 2 : Appointment
      <IconButton>[
        IconButton(
          icon: Icon(Icons.add, color: color,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => null),
              // TODO: Implements route
            );
          },
        ),
      ],

      // Index 3 : Doctor
      <IconButton>[
        IconButton(
          icon: Icon(Icons.add, color: color,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => null),
              // TODO: Implements route
            );
          },
        ),
      ],

      // Index 4 : Hospital
      <IconButton>[
        IconButton(
          icon: Icon(Icons.add, color: color),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => null),
              // TODO: Implements route
            );
          },
        ),
      ],

      // Index 5 : Settings
      <IconButton>[],
    ];

    TabController _control;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MedicCare',
          style: TextStyle(color: Colors.blueGrey),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: actions[this._currentIndex],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        onTap: (int i) {
          setState(() {
            this._currentIndex = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_unknown),
            title: Text('Medicine'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle),
            title: Text('Appointment'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Overview'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Doctor'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text('Hospital'),
          ),
        ],
      ),
    );
  }
}
