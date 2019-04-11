///
/// `add_medicine_page.dart`
/// Class for medicine addition page GUI
///

import 'package:flutter/material.dart';

class AddMedicinePage extends StatefulWidget {
  final Function _refreshState;

  AddMedicinePage(this._refreshState);

  @override
  State<StatefulWidget> createState() {
    return _AddMedicinePageState();
  }
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
          children: <Widget>[
            // TODO: Completes form
            TextFormField(
              decoration: InputDecoration(hintText: 'Medicine Name'),
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Dose Amount'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Total Amount'),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                widget._refreshState();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
