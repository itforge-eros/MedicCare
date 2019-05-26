///
/// `homepage.dart`
/// Class for homepage GUI
///
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mediccare/core/appointment.dart';
import 'package:mediccare/core/doctor.dart';
import 'package:mediccare/core/hospital.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/medicine_schedule.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/core/user_setting.dart';
import 'package:mediccare/gui/add_medicine_page.dart';
import 'package:mediccare/gui/map_page.dart';
import 'package:mediccare/gui/appointment_page.dart';
import 'package:mediccare/gui/doctor_page.dart';
import 'package:mediccare/gui/profile_page.dart';
import 'package:mediccare/gui/add_appointment_page.dart';
import 'package:mediccare/gui/medicine_page.dart';
import 'package:mediccare/gui/add_doctor_page.dart';
import 'package:mediccare/util/custom_icons.dart';
import 'package:mediccare/util/firebase_utils.dart';

class Homepage extends StatefulWidget {
  int initialIndex;

  Homepage({Key key, this.initialIndex = 2}) : super(key: key);

  // Homepage({int initialIndex}) {
  //   _initialIndex = initialIndex;
  // }

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  User _user;
  int _currentIndex = 2;

  Future<List<Doctor>> _getDoctors;
  Future<List<Medicine>> _getMedicines;

  // Utility Method: Returns Custom List Tile
  ListTile getCustomListTile({
    String name,
    String subtitle,
    Object icon,
    Widget trailing,
    Function onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black38)),
        ),
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
      trailing: trailing ??
          Icon(Icons.keyboard_arrow_right, color: Colors.blue[300], size: 30.0),
      onTap: onTap ?? () {},
    );
  }

  // Utility Method: Returns custom card
  Card getCustomCard({
    String name,
    String subtitle,
    Object icon,
    Widget trailing,
    Function onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: getCustomListTile(
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

  // Utility Method: Returns section divider
  Container getSectionDivider(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Raleway',
          color: Colors.blueGrey[400],
        ),
      ),
    );
  }

  // Utility Method: Returns formatted date
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
    return dateTime.day.toString() +
        ' ' +
        month +
        ' ' +
        dateTime.year.toString();
  }

  // |---------------------- Medicine List

  // Data Method: Returns a list of medicine
  List<Widget> totalMedic(List<Medicine> medicines) {
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

    List<Medicine> remainingMedicine = List();
    List<Medicine> emptyMedicine = List();

    if (medicines.length == 0) {
      list.add(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('assets/images/medical-grey.png', height: 200),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              'Start adding your medicine now!',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ));
    } else {
      medicines.forEach((m) {
        if (m.remainingAmount == 0) {
          emptyMedicine.add(m);
        } else {
          remainingMedicine.add(m);
        }
      });

      if (remainingMedicine.length > 0) {
        list.add(getSectionDivider('Remaining Medicines'));
        remainingMedicine.forEach((e) {
          list.add(
            getCustomCard(
              name: e.name,
              subtitle: e.getSubtitle(),
              icon: CustomIcons.medicine,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicinePage(
                          medicine: e,
                        ),
                  ),
                );
              },
            ),
          );
        });
      }
    }

    if (emptyMedicine.length > 0) {
      list.add(getSectionDivider('Depleted Medicines'));
      emptyMedicine.forEach((e) {
        list.add(
          getCustomCard(
            name: e.name,
            subtitle: e.getSubtitle(),
            icon: CustomIcons.medicine,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicinePage(
                        medicine: e,
                      ),
                ),
              );
            },
          ),
        );
      });
    }

    return list;
  }

  // GUI Method: Returns GUI of medicine tab
  Container getMedicineListPage() {
    return Container(
      child: FutureBuilder(
          future: _getMedicines,
          builder: (_, medicines) {
            if (medicines.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else if (medicines.connectionState == ConnectionState.done) {
              return ListView(
                shrinkWrap: true,
                children: totalMedic(medicines.data),
              );
            }
          }),
    );
  }
  // |---------------------- end Medicine List

  // |---------------------- Appointment List

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
            //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
            // ),
          ),
        ),
      ),
    ];

    this._user.appointmentList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    if (this._user.containsComingAppointments()) {
      list.add(getSectionDivider('Coming Appointments'));
      this._user.appointmentList.forEach((e) {
        if (e.status == 0) {
          list.add(
            getCustomCard(
              name: e.title,
              subtitle: ' ' + e.dateTime.toString().replaceAll(':00.000', ''),
              icon: Icons.local_hospital,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(
                          refreshState: this.refreshState,
                          user: this._user,
                          appointment: e,
                        ),
                  ),
                );
              },
            ),
          );
        }
      });
    }

    if (this._user.containsCompletedAppointments()) {
      list.add(getSectionDivider('Completed Appointments'));
      this._user.appointmentList.forEach((e) {
        if (e.status == 1) {
          list.add(
            getCustomCard(
              name: e.title,
              subtitle: ' ' + e.dateTime.toString().replaceAll(':00.000', ''),
              icon: Icons.local_hospital,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(
                          refreshState: this.refreshState,
                          user: this._user,
                          appointment: e,
                        ),
                  ),
                );
              },
            ),
          );
        }
      });
    }

    if (this._user.containsSkippedAppointments()) {
      list.add(getSectionDivider('Skipped Appointments'));
      this._user.appointmentList.forEach((e) {
        if (e.status == 2) {
          list.add(
            getCustomCard(
              name: e.title,
              subtitle: ' ' + e.dateTime.toString().replaceAll(':00.000', ''),
              icon: Icons.local_hospital,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(
                          refreshState: this.refreshState,
                          user: this._user,
                          appointment: e,
                        ),
                  ),
                );
              },
            ),
          );
        }
      });
    }

    return list;
  }

  // GUI Method: Returns GUI of appointment tab
  ListView getAppointmentListPage() {
    return ListView(
      shrinkWrap: true,
      children: totalAppoint(),
    );
  }

  // |---------------------- end Appointment List

  // |-------------------------- Overview

  // Data Method: Returns list of coming appointments
  List<Widget> getComingAppointmentList() {
    List<Widget> list = List<Widget>();
    this._user.appointmentList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    if (this._user.containsComingAppointments()) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: textTitle(title: 'Coming Appointments'),
        ),
      );

      this._user.appointmentList.forEach((e) {
        if (e.status == 0) {
          String formattedDate =
              DateFormat('MMM dd | kk:mm').format(e.dateTime);
          list.add(
            getCustomCard(
              name: e.title,
              subtitle: formattedDate,
              // subtitle: e.dateTime.toString().replaceAll(':00.000', '').split(' ').join('\n'),
              // subtitle: e.dateTime.toString(),
              icon: Icons.local_hospital,
              trailing: (DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                          ).compareTo(DateTime(
                            e.dateTime.year,
                            e.dateTime.month,
                            e.dateTime.day,
                          )) >=
                          0 ||
                      true) // TODO: Reconsider checkable condition and remove || true
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: 'view',
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text('  View'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'check',
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                Text('  Check'),
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
                        onChanged: (dynamic value) {
                          setState(
                            () {
                              if (value == 'check') {
                                e.status = 1;
                              } else if (value == 'skip') {
                                e.status = 2;
                              } else if (value == 'view') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentPage(
                                          refreshState: this.refreshState,
                                          user: this._user,
                                          appointment: e,
                                        ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  : Icon(Icons.edit, color: Colors.grey),
            ),
          );
        }
      });
    }

    return list;
  }

  // Data Method: Returns list of remaining indose
  List<Widget> getRemainingIndoseList() {
    List<Widget> list = List<Widget>();

    if (this._user.containsRemainingMedicine()) {
      list.add(
        Padding(
            padding: const EdgeInsets.all(10),
            child: textTitle(title: 'Remaining Indose')),
      );

      List<DateTime> dateList = List<DateTime>();
      this._user.getMedicineOverview().forEach((e) {
        if (!dateList.contains(
            DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day))) {
          dateList
              .add(DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day));
        }
      });

      dateList.sort((a, b) => a.compareTo(b));

      dateList.forEach((e) {
        list.add(
          getSectionDivider((e.compareTo(DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  )) !=
                  0)
              ? getFormattedDate(e)
              : getFormattedDate(e) + ' (Today)'),
        );
        this._user.getMedicineOverview().forEach((f) {
          if (e.year == f.dateTime.year &&
              e.month == f.dateTime.month &&
              e.day == f.dateTime.day) {
            list.add(
              getCustomCard(
                name: f.medicine.name,
                subtitle: f.getSubtitle(),
                icon: CustomIcons.medicine,
                trailing: (DateTime.now().compareTo(
                                    f.dateTime.subtract(Duration(hours: 1))) >
                                0 &&
                            DateTime(
                                  f.dateTime.year,
                                  f.dateTime.month,
                                  f.dateTime.day,
                                  f.dateTime.hour,
                                  f.dateTime.minute,
                                ).compareTo(this
                                    ._user
                                    .getMedicineOverview()[0]
                                    .dateTime) ==
                                0 ||
                        true) // TODO: Removes || true
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
                          onChanged: (dynamic value) {
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
                    : Icon(Icons.edit, color: Colors.grey),
              ),
            );
          }
        });
      });
    }

    return list;
  }

  // GUI Method: Returns GUI of overview tab
  Widget getOverviewPage() {
    if (!this._user.containsComingAppointments() &&
        !this._user.containsRemainingMedicine()) {
      return getSectionDivider(
          'Your overview feed is currently empty.\nAdding a medicine or an appointment will show them up here!');
    }

    return ListView(
      shrinkWrap: true,
      children: getComingAppointmentList() +
          [SizedBox(height: 20.0)] +
          getRemainingIndoseList(),
    );
  }

  // |----------------------end Overview

  // |----------------------Doctor

  // Data Method: Returns a list of doctors
  List<Widget> getDoctorList(List<Doctor> doctors) {
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
          ),
        ),
      ),
    ];
    if (doctors.length != 0) {
      doctors.forEach((e) {
        list.add(
          getCustomCard(
            name: e.prefix + ' ' + e.firstName + ' ' + e.lastName,
            subtitle: ' ' + e.hospital,
            icon: CustomIcons.doctor_specialist,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorPage(
                        doctor: e,
                      ),
                ),
              );
            },
          ),
        );
      });
    } else {
      list.add(Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/doctor-grey.png',
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text("Add your personal doctors now!",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ));
    }

    return list;
  }

  // GUI Method: Returns GUI of doctor tab
  Container getDoctorListPage() {
    return Container(
      child: FutureBuilder(
        future: _getDoctors,
        builder: (_, doctors) {
          if (doctors.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else if (doctors.connectionState == ConnectionState.done) {
            return ListView(
              shrinkWrap: true,
              children: getDoctorList(doctors.data),
            );
          }
        },
      ),
    );
  }

  void refreshState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // TODO: Implements loading data from firebase
    _getDoctors = FirebaseUtils.getDoctors();
    _getMedicines = FirebaseUtils.getMedicines();

    this._currentIndex = widget.initialIndex;

    // NOTES: This is a mocked-up data used in testing.
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
            time: [true, false, false, true],
            day: [true, true, true, true, true, true, true],
            isBeforeMeal: false,
          ),
          dateAdded: DateTime(2019, 5, 23, 9, 0),
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
          dateAdded: DateTime(2019, 5, 24, 9, 0),
        ),
      ],
      appointmentList: List<Appointment>(),
      doctorList: <Doctor>[
        Doctor(
          prefix: 'Dr.',
          firstName: 'Rawit',
          lastName: 'Lohakachornphan',
          ward: 'Dentistry',
          hospital: 'Rawitshie Personal Clinic',
          phone: '081-XXX-XXXX',
          notes: '',
          image: null,
        ),
        Doctor(
          prefix: 'Dr.',
          firstName: 'Wiput',
          lastName: 'Pootong',
          ward: 'Sexual Organs',
          hospital: 'Wiput\'s Personal Hospital',
          phone: '081-XXX-XXXX',
          notes: '',
          image: null,
        ),
      ],
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
    this._user.addAppointment(
          Appointment(
            title: 'Dentist Appointment',
            description: 'Weekly check',
            doctor: this._user.doctorList[0],
            hospital: 'Rawitshie Personal Clinic',
            dateTime: DateTime(2019, 5, 23, 11, 0),
            status: 0,
          ),
        );
    this._user.addAppointment(
          Appointment(
            title: 'Surgery Appointment',
            description: 'Weekly check',
            doctor: this._user.doctorList[0],
            hospital: 'Rawitshie Personal Clinic',
            dateTime: DateTime(2019, 5, 25, 10, 0),
            status: 0,
          ),
        );
    this._user.addAppointment(
          Appointment(
            title: 'Coughing Cure',
            description: 'Weekly check',
            doctor: this._user.doctorList[0],
            hospital: 'Rawitshie Personal Clinic',
            dateTime: DateTime(2019, 5, 27, 10, 0),
            status: 0,
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
                builder: (context) => AddMedicinePage(),
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
              MaterialPageRoute(
                builder: (context) => AddAppointmentPage(
                      refreshState: refreshState,
                      user: this._user,
                    ),
              ),
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
              MaterialPageRoute(builder: (context) => ProfilePage()),
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
              MaterialPageRoute(
                builder: (context) => AddDoctorPage(),
              ),
            );
          },
        ),
      ],

      // Index 4 : Hospital
      <IconButton>[],
    ];

    List<Widget> pages = <Widget>[
      getMedicineListPage(),
      getAppointmentListPage(),
      getOverviewPage(),
      getDoctorListPage(),
      MapPage(),
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
            icon: Icon(CustomIcons.medicine),
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
            icon: Icon(CustomIcons.doctor_specialist),
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
