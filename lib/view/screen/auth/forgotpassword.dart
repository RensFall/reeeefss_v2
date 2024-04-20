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
                hinttext: "5".tr, //enter Phone number
                labeltext: "4".tr, //Phone number
                iconData: Icons.phone_outlined,
                mycontroller: controller.email,
              ),
              CustomeButtonAuth(
                  //Verify number button
                  text: '20'.tr,
                  onPressed: () async {
                    final forgotpassword = await AuthService()
                        .forgotPassword(controller.email.text);
                    if (forgotpassword != AuthStatus.successful) {
                      Get.offNamed(AppRoute.signup);
                    } else {
                      final snackBar =
                          SnackBar(content: Text(forgotpassword.name));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
