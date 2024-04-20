import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/routes.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController email;

  @override
  checkemail() async {
    if (email == "") {
      print("please enter email");
      return;
    }
    // await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email = TextEditingController();
    super.dispose();
  }
}
