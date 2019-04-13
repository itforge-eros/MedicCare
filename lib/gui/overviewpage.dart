import 'package:flutter/material.dart';


 Widget listTileCus = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.black38))),
          child: Icon(Icons.local_hospital, color: Colors.blue[300]),
        ),
        title: Text(
          "Methyl Salicylate",
          style:
              TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.blueAccent),
            Text("Daily Indose Alert", style: TextStyle(color: Colors.black54))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Colors.blue[300], size: 30.0));

    Widget cusCard = Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: listTileCus,
      ),
    );

    Widget body = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return cusCard;
        },
      ),
    );
