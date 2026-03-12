import 'package:flutter/material.dart';
import 'package:retag_app/TripDetailScreen.dart';
import 'package:retag_app/UserReservationsScreen.dart';
import 'package:retag_app/core/AppColors.dart';
import 'trip_data_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  //this is a hard coded presentation of what will be in the data base
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.userDashboardBg,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("trips").snapshots(),
          builder: (context, snapshot) {
            //Show trips when there is data,otherwise show a spinning circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Appcolors.spinningWheel,
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No trips found",
                  style: TextStyle(color: Appcolors.textLight, fontSize: 20),
                ),
              );
            }
            final LiveTrips = snapshot.data!.docs;

            return ListView.builder(
              itemCount: LiveTrips.length,
              itemBuilder: (context, index) {
                var tripDoc = LiveTrips[index];
                Trip currentTrip = Trip(
                  tripDoc['trip_name'],
                  tripDoc['trip_price'].toDouble(),
                  (tripDoc['trip_time'] as Timestamp).toDate(),
                  tripDoc['trip_pick_up'],
                  tripDoc['trip_drop_off'],
                );
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Tripdetailscreen(tripdata: currentTrip),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    color: Appcolors.cardBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      //a column (i dont know why i used it but i think it is important)
                      child: Column(
                        children: [
                          //row to hold the guys (widgets) in a horizontal way , used for holding trip name.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: "${currentTrip.trip_name}_name",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        currentTrip.trip_name,
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolors.textLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 13),
                                  //now this row is used to hold the location you get from and the location you go to.
                                  Row(
                                    children: [
                                      Hero(
                                        tag: "${currentTrip.trip_name}_pickup",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            "${currentTrip.trip_pick_up}  ",
                                            style: TextStyle(
                                              color: Appcolors.textLight,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Appcolors.textMuted,
                                      ),
                                      Hero(
                                        tag: "${currentTrip.trip_name}_dropoff",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            "  ${currentTrip.trip_drop_off}  ",
                                            style: TextStyle(
                                              color: Appcolors.textLight,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Hero(
                                        tag: "${currentTrip.trip_name}_date",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            "${currentTrip.trip_time.year}-${Month[currentTrip.trip_time.month - 1]}-${currentTrip.trip_time.day}",
                                            style: TextStyle(
                                              color: Appcolors.textLight,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        " : ",
                                        style: TextStyle(
                                          color: Appcolors.textLight,
                                        ),
                                      ),
                                      Hero(
                                        tag: "${currentTrip.trip_name}_time",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            GetFormatedHour(
                                              currentTrip.trip_time.hour,
                                            ),
                                            style: TextStyle(
                                              color: Appcolors.textLight,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "\$${currentTrip.trip_price}",
                                    style: TextStyle(
                                      color: Appcolors.textLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Userreservationsscreen()),
            );
          },
          child: Text("My reservations"),
        ),
      ),
    );
  }
}
