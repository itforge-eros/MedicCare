///
/// `exceptions.dart`
/// Contains Exception classes of MedicCare application
///

///
/// Package: `util`
///

class EmptyFieldException extends Exception {
  /// Class: `Validator` 
  /// Event: At least one of text form fields is empty.
  factory EmptyFieldException() {
    return EmptyFieldException();
  }
}

class InvalidEmailAddressException extends Exception {
  /// Class: `Validator`
  /// Event: Invalid email address.
  factory InvalidEmailAddressException() {
    return InvalidEmailAddressException();
  }
}

class InvalidPasswordValidationLevelException extends Exception {
  /// Class: `Validator`
  /// Event: Invalid password validation level.
  factory InvalidPasswordValidationLevelException() {
    return InvalidPasswordValidationLevelException();
  }
}

class MismatchPasswordFieldsException extends Exception {
  /// Class: `Validator`
  /// Event: Registration password fields mismatch.
  factory MismatchPasswordFieldsException() {
    return MismatchPasswordFieldsException();
  }
}

class PasswordFormatException extends Exception {
  /// Class: `Validator`
  /// Event: Registration password format is invalid.
  factory PasswordFormatException() {
    return PasswordFormatException();
  }
}

class PasswordLengthException extends Exception {
  /// Class: `Validator`
  /// Event: Registration password length is too short.
  factory PasswordLengthException() {
    return PasswordLengthException();
  }
}

///
/// Exceptions for `core` package
///

class IncompleteDataException extends Exception {
  /// Class: `MedicineOverviewItem`
  /// Event: At least one argument to create an object is determined null in which should not be.
  factory IncompleteDataException() {
    return IncompleteDataException();
  }
}

class InvalidBloodGroupException extends Exception {
  /// Class: `User`
  /// Event: User's blood group is set to other than 'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+' or 'AB-'
  factory InvalidBloodGroupException() {
    return InvalidBloodGroupException();
  }
}

class InvalidGenderException extends Exception {
  /// Class: `User`
  /// Event: User's gender is set to other than 'Male', 'Female' or 'Others'
  factory InvalidGenderException() {
    return InvalidGenderException();
  }
}

class InvalidMedicineDayException extends Exception {
  /// Class: `MedicineSchedule`
  /// Event: Medicine day data is determined not to be a list of 7 booleans.
  factory InvalidMedicineDayException() {
    return InvalidMedicineDayException();
  }
}

class InvalidMedicineTimeException extends Exception {
  /// Class: `MedicineSchedule`
  /// Event: Medicine time data is determined not to be a list of 4 booleans.
  factory InvalidMedicineTimeException() {
    return InvalidMedicineTimeException();
  }
}

class NoMedicineDayException extends Exception {
  /// Class: `MedicineSchedule`
  /// Event: Medicine day data is determined to be all false, which there must be at least one true.
  factory NoMedicineDayException() {
    return NoMedicineDayException();
  }
}

class NoMedicineTimeException extends Exception {
  /// Class: `MedicineSchedule`
  /// Event: Medicine time data is determined to be all false, which there must be at least one true.
  factory NoMedicineTimeException() {
    return NoMedicineTimeException();
  }
}

class OutOfMedicineException extends Exception {
  /// Class: `Medicine`
  /// Event: Attempt to take the medicine which has already ran out.
  factory OutOfMedicineException() {
    return OutOfMedicineException();
  }
}
