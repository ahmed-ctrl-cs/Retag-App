import 'package:flutter/material.dart';

class LoginLogic {
  final phonenumberc = TextEditingController();
  final passwordc = TextEditingController();
  String checklogin(String role) {
    if (phonenumberc.text.isEmpty || passwordc.text.isEmpty)
      return "false";
    else if (role == "admin")
      return "admin";
    else if (role == "driver")
      return "driver";
    else if (role == "user")
      return "user";
    else
      return "false";
  }
}
