///
/// hospital.dart
/// Class contains data of hospital
///

import 'package:flutter/material.dart';

class Hospital {
  String _id;
  String _name;
  String _address;
  String _notes;
  Image _image;

  Hospital({
    String id,
    String name,
    String address,
    String notes,
  }) {
    this._id = id;
    this._name = name;
    this._address = address;
    this._notes = notes;
  }

  String get id => this._id;
  set id(id) => this._id = id;

  String get name => this._name;
  set name(name) => this._name = name;

  String get address => this._address;
  set address(address) => this._address = address;

  String get notes => this._notes;
  set notes(notes) => this._notes = notes;

  Image get image => this._image;
  set image(image) => this._image = image;
}
