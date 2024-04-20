import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:reefs_nav/controller/onboardingcontroller.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/data/data-source/static.dart'; // Import necessary colors if not already imported

class dotControllerOnBoarding extends StatelessWidget {
  const dotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onBoardingList.length,
                    (index) => AnimatedContainer(
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 2),
                          duration: const Duration(milliseconds: 800),
                          width: controller.currentPage == index ? 33 : 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: AppColor.primarypurple,
                              borderRadius: BorderRadius.circular(10)),
                        ))
              ],
            ));
  }
}
