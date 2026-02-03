import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:retag_app/home_screen.dart';
import 'LoginLogic.dart';
// import 'home_screen.dart';

void main() {
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
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final logic = LoginLogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(126, 148, 192, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Container(
            padding: EdgeInsets.only(right: 110, left: 110),
            color: Color.fromRGBO(126, 148, 192, 1),
            child: CupertinoButton(
              onPressed: () {
                bool login = logic.checklogin();
                if (login) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Fill all fields"),
                      backgroundColor: Color.fromRGBO(126, 148, 192, 0),
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
                child: Center(child: Text("Login")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
