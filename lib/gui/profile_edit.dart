import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final Function _refreshState;
  EditProfile(this._refreshState);
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
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
          'Edit Profile',
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
            tooltip: 'Change Image',
            child: Icon(Icons.add_a_photo),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Gender'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Date of Birth'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Height'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Weight'),
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
