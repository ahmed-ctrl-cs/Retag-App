import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A "Serious" Dark Blue/Grey for the Admin
      backgroundColor: Color.fromRGBO(44, 62, 80, 1),
      appBar: AppBar(
        title: Text("Admin Control Panel"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "System Admin",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Placeholder for adding trips later
              },
              child: Text("Manage Trips"),
            ),
          ],
        ),
      ),
    );
  }
}
