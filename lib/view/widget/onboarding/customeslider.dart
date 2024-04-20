import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/controller/onboardingcontroller.dart';
import 'package:reefs_nav/data/data-source/static.dart';

class CustomeSliderOnBoaring extends GetView<OnBoardingControllerImp> {
  const CustomeSliderOnBoaring({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.onPageChanged(value);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  onBoardingList[i].image!,
                  width: 200,
                  height: 230,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(onBoardingList[i].title!,
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    onBoardingList[i].body!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ));
  }
}
