import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginLogic {
  final phonenumberc = TextEditingController();
  final passwordc = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);
  Future<String> checklogin(String role) async {
    try {
      isLoading.value = true;
      String email = phonenumberc.text.trim() + "@retag.app";
      String password = passwordc.text.trim();
      if (phonenumberc.text.isEmpty || passwordc.text.isEmpty) {
        isLoading.value = false;
        return "Fill all the fields";
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
      return role;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      return e.message ?? "An error occured";
    } catch (e) {
      isLoading.value = false;
      return "An error occured: $e";
    }
  }
}
