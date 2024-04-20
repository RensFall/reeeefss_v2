import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/controller/onboardingcontroller.dart';
import 'package:reefs_nav/view/widget/onboarding/customebutton.dart';
import 'package:reefs_nav/view/widget/onboarding/customeslider.dart';
import 'package:reefs_nav/view/widget/onboarding/dotcontroller.dart';


class onBoarding extends StatelessWidget {
  const onBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return const Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          flex: 3,
          child: CustomeSliderOnBoaring(),
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                dotControllerOnBoarding(),
                Spacer(flex: 2),
                CustomeButtonOnBoarding(),
              ],
            ))
      ],
    )));
  }
}
