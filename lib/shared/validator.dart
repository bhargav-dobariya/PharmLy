import 'package:email_validator/email_validator.dart';
import 'package:pharmly/resources/app_string.dart';

class Validator {
  static String? email(String? value) {
    return value != null && !EmailValidator.validate(value)
        ? AppString.txtEnterValidEmailId
        : null;
  }

  static String? password(String? value) {
    if (value != null && value.length < 8) {
      return AppString.txtEntermin8char;
    } else {
      return null;
    }
  }

  static String? phoneNumber(String? value) {
    if (value!.isEmpty || !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return AppString.txtEnterValidMobileNumber;
    } else {
      return null;
    }
  }

  static String? lastName(String? value) {
    if (value!.isEmpty) {
      return AppString.txtEnterValidLastname;
    } else {
      return null;
    }
  }

  static String? firstName(String? value) {
    if (value!.isEmpty) {
      return AppString.txtEnteraValidFirstnamne;
    } else {
      return null;
    }
  }
}
