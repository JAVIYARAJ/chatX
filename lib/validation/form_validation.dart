import 'package:email_validator/email_validator.dart';

class FormValidation{

  static bool isEmailValid(String email){
    return EmailValidator.validate(email);
  }

  static bool isDataValid(List<String> list){
    return list.every((element) => element.isNotEmpty);
  }

  static bool isPassWordStrong(String password){
    return password.trim().length>5;
  }
}