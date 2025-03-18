abstract class Validations {
  static String? isEmailValid(String email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      return "Please enter your email";
    } else if (!emailRegex.hasMatch(email)) {
      return "Please Enter valid Email";
    }
    return null;
  }

  static String? isPasswordValid(String password) {
    if (password.isEmpty) {
      return "Please enter your password";
    } else if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? isNameValid(String name) {
    if (name.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  static String? rePasswordValid(String password, String rePassword) {
    if (password != rePassword) {
      return "Password does not match";
    }
    return null;
  }
}
