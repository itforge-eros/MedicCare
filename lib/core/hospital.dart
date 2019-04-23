///
/// `hospital.dart`
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
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get address => this._address;
  set address(String address) => this._address = address;

  String get notes => this._notes;
  set notes(String notes) => this._notes = notes;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this._id,
      'name': this._name,
      'address': this._address,
      'notes': this._notes,
      'image': this._image, //TODO: Check Image property
    };
  }
}
