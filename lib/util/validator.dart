///r'^
///   (?=.*[A-Z])       // should contain at least one upper case
///   (?=.*[a-z])       // should contain at least one lower case
///   (?=.*?[0-9])      // should contain at least one digit
///   (?=.*?[!@#\$&*~]) // should contain at least one Special character
///   .{8,}             // Must be at least 8 characters in length
/// $
///
///
///

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(this);
  }

  bool isContainUpperCase() {
    return RegExp(r'^(?=.*?[A-Z])$').hasMatch(this);
  }

  bool isContainLowerCase() {
    return RegExp(r'^(?=.*?[a-z])$').hasMatch(this);
  }

  bool isContainDigit() {
    return RegExp(r'^(?=.*?[0-9])$').hasMatch(this);
  }

  bool isContainSpecialChar() {
    return RegExp(r'^(?=.*?[!@#\$&*~])$').hasMatch(this);
  }

  bool isMinSixChar() {
    return RegExp(r'^.{6,}$').hasMatch(this);
  }
}

class Validator {
  static String? onEmailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter text";
    }
    if (!value.isValidEmail()) {
      return "Please enter valid e-mail";
    }
    return null;
  }

  static String? onNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter text";
    }
    if (value.isContainDigit()) {
      return "Please enter valid e-mail";
    }
    return null;
  }

  static String? onNotEmptyValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter text";
    }
    return null;
  }

  static String? onPasswordValidation(String? value, {String? repeatedValue}) {
    if (value == null || value.isEmpty) {
      return "Please enter text";
    }
    if (repeatedValue == null && !value.isMinSixChar()) {
      return "Password must contain minimum six characters";
    }
    if (repeatedValue != null && repeatedValue != value) {
      return "The password confirmation does not match";
    }
    return null;
  }

  static String? onPositiveNumValidation(String? value) {
    if ((double.tryParse(value!) ?? 0) <= 0) {
      return "The value you entered is invalid. Please enter a valid numeric value that is not equal to 0.";
    }
    return null;
  }
}
