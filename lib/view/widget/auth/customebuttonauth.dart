import 'package:flutter/material.dart';
import 'package:reefs_nav/core/constant/color.dart';

class CustomeButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomeButtonAuth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: AppColor.primarypurple,
        textColor: Colors.white,
        child: Text(text),
      ),
    );
  }
}
