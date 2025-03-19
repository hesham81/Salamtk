import '/core/validations/validations.dart';

abstract class PhoneValidation extends Validations {
  static check({
    required String phoneNumber,
  }) {
    RegExp phoneRegex = RegExp(r'^01[0-9]{9}$');
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }
}
