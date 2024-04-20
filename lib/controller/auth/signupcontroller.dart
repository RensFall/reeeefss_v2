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

    super.onInit();
  }

  @override
  void dispose() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmpass = TextEditingController();
    super.dispose();
  }

  // Future<void> signUpWithCred() async {
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text,
  //       password: password.text,
  //     );
  //     await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  //     Get.toNamed(AppRoute.login);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
