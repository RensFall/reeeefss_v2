import 'package:flutter/material.dart';
import 'package:reefs_nav/core/constant/color.dart';

class CustomeButtonLang extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const CustomeButtonLang(
      {super.key, required this.textButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
            onPressed: onPressed,
            color: AppColor.primarypurple,
            textColor: AppColor.white,
            child: Text(
              textButton,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}
