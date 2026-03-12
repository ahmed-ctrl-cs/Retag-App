import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retag_app/core/AppColors.dart';
import 'package:retag_app/core/widgets/RetagButton.dart';
import 'package:retag_app/trip_data_holder.dart';

class ManageTripScreen extends StatefulWidget {
  const ManageTripScreen({super.key});

  @override
  State<ManageTripScreen> createState() => _ManageTripScreenState();
}

class _ManageTripScreenState extends State<ManageTripScreen> {
  int? selectedPickup;

  int? selectedDropoff;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final tripNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.adminBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Appcolors.adminBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
            ),
            builder: (context) {
              bool showLocalTimeError = false;
              //---start the ui of the buttom sheet---//
              //this is going to be hell, it is now 11:39 pm and i have been here updating this shit since 10:00pm with no breaks
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      right: 20,
                      left: 20,
                      top: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //---title of the bottom sheet---//
                          Text(
                            "Add a new trip",
                            style: TextStyle(
                              fontSize: 20,
                              color: Appcolors.textLight,
                            ),
                          ),
                          SizedBox(height: 20),
                          //---start the trip name field---//
                          TextFormField(
                            controller: tripNameController,
                            style: TextStyle(color: Appcolors.textLight),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Fill the name field';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter trip name',
                              labelStyle: TextStyle(color: Appcolors.textMuted),
                              filled: true,
                              fillColor: Appcolors.inputFill,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Appcolors.errorBackground,
                                  width: 2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Appcolors.errorBackground,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          //---end the trip name field---//
                          SizedBox(height: 15),
                          //---start asking for teh pickup location---//
                          DropdownButtonFormField<int>(
                            value: selectedPickup,
                            validator: (value) => value == null
                                ? 'Select a pickup location'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Appcolors.glassEffect,
                              labelText: 'Pickup location',
                              labelStyle: TextStyle(color: Appcolors.textMuted),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Appcolors.errorBackground,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
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
                              setModalState(() {
                                selectedPickup = newValue;
                              });
                            },
                          ),
                          //---end asking for the pickup location---//
                          SizedBox(height: 10),
                          //---start asking for the dropoff location---//
                          DropdownButtonFormField<int>(
                            value: selectedDropoff,
                            validator: (value) => value == null
                                ? 'Select a dropoff location'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Appcolors.glassEffect,
                              labelText: 'Dropoff location',
                              labelStyle: TextStyle(color: Appcolors.textMuted),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Appcolors.errorBackground,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
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
                              setModalState(() {
                                selectedDropoff = newValue;
                              });
                            },
                          ),

                          //---end asking for the dropoff location---//
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  );
                },
              );
              //---end the ui of the bottom sheet---//
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trips').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No trips found',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              );
            }
            var TripsList = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (context, index) {
                var trips = TripsList[index];
                return Card(
                  color: Appcolors.cardBlue,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Appcolors.adminBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Edit Trip',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    print('edited');
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text('Delete'),
                                  onTap: () async {
                                    print('deleted');
                                    var mass = ScaffoldMessenger.of(context);
                                    Navigator.pop(context);
                                    await trips.reference.delete();
                                    mass.showSnackBar(
                                      SnackBar(content: Text('Trip deleted')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trips['trip_name'],
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    Pickup[trips['trip_pick_up']],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Appcolors.textLight,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    Dropoff[trips['trip_drop_off']],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${trips['trip_time'].toDate().year} ${Month[trips['trip_time'].toDate().month - 1]},${trips['trip_time'].toDate().day}  ${GetFormatedHour(trips['trip_time'].toDate().hour)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: TripsList.length,
            );
          },
        ),
      ),
    );
  }
}
