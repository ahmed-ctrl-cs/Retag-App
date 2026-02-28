import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:retag_app/Admin_main_screen.dart';
import 'package:retag_app/Driver_main_screen.dart';
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
  LoginApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(126, 148, 192, 1),
        canvasColor: Color.fromRGBO(126, 148, 192, 1),
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
            return HomeScreen();
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
      backgroundColor: Color.fromRGBO(126, 148, 192, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //---Start PhoneNumber field---//
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 13,
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: logic.phonenumberc,
              ),
            ),
          ),
          //---End PhoneNumber field---//
          //---Start Password field---//
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 13,
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: logic.passwordc,
              ),
            ),
          ),
          //---End Password field---//
          //---Start "Login" button---//
          Container(
            padding: EdgeInsets.only(right: 110, left: 110),
            color: Color.fromRGBO(126, 148, 192, 1),
            child: ValueListenableBuilder(
              valueListenable: logic.isLoading,
              builder: (context, isLoading, child) {
                return CupertinoButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          String login = await logic.checklogin(role);
                          if (login == "admin") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminMainScreen(),
                              ),
                            );
                          } else if (login == "driver") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriverHomeScreen(),
                              ),
                            );
                          } else if (login == "user") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(login),
                                backgroundColor: Color.fromRGBO(
                                  126,
                                  148,
                                  192,
                                  0,
                                ),
                              ),
                            );
                          }
                        },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 20,
                        ),
                      ],
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                    child: Center(
                      child: isLoading
                          ? CupertinoActivityIndicator(color: Colors.white)
                          : Text("Login"),
                    ),
                  ),
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
