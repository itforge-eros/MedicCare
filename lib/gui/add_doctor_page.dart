import 'dart:io';

///
/// `add_doctor_page.dart`
/// Class for medicine addition page GUI
///

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctorPage extends StatefulWidget {
  final Function _refreshState;

  AddDoctorPage(this._refreshState);

  @override
  State<StatefulWidget> createState() {
    return _AddDoctorPageState();
  }
}

class _AddDoctorPageState extends State<AddDoctorPage> {

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Add Doctor',
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0.1,
      ),
      body: Center(
        child: ListView(
          padding:
              EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0, bottom: 15.0),
          children: <Widget>[
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            // TODO: Completes form
            TextFormField(
              decoration: InputDecoration(hintText: 'Prefix'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Firstname'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Lastname'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Ward'),
            ),
                        TextFormField(
              decoration: InputDecoration(hintText: 'Hospital'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Phone'),
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: 'Notes'),
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