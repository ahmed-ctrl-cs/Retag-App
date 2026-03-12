import 'package:flutter/material.dart';
import 'package:retag_app/core/AppColors.dart';
import 'trip_data_holder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tripdetailscreen extends StatefulWidget {
  final Trip tripdata;
  const Tripdetailscreen({super.key, required this.tripdata});

  @override
  State<Tripdetailscreen> createState() => _TripdetailscreenState();
}

class _TripdetailscreenState extends State<Tripdetailscreen> {
  final passnum = TextEditingController(text: "1");
  final bagnum = TextEditingController(text: "0");
  final notes = TextEditingController();
  int? selectedPickup;
  int? selectedDropoff;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    passnum.addListener(() {
      setState(() {});
    });
  }

  //---Start helper function to update price according to pickup location---//
  double GetDynamicPrice() {
    double BasePrice = widget.tripdata.trip_price;
    if (selectedPickup == 0 || selectedPickup == 1) {
      BasePrice = 70;
    } else if (selectedPickup == 2 || selectedPickup == 3)
      BasePrice = 60;
    return BasePrice;
  }
  //---End helper function to update price according to pickup location---//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.userDashboardBg,
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
                color: Appcolors.textLight,
              ),
            ),
          ),
        ),
        backgroundColor: Appcolors.userDashboardBg,
      ),
      body: ListView(
        children: [
          Column(
            //used to hold all elemnts in this screen
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Appcolors.cardBlue,
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
                                    color: Colors.transparent,
                                    child: Text(
                                      widget.tripdata.trip_pick_up,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolors.textLight,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Appcolors.textMuted,
                                ),
                                SizedBox(width: 8),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_dropoff",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      widget.tripdata.trip_drop_off,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolors.textLight,
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
                                    color: Appcolors.textLight,
                                  ),
                                ),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_date",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolors.textLight,
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
                                    color: Appcolors.textLight,
                                  ),
                                ),
                                Hero(
                                  tag: "${widget.tripdata.trip_name}_time",
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      GetFormatedHour(
                                        widget.tripdata.trip_time.hour,
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Appcolors.textLight,
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
                  color: Appcolors.cardBlue,
                  child: Column(
                    children: [
                      //this block is for the three text fields
                      //---Start asking for passengers---//
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number Of Passengers",
                            labelStyle: TextStyle(color: Appcolors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: Appcolors.textLight),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: passnum,
                        ),
                      ),
                      //---End asking for passengers---//
                      //---Start asking for bags---//
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Number Of Bags",
                            labelStyle: TextStyle(color: Appcolors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: Appcolors.textLight),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: bagnum,
                        ),
                      ),
                      //---End asking for bags---//
                      //---Start asking for pickup location---//
                      Container(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: "Pickup Location",
                            labelStyle: TextStyle(color: Appcolors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          dropdownColor: Appcolors.dropDownColor,
                          style: TextStyle(color: Appcolors.textLight),
                          items: List.generate(Pickup.length, (index) {
                            return DropdownMenuItem<int>(
                              child: Text(Pickup[index]),
                              value: index,
                            );
                          }),
                          onChanged: (newValue) {
                            setState(() {
                              selectedPickup = newValue;
                            });
                          },
                        ),
                      ),
                      //---End asking for pickup location---//
                      //---Start asking for dropoff location---//
                      Container(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: "Dropoff Location",
                            labelStyle: TextStyle(color: Appcolors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          dropdownColor: Appcolors.dropDownColor,
                          style: TextStyle(color: Appcolors.textLight),
                          items: List.generate(Dropoff.length, (index) {
                            return DropdownMenuItem<int>(
                              child: Text(Dropoff[index]),
                              value: index,
                            );
                          }),
                          onChanged: (newValue) {
                            setState(() {
                              selectedDropoff = newValue;
                            });
                          },
                        ),
                      ),
                      //---End asking for dropoff location---//
                      //---Start asking for notes---//
                      Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Any notes?",
                            labelStyle: TextStyle(color: Appcolors.textMuted),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: Appcolors.textLight),
                          maxLines: 2,
                          keyboardType: TextInputType.multiline,
                          controller: notes,
                        ),
                      ),
                      //---End asking for notes---//
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //---Start display total price---//
              Text(
                "Total price : ${GetDynamicPrice() * (int.tryParse(passnum.text) ?? 0)}",
              ),
              //---End display total price---//
            ],
          ),
        ],
      ),
      //---Start confirming button---//
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: Colors.transparent),
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  if (selectedDropoff == null || selectedPickup == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Pickup and Dropoff locations must be selected",
                        ),
                        backgroundColor: Appcolors.errorBackground,
                      ),
                    );
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    //---Start asking database for the user credintials---//
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    DocumentSnapshot UserDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get();
                    //---End asking database for the user credintials---//
                    String PassName = UserDoc['name'];
                    String PassPhoneNumber = UserDoc['phonenumber'];
                    //---Create reservation---//
                    await FirebaseFirestore.instance
                        .collection('reservations')
                        .add({
                          'trip_name': widget.tripdata.trip_name,
                          'pickup_location': selectedPickup,
                          'dropoff_location': selectedDropoff,
                          'passengers': int.tryParse(passnum.text) ?? 1,
                          'bags': int.tryParse(bagnum.text) ?? 0,
                          'notes': notes.text,
                          'total_price':
                              GetDynamicPrice() *
                              (int.tryParse(passnum.text) ?? 1),
                          'pass_name': PassName,
                          'pass_phonenumber': PassPhoneNumber,
                          'pass_uid': uid,
                          'status': 'pending',
                          'time_stamp': FieldValue.serverTimestamp(),
                        });
                    //---End creating reservation---//

                    //---Start navigating back to the homescreen---//
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Trip reserved!"),
                        backgroundColor: Appcolors.successBackground,
                      ),
                    );
                    Navigator.pop(context);
                    //---End navigating back to the homescreen---//
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("An error occured: $e"),
                        backgroundColor: Appcolors.errorBackground,
                      ),
                    );
                  }
                },
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text("Confirm"),
        ),
      ),

      //---End confirming button---//
    );
  }
}
