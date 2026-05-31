class EmailValidator {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static bool isValid(String value) {
    return _emailPattern.hasMatch(value.trim());
  }
}
