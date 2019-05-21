///
/// `homepage.dart`
/// Class for homepage GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';
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
  User _user;

  int _currentIndex = 2;

  // Utility Method: Returns ...something?
  ListTile listTileCus({String name, String subtitle, Object icon, Object page}) {
    return ListTile(
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
  }

  // Utility Method: Returns a card
  Card cusCard({String name, String subtitle, Object icon}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: listTileCus(
          name: name,
          subtitle: subtitle,
          icon: icon,
        ),
      ),
    );
  }

  // Utility Method: Returns text title
  Text textTitle({String title}) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        fontFamily: 'Raleway',
        color: Colors.blueGrey,
      ),
      textAlign: TextAlign.center,
    );
  }

  // |----------------------Medicine

  // Data Method: Returns a list of medicine
  List<Widget> totalMedic() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    ];

    for (int i = 0; i < 4; i++) {
      list.add(
        cusCard(
          name: "Paracetamal",
          subtitle: "5 left",
          icon: Icons.battery_full,
        ),
      );
    }
    return list;
  }

  // GUI Method: Returns GUI of medicine tab
  ListView leftMedicine() {
    return ListView(
      shrinkWrap: true,
      children: totalMedic(),
    );
  }
  // |----------------------end Medicine

  // |----------------------Appointment

  // Data Method: Returns a list of appointments
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

    for (int i = 0; i < 4; i++) {
      list.add(cusCard(
          name: "Appointment with Dr.Rawit",
          subtitle: "At Payathai Ht. afternoon",
          icon: Icons.person_pin_circle));
    }
    return list;
  }

  // GUI Method: Returns GUI of appointment tab
  ListView leftAppointment() {
    return ListView(
      shrinkWrap: true,
      children: totalAppoint(),
    );
  }

  // |----------------------end Appointment

  // |-------------------------- Overview

  // Data Method: Returns list of coming appointments
  List<Widget> comingAppointment() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.all(10),
        child: textTitle(title: "Coming Appointments"),
      ),
    ];
    for (int i = 0; i < 2; i++) {
      list.add(
        cusCard(
          name: "Appointment with Dr.Rawit",
          subtitle: "This Saturday afternoon",
          icon: Icons.local_hospital,
        ),
      );
    }
    return list;
  }

  // Data Method: Returns list of remaining indose
  List<Widget> remainIndose() {
    List<Widget> list = [
      Padding(padding: const EdgeInsets.all(10), child: textTitle(title: "Remaining Indose"))
    ];

    for (int i = 0; i < 4; i++) {
      list.add(
        cusCard(
          name: "Paracetamal",
          subtitle: "2 shot after lunch",
          icon: Icons.battery_full,
        ),
      );
    }

    return list;
  }

  // GUI Method: Returns GUI of overview tab
  ListView overview() {
    return ListView(
      shrinkWrap: true,
      children: comingAppointment() + [SizedBox(height: 20.0)] + remainIndose(),
    );
  }

  // |----------------------end Overview

  // |----------------------Doctor

  // Data Method: Returns a list of doctors
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

    for (int i = 0; i < 4; i++) {
      list.add(
        cusCard(
          name: "Dr.Rawit",
          subtitle: "At Payathai Ht. afternoon",
          icon: Icons.person,
        ),
      );
    }

    return list;
  }

  // GUI Method: Returns GUI of doctor tab
  ListView rightDoctor() {
    return ListView(
      shrinkWrap: true,
      children: allDoctor(),
    );
  }

  void _refreshState() {
    // TODO: Implements method
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Implements loading data from firebase
    this._user = User(
      id: '',
      email: 'teerapat_saint@hotmail.com',
      firstName: 'Teerapat',
      lastName: 'Kraisrisirikul',
      gender: 'male',
      bloodGroup: 'O+',
      birthDate: DateTime(1999, 6, 15),
      height: 172.0,
      weight: 53.0,
      image: null,
      medicineList: <Medicine>[
        Medicine(
          id: '1',
          name: 'Dibendryl',
          description: '',
          type: 'tablet',
          image: null,
          doseAmount: 1,
          totalAmount: 10,
          medicineSchedule: MedicineSchedule(
            time: [true, true, true, false],
            day: [true, true, true, true, true, true, true],
            isBeforeMeal: false,
          ),
        ),
        Medicine(
          id: '2',
          name: 'Isotetronoine',
          description: '',
          type: 'tablet',
          image: null,
          doseAmount: 1,
          totalAmount: 10,
          medicineSchedule: MedicineSchedule(
            time: [false, false, true, false],
            day: [true, false, true, false, true, false, true],
            isBeforeMeal: false,
          ),
        ),
      ],
      appointmentList: List<Appointment>(),
      doctorList: List<Doctor>(),
      hospitalList: List<Hospital>(),
      userSettings: UserSettings(),
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
          icon: Icon(Icons.help, color: Colors.blue),
          onPressed: () {
            Navigator.pushNamed(context, 'IntroPage');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(this._user)),
            );
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
      <IconButton>[],
    ];

    List<Widget> pages = <Widget>[
      leftMedicine(),
      leftAppointment(),
      overview(),
      rightDoctor(),
      Center(child: Text('Waiting for map API implementation.')),
    ];

    List headerTitle = [
      Text('Medicine List', style: TextStyle(color: Colors.blueGrey)),
      Text('Appointment List', style: TextStyle(color: Colors.blueGrey)),
      Text('MedicCare', style: TextStyle(color: Colors.blueGrey)),
      Text('Doctor List', style: TextStyle(color: Colors.blueGrey)),
      Text('Nearby Hospitals', style: TextStyle(color: Colors.blueGrey))
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
      body: pages[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13.5,
        unselectedFontSize: 11.5,
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        onTap: (int i) {
          setState(() {
            this._currentIndex = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_full),
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
