import 'package:flutter/material.dart';
import 'package:reefs_nav/core/constant/color.dart';

class TextSignUpIn extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;

  const TextSignUpIn(
      {super.key,
      required this.textone,
      required this.texttwo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textone),
        InkWell(
          onTap: onTap,
          child: Text(
            texttwo,
            style: const TextStyle(
              color: AppColor.primarypurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
