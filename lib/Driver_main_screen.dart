import 'package:flutter/material.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A "Work Mode" Green color to distinguish it from the User screen
      backgroundColor: Color.fromRGBO(59, 179, 115, 1),
      appBar: AppBar(
        title: Text("Driver Dashboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.drive_eta, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Welcome, Captain!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "No trips assigned yet.",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
