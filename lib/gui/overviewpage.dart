import 'package:flutter/material.dart';

Widget listTileCus({String name, String subtitle}) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black38))),
      child: Icon(Icons.local_hospital, color: Colors.blue[300]),
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
    trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.blue[300], size: 30.0));

Widget cusCard() => Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  elevation: 5,
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  child: Container(
    decoration: BoxDecoration(color: Colors.white),
    child: listTileCus(name: "Paracetimal", subtitle : "2 shot after lunch" ),
  ),
);


List<Widget> remainIndose= [
  Text("Did you take\n your Medicine?"),
  ListView.builder(
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return cusCard();
      },
    ),
];

List<Widget> comingAppoint = [
  Text("Comming\n Appointment")

];



Widget body = ListView(
  shrinkWrap: true,
  children:  remainIndose + comingAppoint,
);
