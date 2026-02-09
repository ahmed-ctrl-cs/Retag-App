import 'package:flutter/material.dart';
import 'package:retag_app/TripDetailScreen.dart';
import 'trip_data_holder.dart';

class HomeScreen extends StatelessWidget {
  //this is a hard coded presentation of what will be in the data base
  final List<Trip> trips = [
    Trip("nmu", 60, DateTime.now(), "location a", "location b"),
    Trip("mni", 60, DateTime.now(), "location b", "location d"),
    Trip("delta", 60, DateTime.now(), "location e", "location f"),
    Trip("horas", 60, DateTime.now(), "location g", "location h"),
  ];
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(106, 128, 172, 1),
      body: SafeArea(
        child: ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Tripdetailscreen(tripdata: trips[index]),
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
                  //a column (i dont know why i used it but u think it is important)
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
                                tag: "${trips[index].trip_name}_name",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "${trips[index].trip_name}",
                                    style: TextStyle(
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(152, 206, 213, 1),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              //now this row is used to hold the location you get from and the location you go to.
                              Row(
                                children: [
                                  Hero(
                                    tag: "${trips[index].trip_name}_pickup",
                                    child: Material(
                                      color: Color.fromRGBO(0, 0, 0, 0),
                                      child: Text(
                                        "${trips[index].trip_pick_up}  ",
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
                                    tag: "${trips[index].trip_name}_dropoff",
                                    child: Material(
                                      color: Color.fromRGBO(0, 0, 0, 0),
                                      child: Text(
                                        "  ${trips[index].trip_drop_off}  ",
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
                                    tag: "${trips[index].trip_name}_date",
                                    child: Material(
                                      color: Color.fromRGBO(152, 213, 177, 0),
                                      child: Text(
                                        "${trips[index].trip_time.year}-${Month[trips[index].trip_time.month - 1]}-${trips[index].trip_time.day}",
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
                                      color: Color.fromRGBO(152, 213, 177, 1),
                                    ),
                                  ),
                                  Hero(
                                    tag: "${trips[index].trip_name}_time",
                                    child: Material(
                                      color: Color.fromRGBO(152, 213, 177, 0),
                                      child: Text(
                                        "${GetFormatedHour(trips[index].trip_time.hour)}",
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
                                "\$${trips[index].trip_price}",
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
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: Color.fromRGBO(126, 148, 192, 0)),
        child: ElevatedButton(onPressed: () {}, child: Text("My reservations")),
      ),
    );
  }
}
