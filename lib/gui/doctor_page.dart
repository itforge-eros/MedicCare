import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorPageState();
  }
}

class DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Doctor Profile',
          style: TextStyle(color: Colors.blueGrey),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Colors.white.withOpacity(0.9),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddMedicinePage.editMode(
              //           refreshState: widget._refreshState,
              //           user: widget._user,
              //           medicine: widget._medicine,
              //         ),
              //   ),
              // );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'assets/logo_temporary.jpg',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/logo_temporary.jpg'))),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Dr. Wiput Pootong',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                'Bangkok, TH',
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
              ),
              
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Works at',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Phyathai Nawamin Hospital',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Lives in',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Jail',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'From',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Bangkok',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
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
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
