///
/// `medicine_page.dart`
/// Class for medicine page GUI
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/medicine.dart';
import 'package:mediccare/core/user.dart';
import 'package:mediccare/gui/add_medicine_page.dart';
import 'package:mediccare/gui/edit_medicine_page.dart';

class MedicinePage extends StatefulWidget {
  Medicine _medicine;

  MedicinePage({Medicine medicine}) {
    this._medicine = medicine;
  }

  @override
  State<StatefulWidget> createState() {
    return _MedicinePageState();
  }
}

class _MedicinePageState extends State<MedicinePage> {
  // Utility Method
  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  // Data Method
  String getMedicineDaysDescription() {
    String text = 'Take this medicine';
    int days = 0;
    int counted = 0;

    if (widget._medicine.medicineSchedule.day[0] &&
        widget._medicine.medicineSchedule.day[1] &&
        widget._medicine.medicineSchedule.day[2] &&
        widget._medicine.medicineSchedule.day[3] &&
        widget._medicine.medicineSchedule.day[4] &&
        !widget._medicine.medicineSchedule.day[5] &&
        !widget._medicine.medicineSchedule.day[6]) {
      return text + ' on weekdays.';
    } else if (!widget._medicine.medicineSchedule.day[0] &&
        !widget._medicine.medicineSchedule.day[1] &&
        !widget._medicine.medicineSchedule.day[2] &&
        !widget._medicine.medicineSchedule.day[3] &&
        !widget._medicine.medicineSchedule.day[4] &&
        widget._medicine.medicineSchedule.day[5] &&
        widget._medicine.medicineSchedule.day[6]) {
      return text + ' on weekends.';
    } else if (widget._medicine.medicineSchedule.day[0] &&
        widget._medicine.medicineSchedule.day[1] &&
        widget._medicine.medicineSchedule.day[2] &&
        widget._medicine.medicineSchedule.day[3] &&
        widget._medicine.medicineSchedule.day[4] &&
        widget._medicine.medicineSchedule.day[5] &&
        widget._medicine.medicineSchedule.day[6]) {
      return text + ' everyday.';
    }

    widget._medicine.medicineSchedule.day.forEach((e) {
      if (e) {
        days++;
      }
    });

    text += ' on';

    for (int i = 0; i < widget._medicine.medicineSchedule.day.length; i++) {
      if (widget._medicine.medicineSchedule.day[i]) {
        text += ' ' +
            [
              'monday',
              'tuesday',
              'wednesday',
              'thursday',
              'friday',
              'saturday',
              'sunday',
            ][i];
        counted++;

        if (days > 1 && days - counted == 1) {
          text += ' and';
        } else if (counted < days) {
          text += ',';
        }
      }
    }

    return text + '.';
  }

  // Data Method
  List<Widget> getMedicineTimeWidget() {
    List<Widget> list = List<Widget>();

    for (int i = 0; i < widget._medicine.medicineSchedule.time.length; i++) {
      List<IconData> icons = [
        Icons.free_breakfast,
        Icons.fastfood,
        Icons.local_dining,
        Icons.brightness_3,
      ];
      List<String> labels = ['Breakfast', 'Lunch', 'Dinner', 'Bedtime'];

      if (widget._medicine.medicineSchedule.time[i]) {
        list.add(
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    icons[i],
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(labels[i],
                    style: TextStyle(color: Colors.black45, fontSize: 15)),
              ],
            ),
          ),
        );
      }
    }

    return list;
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Medicine',
          style: TextStyle(color: Colors.blueGrey),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMedicinePage(
                        medicine: widget._medicine,
                      ),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        // padding:
        //     EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
        children: <Widget>[
          Container(
            child: Text(
              widget._medicine.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Remaining Medicine',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget._medicine.remainingAmount.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    'in dose',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Each Intake',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget._medicine.doseAmount.toString(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      'Intake',
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Schedule',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.local_dining,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      (widget._medicine.medicineSchedule.isBeforeMeal)
                          ? 'Before meal'
                          : 'After meal',
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Type',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.battery_full,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      capitalize(widget._medicine.type),
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Medicine Time',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getMedicineTimeWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Medical Description',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    widget._medicine.description,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  'Medicine Schedule',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    getMedicineDaysDescription(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
