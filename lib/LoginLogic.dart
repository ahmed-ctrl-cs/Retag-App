import 'package:flutter/material.dart';

class LoginLogic {
  final phonenumberc = TextEditingController();
  final passwordc = TextEditingController();
  bool checklogin() {
    if (phonenumberc.text.isEmpty || passwordc.text.isEmpty)
      return false;
    else
      return true;
  }
}
