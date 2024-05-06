import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/routes.dart';

abstract class LoginController extends GetxController {
  void login();
  void goToSignUp();
  void goToForgetPass();
  void setContext(BuildContext context); // Adding setContext method
}

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  late BuildContext context; // Storing context locally
  final RxBool saveMe = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void setContext(BuildContext context) {
    this.context = context; // Setting context
  }

  @override
  void login() {}

  @override
  void goToSignUp() {
    Get.offNamed(AppRoute.signup);
  }

  @override
  void goToForgetPass() {
    Get.toNamed(AppRoute.forgotpassword);
  }
}
