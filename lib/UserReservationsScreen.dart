import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retag_app/core/AppColors.dart';
import 'package:retag_app/trip_data_holder.dart';

class Userreservationsscreen extends StatelessWidget {
  const Userreservationsscreen({super.key});
  @override
  Widget build(BuildContext context) {
    //---Getting user id---//
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Appcolors.userDashboardBg,
      appBar: AppBar(
        backgroundColor: Appcolors.userDashboardBg,
        title: Text("My Reservations", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reservations')
              .where('pass_uid', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No reservations found",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            }
            final MyReservations = snapshot.data!.docs;
            return ListView.builder(
              itemCount: MyReservations.length,
              itemBuilder: (context, index) {
                var reservations = MyReservations[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Appcolors.cardBlue,
                  child: ListTile(
                    title: Text(
                      reservations['trip_name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "From: ${Pickup[reservations['pickup_location']]} \nTo: ${Dropoff[reservations['dropoff_location']]}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      "\$${reservations['total_price']}",
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: Colors.transparent),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () async {
            Navigator.pop(context);
            await FirebaseAuth.instance.signOut();
          },
          child: Text(
            "Log Out",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
