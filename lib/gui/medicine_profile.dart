import 'package:flutter/material.dart';

class MedicineProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MedicineProfileState();
}

class MedicineProfileState extends State {
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
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        // padding:
        //     EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
        children: <Widget>[
          Container(
            child: Text(
              "Medicine Name",
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
                  "Remaining Medicine",
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "15",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "in dose",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black45),
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
                      "Each intake",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "2",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      "intake",
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
                      "Schedule",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      "hour",
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
                      "Type",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold),
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
                      "Capsule",
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
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Medical Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Ad nisi consequat ullamco sit Lorem nisi veniam cillum non nisi excepteur cupidatat aliquip.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black45),
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
