import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 62, 80, 1),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            BuildAdminCard(
              title: "Manage trips",
              subtitle: "Create, edit or delete trips",
              icon: Icons.edit_road,
              onTap: () {
                print("manage");
              },
            ),
            BuildAdminCard(
              title: "Assign trips",
              subtitle: "Assign trips to drivers",
              icon: Icons.assessment_outlined,
              onTap: () {
                print("assign");
              },
            ),
            BuildAdminCard(
              title: 'Driver Status',
              subtitle: 'See what the drivers are doing now',
              icon: Icons.drive_eta_rounded,
              onTap: () {
                print("car");
              },
            ),
            BuildAdminCard(
              title: 'Revenue',
              subtitle:
                  'See how much money your company made in the last month',
              icon: Icons.attach_money,
              onTap: () {
                print('money');
              },
            ),
            BuildAdminCard(
              title: 'Manage users',
              subtitle:
                  'See user info, upgrade users, downgrade users, block th...',
              icon: Icons.verified_user,
              onTap: () {
                print('userm');
              },
            ),
            BuildAdminCard(
              title: 'Trips price',
              subtitle: 'Set prices for the trips for every pickup location',
              icon: Icons.money,
              onTap: () {
                print('price');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget BuildAdminCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
