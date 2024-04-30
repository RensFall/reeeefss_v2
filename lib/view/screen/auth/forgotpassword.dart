import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/controller/auth/forgotpasswordcontroller.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/core/constant/enum.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/services/auth_service.dart';
import 'package:reefs_nav/view/widget/auth/customebuttonauth.dart';
import 'package:reefs_nav/view/widget/auth/custometextformauth.dart';
import 'package:reefs_nav/view/widget/auth/custometexttitle.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        centerTitle: true,
        //forgot password text
        title: Text("19".tr,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColor.white)),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              CustomeTextTitleAuth(text: "21".tr), //welcomeback
              const SizedBox(height: 100),
              CustomeTextFormAuth(
                //Phone number field
                hinttext: "5".tr, //enter email
                labeltext: "4".tr, //email
                iconData: Icons.phone_outlined,
                mycontroller: controller.email,
              ),
              CustomeButtonAuth(
                  //Verify email button
                  text: '20'.tr,
                  onPressed: () async {
                    // Check if the email field is empty
                    if (controller.email.text.isEmpty) {
                      // Display an error message if the email field is empty
                      Get.snackbar('77'.tr, '9'.tr,
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    // Check if the entered email exists in the Firestore database
                    final isEmailExists = await authService
                        .checkIfEmailExists(controller.email.text);

                    if (isEmailExists) {
                      // If the email exists, send a password reset email
                      final forgotPasswordResult = await AuthService()
                          .forgotPassword(controller.email.text);

                      if (forgotPasswordResult == AuthStatus.successful) {
                        // Display a success message and navigate to login screen
                        Get.snackbar('111'.tr, '105'.tr,
                            snackPosition: SnackPosition.BOTTOM);
                        Get.offNamed(AppRoute.login);
                      } else {
                        // Display an error message if failed to send verification email
                        final snackBar =
                            SnackBar(content: Text(forgotPasswordResult.name));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      // If the email doesn't exist, display an error message
                      Get.snackbar('77'.tr, '106'.tr,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}
