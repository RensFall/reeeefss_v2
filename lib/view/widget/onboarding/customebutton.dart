import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/controller/onboardingcontroller.dart';
import 'package:reefs_nav/core/constant/color.dart';

class CustomeButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomeButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 0),
        textColor: Colors.white,
        onPressed: () {
          controller.next();
        },
        color: AppColor.primarypurple,
        child: Text(
          // Continue
          "34".tr,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
