///
/// `homepage.dart`
/// Class for homepage GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/gui/add_medicine_page.dart';
import 'package:mediccare/gui/profile_page.dart';
import 'package:mediccare/gui/add_appointment_page.dart';
import 'package:mediccare/gui/medicine_page.dart';
import 'package:mediccare/gui/add_doctor_page.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 2;

  Widget listTileCus({String name, String subtitle, Object icon, Object page}) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration:
              BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.black38))),
          child: Icon(icon, color: Colors.blue[300]),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.blueAccent),
            Text(subtitle, style: TextStyle(color: Colors.black54))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue[300], size: 30.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicinePage()),
          );
        },
      );

  Card cusCard({String name, String subtitle, Object icon}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: listTileCus(name: name, subtitle: subtitle, icon: icon),
      ),
    );
  }

  Text textTitle({String title}) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Raleway', color: Colors.blueGrey),
      textAlign: TextAlign.center,
    );
  }

// |-------------------------- Overview
  List<Widget> remainIndose() {
    List<Widget> list = [
      Padding(padding: const EdgeInsets.all(10), child: textTitle(title: "Remaining Indose"))
    ];
    for (int i = 0; i < 10; i++) {
      list.add(
          cusCard(name: "Paracetamal", subtitle: "2 shot after lunch", icon: Icons.battery_alert));
    }
    return list;
  }

  List<Widget> comingAppointment() {
    List<Widget> list = [
      Padding(
          padding: const EdgeInsets.all(10), child: textTitle(title: "Your Coming\nAppointments"))
    ];
    for (int i = 0; i < 3; i++) {
      list.add(cusCard(
          name: "Appointment with Dr.Rawit",
          subtitle: "This Saturday afternoon",
          icon: Icons.local_hospital));
    }
    return list;
  }

  ListView overView() => ListView(
        shrinkWrap: true,
        children: comingAppointment() + remainIndose(),
      );

  // |----------------------end Overview
  // |----------------------Medicine

  List<Widget> totalMedic() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (value) {},
          // controller: ,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    ];

    for (int i = 0; i < 6; i++) {
      list.add(cusCard(name: "Pracetimal", subtitle: "5 left", icon: Icons.battery_full));
    }
    return list;
  }

  ListView leftMedicine() {
    return ListView(
      shrinkWrap: true,
      children: totalMedic(),
    );
  }
  // |----------------------end Medicine
  // |----------------------Appointment

  List<Widget> totalAppoint() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (value) {},
          // controller: ,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
          ),
        ),
      ),
    ];

    for (int i = 0; i < 6; i++) {
      list.add(cusCard(
          name: "Appointment with Dr.Rawit",
          subtitle: "At Payathai Ht. afternoon",
          icon: Icons.local_hospital));
    }
    return list;
  }

  ListView leftAppointment() {
    return ListView(
      shrinkWrap: true,
      children: totalAppoint(),
    );
  }

  // |----------------------end Appointment
  void _refreshState() {
    // TODO: Implements method
    setState(() {});
  }

  //---------------------doctor
  List<Widget> allDoctor() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (value) {},
          // controller: ,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
          ),
        ),
      ),
    ];

    for (int i = 0; i < 6; i++) {
      list.add(cusCard(
          name: "Dr.Rawit", subtitle: "At Payathai Ht. afternoon", icon: Icons.local_hospital));
    }
    return list;
  }

  ListView rightDoctor() {
    return ListView(
      shrinkWrap: true,
      children: allDoctor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    final List<List<IconButton>> actions = <List<IconButton>>[
      // Index 0 : Medicine
      <IconButton>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddMedicinePage(_refreshState)),
            );
          },
        ),
      ],

      // Index 1 : Appointment
      <IconButton>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAppointmentPage(_refreshState)),
            );
          },
        ),
      ],

      // Index 2 : Overview
      <IconButton>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
        IconButton(
            icon: Icon(Icons.help, color: Colors.blue),
            onPressed: () {
              Navigator.pushNamed(context, 'IntroPage');
            },
          ),
      ],

      // Index 3 : Doctor
      <IconButton>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddDoctorPage(_refreshState)),
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
    ];

    List<Widget> _pages = <Widget>[
      leftMedicine(),
      leftAppointment(),
      overView(),
      rightDoctor(),
      Text('#4'),
    ];

    List headerTitle = [
      Text('Your Medicine', style: TextStyle(color: Colors.blueGrey)),
      Text('Your Appointment', style: TextStyle(color: Colors.blueGrey)),
      Text('MedicCare', style: TextStyle(color: Colors.blueGrey)),
      Text('Your Doctor', style: TextStyle(color: Colors.blueGrey)),
      Text('Your Hospital', style: TextStyle(color: Colors.blueGrey))
    ];

    return Scaffold(
      appBar: AppBar(
        title: headerTitle[this._currentIndex],
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: actions[this._currentIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _currentIndex = 2;
          setState(() {});
        },
        child: Icon(Icons.face),
        elevation: 3.0,
      ),
      body: _pages[this._currentIndex],
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
            icon: Icon(Icons.local_pharmacy, color: Colors.white),
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
