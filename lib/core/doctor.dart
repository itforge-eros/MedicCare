import 'package:flutter/material.dart';

class Doctor {
  String _id;
  String _prefix;
  String _firstName;
  String _lastName;
  String _ward;
  String _hospital;
  String _phone;
  String _notes;
  Image _image;

  Doctor({
    String id,
    String prefix,
    String firstName,
    String lastName,
    String ward,
    String hospital,
    String phone,
    String notes,
    Image image,
  }) {
    this._id = id;
    this._prefix = prefix;
    this._firstName = firstName;
    this._lastName = lastName;
    this._ward = ward;
    this._hospital = hospital;
    this._phone = phone;
    this._notes = notes;
    this._image = image;
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get prefix => this._prefix;
  set prefix(String prefix) => this._prefix = prefix;

  String get firstName => this._firstName;
  set firstName(String firstName) => this._firstName = firstName;

  String get lastName => this._lastName;
  set lastName(String lastName) => this._lastName = lastName;

  String get ward => this._ward;
  set ward(String ward) => this._ward = ward;

  String get hospital => this._hospital;
  set hospital(String hospital) => this._hospital = hospital;

  String get phone => this._phone;
  set phone(String phone) => this._phone = phone;

  String get notes => this._notes;
  set notes(String notes) => this._notes = notes;

  Image get image => this._image;
  set image(Image image) => this._image = image;
}
