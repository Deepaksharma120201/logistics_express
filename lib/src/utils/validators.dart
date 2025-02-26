class Validators {
  // Validator for name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  // Validator for phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^\+?[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Validator for email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    }
    final validEmailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+com$');
    if (!validEmailPattern.hasMatch(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  // Validator for password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Validator for confirm password
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validator for Aadhar Card (12-digit number format)
  static String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^\d{4}-\d{4}-\d{4}$').hasMatch(value)) {
      return 'Enter a valid Aadhar number (XXXX-XXXX-XXXX)';
    }
    return null;
  }

  // Validator for Vehicle RC (e.g., AB12CD1234 format)
  static String? validateVehicleRc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{4}$')
        .hasMatch(value)) {
      return 'Enter a valid Vehicle RC (e.g., AB12CD1234)';
    }
    return null;
  }

  // Validator for Driving Licence (e.g., DL-12-1234567)
  static String? validateDrivingLicence(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^[A-Z]{2}-\d{2}-\d{6,7}$').hasMatch(value)) {
      return 'Enter a valid Driving Licence (e.g., DL-12-1234567)';
    }
    return null;
  }

  // Validator for Date
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$')
        .hasMatch(value)) {
      return 'Enter a valid date (DD/MM/YYYY)';
    }
    return null;
  }

  // Validator for Qunatity
  static String? quantityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field!';
    } else if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
      return 'Enter a valid number';
    }
    return null;
  }

  // Validator for Dropdwon
  static String? commonValidator(String? value) {
    if (value == null || value.isEmpty || value == '0') {
      return 'Please fill this field!';
    }
    return null;
  }
}
