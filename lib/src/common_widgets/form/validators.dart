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
      return 'Please enter a valid email ending with .com';
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
}
