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
import 'package:mediccare/util/alert.dart';

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
  ListTile listTileCustom(
      {String name, String subtitle, Object icon, Widget trailing, Function onTap}) {
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
      trailing: trailing ?? Icon(Icons.keyboard_arrow_right, color: Colors.blue[300], size: 30.0),
      onTap: onTap ?? () {},
    );
  }

  // Utility Method: Returns a card
  Card cardCustom({String name, String subtitle, Object icon, Widget trailing, Function onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: listTileCustom(
          name: name,
          subtitle: subtitle,
          icon: icon,
          trailing: trailing,
          onTap: onTap,
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

  // Utility Method
  String getFormattedDate(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
    }
    return dateTime.day.toString() + ' ' + month + ' ' + dateTime.year.toString();
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
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    ];

    this._user.medicineList.forEach((e) {
      list.add(
        cardCustom(
          name: e.name,
          subtitle: e.getSubtitle(),
          icon: Icons.battery_full,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicinePage(
                      refreshState: this._refreshState,
                      user: this._user,
                      medicine: e,
                    ),
              ),
            );
          },
        ),
      );
    });

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
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
          ),
        ),
      ),
    ];

    for (int i = 0; i < 4; i++) {
      list.add(
        cardCustom(
          name: 'Appointment with Dr.Rawit',
          subtitle: 'At Payathai Ht. afternoon',
          icon: Icons.person_pin_circle,
        ),
      );
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
        child: textTitle(title: 'Coming Appointments'),
      ),
    ];
    for (int i = 0; i < 2; i++) {
      list.add(
        cardCustom(
          name: 'Appointment with Dr.Rawit',
          subtitle: 'This Saturday afternoon',
          icon: Icons.local_hospital,
        ),
      );
    }
    return list;
  }

  // Data Method: Returns list of remaining indose
  List<Widget> remainIndose() {
    List<Widget> list = [
      Padding(padding: const EdgeInsets.all(10), child: textTitle(title: 'Remaining Indose'))
    ];

    List<DateTime> dateList = List<DateTime>();
    this._user.getMedicineOverview().forEach((e) {
      if (!dateList.contains(DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day))) {
        dateList.add(DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day));
      }
    });

    dateList.forEach((e) {
      list.add(
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          alignment: Alignment.center,
          child: Text(
            getFormattedDate(e),
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Raleway',
              color: Colors.blueGrey[400],
            ),
          ),
        ),
      );
      this._user.getMedicineOverview().forEach((f) {
        if (e.year == f.dateTime.year && e.month == f.dateTime.month && e.day == f.dateTime.day) {
          list.add(
            cardCustom(
              name: f.medicine.name,
              subtitle: f.getSubtitle(),
              icon: Icons.battery_full,
              trailing: (DateTime.now().compareTo(f.dateTime.subtract(Duration(hours: 1))) > 0 &&
                      DateTime(
                            f.dateTime.year,
                            f.dateTime.month,
                            f.dateTime.day,
                            f.dateTime.hour,
                            f.dateTime.minute,
                          ).compareTo(this._user.getMedicineOverview()[0].dateTime) ==
                          0)
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: 'take',
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                Text('  Take'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'skip',
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                Text('  Skip'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value == 'take') {
                              f.medicine.takeMedicine();
                            } else if (value == 'skip') {
                              f.medicine.skipMedicine();
                            }
                          });
                        },
                      ),
                    )
                  : Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
            ),
          );
        }
      });
    });

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
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
          ),
        ),
      ),
    ];

    for (int i = 0; i < 4; i++) {
      list.add(
        cardCustom(
          name: 'Dr.Rawit',
          subtitle: 'At Payathai Ht. afternoon',
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
          description: 'Cures coughing.',
          type: 'tablet',
          image: null,
          doseAmount: 1,
          totalAmount: 10,
          medicineSchedule: MedicineSchedule(
            time: [true, true, true, false],
            day: [true, true, true, true, true, true, true],
            isBeforeMeal: false,
          ),
          dateUpdated: DateTime(2019, 5, 18),
        ),
        Medicine(
          id: '2',
          name: 'Isotetronoine',
          description:
              'Cures pimples. Do not take this medicine during or within 1 month before pregnancy.',
          type: 'tablet',
          image: null,
          doseAmount: 1,
          totalAmount: 10,
          medicineSchedule: MedicineSchedule(
            time: [false, false, true, false],
            day: [true, false, true, false, true, false, true],
            isBeforeMeal: false,
          ),
          dateUpdated: DateTime(2019, 5, 20),
        ),
      ],
      appointmentList: List<Appointment>(),
      doctorList: List<Doctor>(),
      hospitalList: List<Hospital>(),
      userSettings: UserSettings(
        notificationOn: true,
        notifyAheadDuration: Duration(minutes: 30),
        breakfastTime: Duration(hours: 7, minutes: 15),
        lunchTime: Duration(hours: 12, minutes: 0),
        dinnerTime: Duration(hours: 19, minutes: 0),
        sleepTime: Duration(hours: 23, minutes: 0),
      ),
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
              MaterialPageRoute(
                builder: (context) => AddMedicinePage(
                      refreshState: this._refreshState,
                      user: this._user,
                    ),
              ),
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
          setState(() {
            _currentIndex = 2;
          });
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
