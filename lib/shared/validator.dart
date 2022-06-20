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
      return "Enter min. 8 characters";
    } else {
      return null;
    }
  }

  static String? phoneNumber(String? value) {
    if (value!.isEmpty || !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return "Enter valid mobile number";
    } else {
      return null;
    }
  }

  static String? lastName(String? value) {
    if (value == null) {
      return "Enter a valid firstname";
    } else {
      return null;
    }
  }

  static String? firstName(String? value) {
    if (value == null) {
      return "Enter a valid firstname";
    } else {
      return null;
    }
  }
}
