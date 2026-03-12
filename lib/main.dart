import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:retag_app/Admin_main_screen.dart';
import 'package:retag_app/DataBaseCleaner.dart';
import 'package:retag_app/Driver_main_screen.dart';
import 'package:retag_app/core/AppColors.dart';
import 'package:retag_app/core/widgets/RetagButton.dart';
import 'package:retag_app/core/widgets/RetagTextField.dart';
import 'package:retag_app/home_screen.dart';
import 'LoginLogic.dart';
import 'Sign_up_screen.dart';
import 'SignUpLogic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Appcolors.mainBackground,
        canvasColor: Appcolors.mainBackground,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }
          if (snapshot.hasData) {
            String uid = snapshot.data!.uid;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .get(),
              builder: (context, UserSnapshot) {
                if (UserSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                if (UserSnapshot.hasData && UserSnapshot.data!.exists) {
                  String role = UserSnapshot.data!.get('role');
                  if (role == 'admin') {
                    return AdminMainScreen();
                  } else if (role == 'driver') {
                    return DriverHomeScreen();
                  } else if (role == 'user') {
                    return HomeScreen();
                  }
                }
                return LoginScreen();
              },
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String role = "admin";
  final logic = LoginLogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.mainBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          //---Start PhoneNumber field---//
          Retagtextfield(
            labelText: 'Enter your phone number',
            controller: logic.phonenumberc,
            keyboardType: TextInputType.phone,
          ),
          //---End PhoneNumber field---//
          //---Start Password field---//
          Retagtextfield(
            labelText: 'Enter your password',
            controller: logic.passwordc,
            isPassword: true,
          ),
          //---End Password field---//
          SizedBox(height: 20),
          //---Start "Login" button---//
          Container(
            padding: EdgeInsets.only(right: 110, left: 110),
            child: ValueListenableBuilder(
              valueListenable: logic.isLoading,
              builder: (context, isLoading, child) {
                return RetagButton(
                  text: 'Log in',
                  isLoading: isLoading,
                  onPressed: () async {
                    String loggedin = await logic.checklogin(role);
                    if (loggedin == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminMainScreen(),
                        ),
                      );
                    } else if (loggedin == 'driver') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverHomeScreen(),
                        ),
                      );
                    } else if (loggedin == 'user') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loggedin,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),

          //---End Login button---//
          SizedBox(height: 20),
          //---Start the "dont have an account button"---//
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            child: Text(
              "Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          //---End the "dont have an account" button---//
        ],
      ),
    );
  }
}
