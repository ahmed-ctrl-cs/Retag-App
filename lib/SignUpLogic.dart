import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signuplogic {
  final namec = TextEditingController();
  final phonenumberc = TextEditingController();
  final passwordc = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);

  Future<String> CheckSignUp() async {
    try {
      isLoading.value = true;
      String name = namec.text.trim();
      String phonenumber = phonenumberc.text.trim();
      String password = passwordc.text.trim();

      if (name.isEmpty || password.isEmpty || phonenumber.isEmpty) {
        isLoading.value = false;
        return "Fill all fields";
      }
      String FakeEmail = phonenumber + "@retag.app";
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: FakeEmail, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'name': name, 'phonenumber': phonenumber, 'role': 'user'});
      isLoading.value = false;
      return "Success";
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      return e.message ?? "An error occured";
    } catch (e) {
      isLoading.value = false;
      return "There was an error: $e";
    }
  }
}
