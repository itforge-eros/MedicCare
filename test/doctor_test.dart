// Test for Doctor class

import 'package:mediccare/core/doctor.dart';

import 'package:test/test.dart';

void main() {
  Doctor doctor;
  test('Create Doctor', () {
    doctor = Doctor(
      id: '1',
      prefix: 'นายแพทย์',
      firstName: 'สมชาย',
      lastName: 'คนดี',
      hospital: 'ทวีวัฒนา',
      phone: '0888888888',
      ward: 'อายุรกรรม',
    );
  });

  test('Get Doctor ID', () {
    expect(doctor.id, '1');
  });

  test('Get Doctor Prefix', () {
    expect(doctor.prefix, 'นายแพทย์');
  });

  test('Get Doctor Firstname', () {
    expect(doctor.firstName, 'สมชาย');
  });

  test('Get Doctor Lastname', () {
    expect(doctor.lastName, 'คนดี');
  });

  test('Get Doctor Hospital', () {
    expect(doctor.hospital, 'ทวีวัฒนา');
  });

  test('Get Doctor Phone', () {
    expect(doctor.phone, '0888888888');
  });
}
