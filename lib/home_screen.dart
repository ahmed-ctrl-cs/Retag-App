import 'package:flutter/material.dart';
import 'package:retag_app/TripDetailScreen.dart';
import 'package:retag_app/UserReservationsScreen.dart';
import 'trip_data_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  //this is a hard coded presentation of what will be in the data base
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(106, 128, 172, 1),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("trips").snapshots(),
          builder: (context, snapshot) {
            //Show trips when there is data,otherwise show a spinning circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(2, 174, 39, 1),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No trips found",
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                    color: Color.fromRGBO(87, 143, 255, 0.498),
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
                                        "${currentTrip.trip_name}",
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                            152,
                                            206,
                                            213,
                                            1,
                                          ),
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
                                          color: Color.fromRGBO(0, 0, 0, 0),
                                          child: Text(
                                            "${currentTrip.trip_pick_up}  ",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                230,
                                                172,
                                                155,
                                                1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Color.fromRGBO(200, 210, 135, 1),
                                      ),
                                      Hero(
                                        tag: "${currentTrip.trip_name}_dropoff",
                                        child: Material(
                                          color: Color.fromRGBO(0, 0, 0, 0),
                                          child: Text(
                                            "  ${currentTrip.trip_drop_off}  ",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                155,
                                                242,
                                                145,
                                                1,
                                              ),
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
                                          color: Color.fromRGBO(
                                            152,
                                            213,
                                            177,
                                            0,
                                          ),
                                          child: Text(
                                            "${currentTrip.trip_time.year}-${Month[currentTrip.trip_time.month - 1]}-${currentTrip.trip_time.day}",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                152,
                                                213,
                                                177,
                                                1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        " : ",
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            152,
                                            213,
                                            177,
                                            1,
                                          ),
                                        ),
                                      ),
                                      Hero(
                                        tag: "${currentTrip.trip_name}_time",
                                        child: Material(
                                          color: Color.fromRGBO(
                                            152,
                                            213,
                                            177,
                                            0,
                                          ),
                                          child: Text(
                                            "${GetFormatedHour(currentTrip.trip_time.hour)}",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                152,
                                                213,
                                                177,
                                                1,
                                              ),
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
                                      color: Color.fromRGBO(152, 166, 213, 1),
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
        decoration: BoxDecoration(color: Color.fromRGBO(126, 148, 192, 0)),
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
