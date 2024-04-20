import 'package:flutter/material.dart';

class CustomeTextTitleAuth extends StatelessWidget {
  final String text;
  const CustomeTextTitleAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
