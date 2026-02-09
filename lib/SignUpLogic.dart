import 'package:flutter/material.dart';

class Signuplogic {
  final namec = TextEditingController();
  final phonenumberc = TextEditingController();
  final passwordc = TextEditingController();

  bool checksignup() {
    if (namec.text.isEmpty ||
        phonenumberc.text.isEmpty ||
        passwordc.text.isEmpty)
      return false;
    else
      return true;
  }
}
