import 'package:flutter/material.dart';
//import 'package:reefs_nav/core/constant/imageAssets.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircleAvatar(
          maxRadius: 100,
          backgroundImage: AssetImage('assets/images/logo.jpg'),
        ),
      ],
    );
  }
}
