///
/// exceptions.dart
/// Contains Exception classes of MedicCare application
///

///
/// Exceptions for `util` package
///

class InvalidEmailAddressException extends Exception {
  factory InvalidEmailAddressException() {
    return InvalidEmailAddressException();
  }
}

///
/// Exceptions for `core` package
///

class InvalidMedicineDayException extends Exception {
  factory InvalidMedicineDayException() {
    return InvalidMedicineDayException();
  }
}

class InvalidMedicineTimeException extends Exception {
  factory InvalidMedicineTimeException() {
    return InvalidMedicineTimeException();
  }
}

class NoMedicineDayException extends Exception {
  factory NoMedicineDayException() {
    return NoMedicineDayException();
  }
}

class NoMedicineTimeException extends Exception {
  factory NoMedicineTimeException() {
    return NoMedicineTimeException();
  }
}

class OutOfMedicineException extends Exception {
  factory OutOfMedicineException() {
    return OutOfMedicineException();
  }
}
