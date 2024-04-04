class ValidatorCheck {
  static String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,3}(\.\w{2,3})?$');

    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please Enter valid email';
    }
    return null;
  }

  static String? isPasswordValid(String? password) {
    // Check if password length is at least 8 characters
    if (password!.length < 8) {
      return 'Password length should be 8 or more';
    }

    // Check if the first character is uppercase
    if (!password[0].toUpperCase().contains(RegExp(r'[A-Z]'))) {
      return 'First latter should be Capital';
    }

    // Check if the password contains only alphanumeric characters
    if (!password.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      return 'Only Alphanumaric';
    }

    return null;
  }
}
