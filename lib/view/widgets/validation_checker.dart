class PasswordChecker {
  static bool isNotValid(String? password) {
    return !RegExp(r'(?=.*\d)').hasMatch(password!) || password.length <= 7;
  }
}

class UsernameChecker {
  static bool isNotValid(String? username) {
    return username == null ||
        !RegExp(r"^[a-zA-Z][_a-zA-Z0-9]{2,19}$").hasMatch(username);
  }
}

class EmailChecker {
  static bool isNotValid(String email) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}

String? dateOfBirthValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your date of birth';
  }

  // Regular expression to match date in dd-mm-yyyy format
  RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

  if (!regex.hasMatch(value)) {
    return 'Please enter a valid date in MM/DD/YYYY format';
  }

  List<String> parts = value.split('/');
  int month = int.tryParse(parts[0]) ?? 0;
  int day = int.tryParse(parts[1]) ?? 0;
  int year = int.tryParse(parts[2]) ?? 0;

  DateTime selectedDate = DateTime(year, month, day);
  DateTime currentDate = DateTime.now();
  DateTime minimumDate = DateTime(currentDate.year - 18, currentDate.month, currentDate.day);

  if (selectedDate.isAfter(minimumDate)) {
    return 'You must be at least 18 years old';
  }

  return null;
}
