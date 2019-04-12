///
/// `components.dart`
/// Contains core components
///
/// `Table of index`
/// [1] Appointment
/// [2] Doctor
/// [3] Hospital
/// [4] MedicineOverviewData
/// [5] MedicineSchedule
/// [6] Medicine
/// [7] UserSettings
/// [8] User
///
/// Written by Teerapat Kraisrisirikul
///

import 'package:flutter/material.dart';
import 'package:mediccare/exceptions.dart';

class Appointment {
  String _id;
  String _title;
  String _description;
  Doctor _doctor;
  Hospital _hospital;
  DateTime _dateTime;

  Appointment({
    String id,
    String title,
    String description,
    Doctor doctor,
    Hospital hospital,
    DateTime dateTime,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._doctor = doctor;
    this._hospital = hospital;
    this._dateTime = dateTime;
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get title => this._title;
  set title(String title) => this._title = title;

  String get description => this._description;
  set description(String description) => this._description = description;

  Doctor get doctor => this._doctor;
  set doctor(Doctor doctor) => this._doctor = doctor;

  Hospital get hospital => this._hospital;
  set hospital(Hospital hospital) => this._hospital = hospital;

  DateTime get dateTime => this._dateTime;
  set dateTime(DateTime dateTime) => this._dateTime = dateTime;
}

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
}

class MedicineOverviewData {
  Medicine _medicine;
  DateTime _dateTime;
  bool _isDone;

  MedicineOverviewData({
    Medicine medicine,
    DateTime dateTime,
  }) {
    if (medicine == null || dateTime == null) {
      throw IncompleteDataException();
    }
    this._medicine = medicine;
    this._dateTime = dateTime;
    this._isDone = false;
  }

  Medicine get medicine => this._medicine;

  DateTime get dateTime => this._dateTime;

  bool get isDone => this._isDone;
  set isDone(bool isDone) => this._isDone = isDone;

  bool isDisplayable() {
    return !this._isDone || this._dateTime.compareTo(DateTime.now().add(Duration(days: 1))) < 0;
  }

  String toString() {
    return this._medicine.name + ' ' + this._dateTime.toString();
  }
}

class MedicineSchedule {
  List<bool> _time = [
    null, // breakfast
    null, // lunch
    null, // dinner
    null, // sleep
  ];
  List<bool> _day = [
    null, // monday
    null, // tuesday
    null, // wednesday
    null, // thursday
    null, // friday
    null, // saturday
    null, // sunday
  ];
  bool _isBeforeMeal;

  MedicineSchedule({
    List<bool> time,
    List<bool> day,
    bool isBeforeMeal = false,
  }) {
    if (time != null) {
      _checkTimeException(time);
    }
    if (day != null) {
      _checkDayException(day);
    }

    this._time = time ?? [true, true, true, false];
    this._day = day ?? [true, true, true, true, true, true, true];
    this._isBeforeMeal = isBeforeMeal;
  }

  List<bool> get time => this._time;
  set time(List<bool> time) {
    _checkTimeException(time);
    this._time = time;
  }

  List<bool> get day => this._day;
  set day(List<bool> day) {
    _checkDayException(day);
    this._day = day;
  }

  bool get isBeforeMeal => this._isBeforeMeal;
  set isBeforeMeal(bool isBeforeMeal) => this._isBeforeMeal = isBeforeMeal;

  void _checkTimeException(List<bool> time) {
    if (time.length != 4) {
      throw InvalidMedicineTimeException();
    } else if (!time.contains(true)) {
      throw NoMedicineTimeException();
    }
  }

  void _checkDayException(List<bool> day) {
    if (day.length != 7) {
      throw InvalidMedicineDayException();
    } else if (!day.contains(true)) {
      throw NoMedicineDayException();
    }
  }
}

class Medicine {
  String _id;
  String _name;
  String _description;
  String _type;
  Image _image;
  int _doseAmount;
  int _totalAmount;
  int _remainingAmount;
  int _skippedTimes;
  MedicineSchedule _medicineSchedule;
  final DateTime _dateAdded = DateTime.now();

  Medicine({
    String id,
    String name,
    String description,
    String type,
    Image image,
    int doseAmount = 1,
    int totalAmount = 10,
    MedicineSchedule medicineSchedule,
  }) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._type = type;
    this._image = image;
    this._doseAmount = doseAmount;
    this._totalAmount = totalAmount;
    this._remainingAmount = totalAmount;
    this._skippedTimes = 0;
    this._medicineSchedule = medicineSchedule;
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get name => this._name;
  set name(String name) => this._name = name;

  String get description => this._description;
  set description(String description) => this._description = description;

  String get type => this._type;
  set type(String type) => this._type = type;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  int get doseAmount => this._doseAmount;
  set doseAmount(int doseAmount) => this._doseAmount = doseAmount;

  int get totalAmount => this._totalAmount;
  set totalAmount(int totalAmount) => this._totalAmount = totalAmount;

  int get remainingAmount => this._remainingAmount;

  int get skippedTimes => this._skippedTimes;

  MedicineSchedule get medicineSchedule => this._medicineSchedule;
  set medicineSchedule(MedicineSchedule medicineSchedule) =>
      this._medicineSchedule = medicineSchedule;

  DateTime get dateAdded => this._dateAdded;

  void takeMedicine() {
    if (this._remainingAmount == 0) {
      throw OutOfMedicineException();
    } else if (this._remainingAmount - this._doseAmount < 0) {
      this._remainingAmount = 0;
    } else {
      this._remainingAmount -= this._doseAmount;
    }
  }

  void skipMedicine() {
    this._skippedTimes++;
  }
}

class UserSettings {
  static final List<Duration> defaultTime = [
    Duration(
      hours: 7,
      minutes: 0,
    ),
    Duration(
      hours: 12,
      minutes: 0,
    ),
    Duration(
      hours: 18,
      minutes: 0,
    ),
    Duration(
      hours: 22,
      minutes: 0,
    ),
  ];

  final List<Duration> _userTime = [
    null, // breakfast
    null, // lunch
    null, // dinner
    null, // sleep
  ];

  UserSettings({
    Duration breakfastTime,
    Duration lunchTime,
    Duration dinnerTime,
    Duration sleepTime,
  }) {
    this._userTime[0] = breakfastTime ?? UserSettings.defaultTime[0];
    this._userTime[1] = lunchTime ?? UserSettings.defaultTime[1];
    this._userTime[2] = dinnerTime ?? UserSettings.defaultTime[2];
    this._userTime[3] = sleepTime ?? UserSettings.defaultTime[3];
  }

  List<Duration> get userTime => this._userTime;

  Duration get breakfastTime => this._userTime[0];
  set breakfastTime(Duration breakfastTime) => this._userTime[0] = breakfastTime;

  Duration get lunchTime => this._userTime[1];
  set lunchTime(Duration lunchTime) => this._userTime[1] = lunchTime;

  Duration get dinnerTime => this._userTime[2];
  set dinnerTime(Duration dinnerTime) => this._userTime[2] = dinnerTime;

  Duration get sleepTime => this._userTime[3];
  set sleepTime(Duration sleepTime) => this._userTime[3] = sleepTime;

  void resetDefault() {
    this._userTime[0] = UserSettings.defaultTime[0];
    this._userTime[1] = UserSettings.defaultTime[1];
    this._userTime[2] = UserSettings.defaultTime[2];
    this._userTime[3] = UserSettings.defaultTime[3];
  }
}

class User {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  DateTime _birthDate;
  double _height;
  double _weight;
  Image _image;
  List<Medicine> _medicineList;
  List<Appointment> _appointmentList;
  List<Doctor> _doctorList;
  List<Hospital> _hospitalList;
  UserSettings _userSettings;

  User({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime birthDate,
    String gender,
    double height,
    double weight,
    Image image,
    List<Medicine> medicineList,
    List<Appointment> appointmentList,
    List<Doctor> doctorList,
    List<Hospital> hospitalList,
    UserSettings userSettings,
  }) {
    this._id = id;
    this._email = email;
    this._firstName = firstName;
    this._lastName = lastName;
    this._birthDate = birthDate;
    this._gender = gender;
    this._height = height;
    this._weight = weight;
    this._image = image;
    this._medicineList = medicineList ?? List<Medicine>();
    this._appointmentList = appointmentList ?? List<Appointment>();
    this._doctorList = doctorList ?? List<Doctor>();
    this._hospitalList = hospitalList ?? List<Hospital>();
    this._userSettings = userSettings ?? UserSettings();
  }

  String get id => this._id;
  set id(String id) => this._id = id;

  String get email => this._email;
  set email(String email) => this._email = email;

  String get firstName => this._firstName;
  set firstName(String firstName) => this._firstName = firstName;

  String get lastName => this._lastName;
  set lastName(String lastName) => this._lastName = lastName;

  String get gender => this._gender;
  set gender(String gender) => this._gender = gender;

  DateTime get birthDate => this._birthDate;
  set birthDate(DateTime birthDate) => this._birthDate = birthDate;

  double get height => this._height;
  set height(double height) => this._height = height;

  double get weight => this._weight;
  set weight(double weight) => this._weight = weight;

  Image get image => this._image;
  set image(Image image) => this._image = image;

  List<Medicine> get medicineList => this._medicineList;
  set medicineList(List<Medicine> medicineList) => this._medicineList = medicineList;

  List<Appointment> get appointmentList => this._appointmentList;
  set appointmentList(List<Appointment> appointmentList) => this._appointmentList = appointmentList;

  List<Doctor> get doctorList => this._doctorList;
  set doctorList(List<Doctor> doctorList) => this._doctorList = doctorList;

  List<Hospital> get hospitalList => this._hospitalList;
  set hospitalList(List<Hospital> hospitalList) => this._hospitalList = hospitalList;

  void addMedicine(Medicine medicine) {
    this._medicineList.add(medicine);
  }

  bool removeMedicine(String id) {
    for (int i = 0; i < this._medicineList.length; i++) {
      if (id == this._medicineList[i].id) {
        this._medicineList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addAppointment(Appointment appointment) {
    this._appointmentList.add(appointment);
  }

  bool removeAppointment(String id) {
    for (int i = 0; i < this._appointmentList.length; i++) {
      if (id == this._appointmentList[i].id) {
        this._appointmentList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addDoctor(Doctor doctor) {
    this._doctorList.add(doctor);
  }

  bool removeDoctor(String id) {
    for (int i = 0; i < this._doctorList.length; i++) {
      if (id == this._doctorList[i].id) {
        this._doctorList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  void addHospital(Hospital hospital) {
    this._hospitalList.add(hospital);
  }

  bool removeHospital(String id) {
    for (int i = 0; i < this._hospitalList.length; i++) {
      if (id == this._hospitalList[i].id) {
        this._hospitalList.removeAt(i);
        return true;
      }
    }
    return false;
  }

  // Method: Get all medicine overview item list
  List<MedicineOverviewData> getMedicineOverview() {
    final List<MedicineOverviewData> medicineOverviewDataList = List<MedicineOverviewData>();
    List<DateTime> temp = List<DateTime>();

    for (int i = 0; i < this._medicineList.length; i++) {
      temp = this._getMedicineSchedule(this._medicineList[i]);
      for (int j = 0; j < temp.length; j++) {
        medicineOverviewDataList.add(MedicineOverviewData(
          medicine: this._medicineList[i],
          dateTime: temp[j],
        ));
      }
    }

    medicineOverviewDataList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return medicineOverviewDataList;
  }

  // Private method: Get medicine schedule of a single medicine
  List<DateTime> _getMedicineSchedule(Medicine medicine) {
    DateTime firstDay;
    Duration firstTime;
    final List<Duration> oneDayTime = List<Duration>();
    final List<Duration> durations = List<Duration>();
    final List<DateTime> medicineSchedule = List<DateTime>();
    int offset = 0;

    // Logic: Calculate `firstDay`
    firstDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    while (!medicine.medicineSchedule.day[firstDay.weekday - 1]) {
      firstDay = firstDay.add(Duration(days: 1));
    }

    // Logic: Calculate `firstTime`
    for (int i = 0; i < 4; i++) {
      if (DateTime.now().day != firstDay.day) {
        firstTime = this._userSettings.userTime[medicine.medicineSchedule.time.indexOf(true)];
        offset = 0;
        break;
      }

      if (!medicine.medicineSchedule.time[i]) {
        offset--;
      } else if (Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
          ) <
          this._userSettings.userTime[i]) {
        firstTime = this._userSettings.userTime[i];
        offset += i;
        break;
      }
    }

    // Logic: Calculate `oneDayTime`
    for (int i = 0; i < 4; i++) {
      if (medicine.medicineSchedule.time[i]) {
        oneDayTime.add(this._userSettings.userTime[i]);
      }
    }

    // Logic: Calculate `durations`
    for (int i = 0; i < oneDayTime.length - 1; i++) {
      durations.add(oneDayTime[i + 1] - oneDayTime[i]);
    }
    durations.add(Duration(days: 1) - oneDayTime[oneDayTime.length - 1] + oneDayTime[0]);

    // Logic: Calculate `medicineSchedule`
    firstDay = firstDay.add(firstTime);
    for (int i = 0;
        i < (medicine.totalAmount / medicine.doseAmount).ceil() + medicine.skippedTimes;
        i++) {
      medicineSchedule.add(firstDay);
      firstDay = firstDay.add(durations[(i + offset) % durations.length]);

      while (!medicine.medicineSchedule.day[firstDay.weekday - 1]) {
        firstDay = firstDay.add(Duration(days: 1));
      }
    }

    return medicineSchedule;
  }
}
