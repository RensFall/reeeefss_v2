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

  // Future<void> LoginWithEmailAndPwd() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email.text,
  //       password: password.text,
  //     );
  //     if (credential.user!.emailVerified) {
  //       Get.toNamed(AppRoute.homeNavPage);
  //     } else {
  //       await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  //       print("Error ------------------------------------");
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       AwesomeDialog(
  //         context: context, // Using context here
  //         dialogType: DialogType.info,
  //         animType: AnimType.rightSlide,
  //         title: 'Dialog Title',
  //         desc: 'Dialog description here.............',
  //       ).show();
  //     } else if (e.code == 'wrong-password') {
  //       AwesomeDialog(
  //         context: context, // Using context here
  //         dialogType: DialogType.info,
  //         animType: AnimType.rightSlide,
  //         title: 'Dialog Title',
  //         desc: 'ERRRRRRRRROLORRRRRRRRRRRRRRRR',
  //       ).show();
  //     }
  //   }
  // }
}
