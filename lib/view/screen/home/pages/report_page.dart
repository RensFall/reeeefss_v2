import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 130.0), // Adjust padding
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                hintText: '50'.tr,
                errorText: isInvalidInput ? 'Invalid input' : null,
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedMenuItem,
              hint: Text('51'.tr),
              onChanged: (value) {
                setState(() {
                  selectedMenuItem = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: '52'.tr,
                  child: Text('53'.tr),
                ),
                DropdownMenuItem(
                  value: '54'.tr,
                  child: Text('55'.tr),
                ),
                DropdownMenuItem(
                  value: '56'.tr,
                  child: Text('69'.tr),
                ),
              ],
            ),
            if (currentPosition != null) ...[
              const SizedBox(height: 16),
              Text(
                '127'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${"128".tr} ${currentPosition!.latitude}'),
              Text('${"129".tr} ${currentPosition!.longitude}'),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (isInvalidInput ||
                    selectedMenuItem == null ||
                    currentPosition == null) {
                  return;
                }

                try {
                  // Get current user
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    // User not authenticated
                    return;
                  }

                  // Save report data to user's subcollection
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('reports')
                      .add({
                    'textFieldValue': textFieldController1.text,
                    'selectedMenuItem': selectedMenuItem,
                    'latitude': currentPosition!.latitude,
                    'longitude': currentPosition!.longitude,
                    'timestamp': Timestamp.now(),
                  });

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Show success snackbar
                  Get.snackbar('111'.tr, '130'.tr,
                      snackPosition: SnackPosition.BOTTOM);
                } catch (e) {
                  print('Error saving report: $e');
                  // Show error snackbar
                  Get.snackbar('77'.tr, '131'.tr,
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('58'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
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
}
