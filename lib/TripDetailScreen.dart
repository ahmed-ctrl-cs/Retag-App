import 'package:flutter/material.dart';
import 'trip_data_holder.dart';

class Tripdetailscreen extends StatefulWidget {
  final Trip tripdata;
  Tripdetailscreen({super.key, required this.tripdata});

  @override
  State<Tripdetailscreen> createState() => _TripdetailscreenState();
}

class _TripdetailscreenState extends State<Tripdetailscreen> {
  final passnum = TextEditingController(text: "1");
  final bagnum = TextEditingController(text: "0");
  final notes = TextEditingController();
  @override
  void initState() {
    super.initState();
    passnum.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(87, 143, 255, 0.8),
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: "${widget.tripdata.trip_name}_name",
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.tripdata.trip_name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(152, 206, 213, 1),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(126, 148, 192, 0),
      ),
      body: ListView(
        children: [
          Column(
            //used to hold all elemnts in this screen
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  child: Row(
                    //used to hold the upper part of the screen
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          //used to hold the left part of the screen
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //used to hold the location data
                              children: [
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_pickup",
                                  child: Material(
                                    color: Color.fromRGBO(0, 0, 0, 0),
                                    child: Text(
                                      widget.tripdata.trip_pick_up,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(230, 172, 155, 1),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromRGBO(200, 210, 135, 1),
                                ),
                                SizedBox(width: 8),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_dropoff",
                                  child: Material(
                                    color: Color.fromRGBO(0, 0, 0, 0),
                                    child: Text(
                                      widget.tripdata.trip_drop_off,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(155, 242, 145, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              //this is to hold the date
                              children: [
                                Text(
                                  "Date : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(152, 213, 177, 1),
                                  ),
                                ),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_date",
                                  child: Material(
                                    color: Color.fromRGBO(0, 0, 0, 0),
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(152, 213, 177, 1),
                                      ),
                                      "${widget.tripdata.trip_time.year}-${Month[widget.tripdata.trip_time.month - 1]}-${widget.tripdata.trip_time.day}",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              //this is used to hold the time
                              children: [
                                Text(
                                  "Time : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(152, 213, 177, 1),
                                  ),
                                ),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_time",
                                  child: Material(
                                    color: Color.fromRGBO(0, 0, 0, 0),
                                    child: Text(
                                      '${GetFormatedHour(widget.tripdata.trip_time.hour)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(152, 213, 177, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ), //------------------------------this next block of code will be for the reservation fields------------------------------\\
              Padding(
                padding: const EdgeInsets.all(9),
                child: Card(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  child: Column(
                    children: [
                      //this block is for the three text fields
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number Of Passengers",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(125, 179, 59, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            color: Color.fromRGBO(255, 206, 206, 1),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: passnum,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number Of Bags",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(125, 179, 59, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            color: Color.fromRGBO(255, 206, 206, 1),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: bagnum,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Any notes?",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(125, 179, 59, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            color: Color.fromRGBO(255, 206, 206, 1),
                          ),
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          controller: notes,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Total price : ${widget.tripdata.trip_price * (int.tryParse(passnum.text) ?? 0)}",
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: Color.fromRGBO(126, 148, 192, 0)),
        child: ElevatedButton(onPressed: () {}, child: Text("Confirm")),
      ),
    );
  }
}
