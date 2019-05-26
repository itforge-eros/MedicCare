///
/// `doctor.dart`
/// Class contains data of doctor
///

import 'package:flutter/material.dart';
import 'package:mediccare/core/hospital.dart';

class Doctor {
  String _id;
  String _prefix;
  String _firstName;
  String _lastName;
  String _ward;
  String _hospital;
  String _hospitalId;
  String _phone;
  String _notes;
  String _image;

  Doctor({
    String id,
    String prefix,
    String firstName,
    String lastName,
    String ward,
    String hospital,
    String hospitalId,
    String phone,
    String notes,
    String image,
  }) {
    this._id = id;
    this._prefix = prefix;
    this._firstName = firstName;
    this._lastName = lastName;
    this._ward = ward;
    this._hospital = hospital;
    this._hospitalId = hospitalId;
    this._phone = phone;
    this._notes = notes;
    this._image = image;
  }

  Doctor.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._prefix = map['prefix'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._ward = map['ward'];
    this._hospital = map['hospital'];
    this._hospitalId = map['hospitalId'];
    this._phone = map['phone'];
    this._notes = map['notes'];
    this._image = map['image']; //TODO: Check Image properties
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

  String get hospitalId => this._hospitalId;
  set hospitalId(String hospitalId) => this._hospitalId = hospitalId;

  String get phone => this._phone;
  set phone(String phone) => this._phone = phone;

  String get notes => this._notes;
  set notes(String notes) => this._notes = notes;

  String get image => this._image;
  set image(String image) => this._image = image;

  get fullName => this._prefix + ' ' + this._firstName + ' ' + this._lastName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this._id,
      'prefix': this._prefix,
      'firstName': this._firstName,
      'lastName': this._lastName,
      'ward': this._ward,
      'hospital': this._hospital,
      'hospitalId': this._hospitalId,
      'phone': this._phone,
      'notes': this._notes,
      'image': this._image, //TODO: Check Image properties
    };
  }
}
