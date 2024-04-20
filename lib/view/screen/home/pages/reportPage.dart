import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedProblem;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      //backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Report Problem',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            const SizedBox(height: 16),
            FutureBuilder<String>(
              future: _getLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Location: ${snapshot.data}',
                    style: TextStyle(color: Colors.black),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Failed to get location');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 16),
            const Text('Select a problem:',
                style: TextStyle(color: Colors.black)),
            DropdownButton<String>(
              iconEnabledColor: Colors.black,
              value: selectedProblem,
              onChanged: (String? newValue) {
                setState(() {
                  selectedProblem = newValue;
                });
              },
              items: <String>[
                'A new reef location',
                'Wrong reef location',
                'An error in the app',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                TextButton(
                  child: const Text('Send Report',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    sendReport(selectedProblem);
                    Fluttertoast.showToast(
                      msg: 'Location and message sent successfully!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return '${position.latitude}, ${position.longitude}';
  }
}

sendReport(String? problem) async {
  String username =
      're.alselehebi.21@gmail.com'; // Replace with your email address
  String password = '5vwIsI3vU20'; // Replace with your email password

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username)
    ..recipients.add(
        're.alselehebi.21@gmail.com') // Replace with the recipient's email address
    ..subject = 'Error Report'
    ..text =
        'Problem: $problem\nLocation: ${await _getLocation()}'; // Include the location in the email content

  try {
    final sendReport = await send(message, smtpServer);
    print('Report sent: ${sendReport.toString()}');
  } catch (e) {
    print('Error sending report:$e');
    Fluttertoast.showToast(
      msg: 'Failed to send location and message.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}

Future<String> _getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return '${position.latitude}, ${position.longitude}';
}
