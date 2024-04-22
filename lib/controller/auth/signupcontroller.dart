import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/routes.dart';

abstract class SignUpController extends GetxController {
  signup();
  goToLogin();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmpass;
  late TextEditingController fuel;

  @override
  goToLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  signup() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmpass = TextEditingController();
    fuel = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmpass = TextEditingController();
    fuel = TextEditingController();
    super.dispose();
  }
}
