import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:retag_app/core/AppColors.dart';
import 'package:retag_app/core/widgets/RetagButton.dart';
import 'SignUpLogic.dart';
import 'home_screen.dart';
import 'core/widgets/RetagTextField.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final logic = Signuplogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.mainBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create account",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Retagtextfield(
                labelText: 'Enter your name',
                controller: logic.namec,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              Retagtextfield(
                labelText: 'Enter your phone number',
                controller: logic.phonenumberc,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              Retagtextfield(
                labelText: 'Enter your password',
                controller: logic.passwordc,
                isPassword: true,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 110),
                child: ValueListenableBuilder(
                  valueListenable: logic.isLoading,
                  builder: (context, isLoading, child) {
                    return RetagButton(
                      text: 'Sign up',
                      isLoading: isLoading,
                      onPressed: () async {
                        String result = await logic.CheckSignUp();
                        if (result == 'Success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
