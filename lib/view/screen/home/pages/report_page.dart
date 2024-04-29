import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController textFieldController1 = TextEditingController();
  String? selectedMenuItem;
  Position? currentPosition;
  bool isInvalidInput = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          '39'.tr,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLength: 10,
              controller: textFieldController1,
              onChanged: (value) {
                bool isNumeric = int.tryParse(value) != null;
                setState(() {
                  isInvalidInput = !isNumeric;
                });
              },
              decoration: InputDecoration(
                hintText: '5'.tr,
                hintStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                errorText: isInvalidInput ? '68'.tr : null, //<<<<<<<<<<
                errorStyle: const TextStyle(fontSize: 10),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: DropdownButton(
                style: const TextStyle(fontSize: 12, color: Colors.black),
                value: selectedMenuItem,
                hint: Text(
                  '51'.tr,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: '52'.tr,
                    child: Text(
                      '53'.tr,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '54'.tr,
                    child: Text('55'.tr),
                  ),
                  DropdownMenuItem(
                    value: '56',
                    child: Text('69'.tr),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMenuItem = value as String;
                  });
                },
              ),
            ),
            if (currentPosition != null)
              Text(
                //<<<<<<<<<<<<<<<<<<<<<<
                'Current Location: ${currentPosition!.latitude}, ${currentPosition!.longitude}',
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            String text1 = textFieldController1.text;
            List<String> errorMessages = [];

            if (selectedMenuItem == null) {
              errorMessages.add('70'.tr);
            }
            if (text1.isEmpty) {
              errorMessages.add('71'.tr);
            } else if (text1.length != 10) {
              errorMessages.add('50'.tr);
            }

            if (errorMessages.isEmpty) {
              sendDataToDatabase(text1, selectedMenuItem!, currentPosition);

              Navigator.of(context).pop();

              // Show a Dialog to notify the user
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.only(top: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    content: SizedBox(
                      child: Text(
                        '72'.tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '73'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    content: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '74'.tr,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: errorMessages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                errorMessages[index],
                                style: const TextStyle(color: Colors.blueGrey),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '73'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text(
            '58'.tr,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 40),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            '59'.tr,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void sendDataToDatabase(
    String text1,
    String selectedMenuItem,
    Position? currentPosition,
  ) {
    // Implement the logic to send the data to the database
    // Use the values of text1, selectedMenuItem, and currentPosition for the data you want to send
    // You can use network requests, API calls, or any other appropriate method
    // to send the data to the database

    // Example: Sending data to Firebase Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a new document in a collection
    firestore.collection('data').add({
      'text1': text1,
      'selectedMenuItem': selectedMenuItem,
      'currentPosition': currentPosition != null
          ? {
              'latitude': currentPosition.latitude,
              'longitude': currentPosition.longitude,
            }
          : null,
    }).then((DocumentReference documentRef) {
      // Data sent successfully
      print('Data sent to the database');
    }).catchError((error) {
      // Error occurred while sending data
      print('Error sending data to the database: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
}

class ReportPageData {
  final String phoneNumber;
  final String problem;
  final double? latitude;
  final double? longitude;

  ReportPageData({
    required this.phoneNumber,
    required this.problem,
    this.latitude,
    this.longitude,
  });

  factory ReportPageData.fromJson(Map<String, dynamic> json) {
    return ReportPageData(
      phoneNumber: json['phoneNumber'],
      problem: json['problem'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'problem': problem,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  ReportPageData copyWith({
    String? phoneNumber,
    String? problem,
    double? latitude,
    double? longitude,
  }) {
    return ReportPageData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      problem: problem ?? this.problem,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
