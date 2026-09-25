class TValidator {
  /// Empty Text validation
  static String? validateEmptyText(String? fielName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fielName is required';
    }
    
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validating
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Password must be exactly 6 digits
    final passwordRegex = RegExp(r'^\d{6}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be exactly 6 digits';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Regular expression for phone number validating with specific prefixes
    final phoneRegex = RegExp(r'^(70|80|90|71|81|91)\d{8}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Phone number must start with 70, 80, 90, 71, 81, or 91 and be 10 digits long';
    }

    return null;
  }
}
