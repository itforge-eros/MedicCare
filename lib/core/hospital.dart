///
/// `hospital.dart`
/// Class contains data of hospital
///

import 'package:flutter/material.dart';

class Hospital {
  String _id;
  String _name;
  String _placeId;
  String _address;
  String _notes;
  Image _image;

  Hospital({
    String id,
    String name,
    String placeId,
    String address,
    String notes,
    Image image,
  }) {
    this._id = id;
    this._name = name;
    this._address = address;
    this._notes = notes;
    this._image = image;
    this._placeId = placeId;
  }

  Hospital.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._placeId = map['placeId'];
    this._address = map['address'];
    this._notes = map['notes'];
    this._image = map['image']; //TODO: Check Image properties
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get placeId => this._placeId;
  set placeId(String placeId) => this._placeId = placeId;

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
      'image': this._image, //TODO: Check Image properties
    };
  }
}
