import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/localization/changelocalization.dart';
import '../widget/language/customeButtonlang.dart';

class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1".tr, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            CustomeButtonLang(
              textButton: "Arabic",
              onPressed: () {
                controller.changeLang("Arabic");
                Get.toNamed(AppRoute.onBoarding);
              },
            ),
            CustomeButtonLang(
              textButton: "English",
              onPressed: () {
                controller.changeLang("English");
                Get.toNamed(AppRoute.onBoarding);
              },
            )
          ],
        ),
      ),
    );
  }
}
