import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ReportButton extends StatefulWidget {
  @override
  _ReportButtonState createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  String _location = '';
  String _message = '';

  Future<void> _sendEmail() async {
    final Email email = Email(
      body: _message,
      subject: 'User Report',
      recipients: ['re.alselehebi.21@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Text('Location: $_location'),
        SizedBox(height: 8),
        Text('Message: $_message'),
      ],
    );
  }
}
