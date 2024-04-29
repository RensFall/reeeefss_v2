// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/services/auth_service.dart';
import '../../../controller/auth/logincontroller.dart';
import '../../widget/auth/customebuttonauth.dart';
import '../../widget/auth/custometextbodyauth.dart';
import '../../widget/auth/custometextformauth.dart';
import '../../widget/auth/custometexttitle.dart';
import '../../widget/auth/logoAuth.dart';
import '../../widget/auth/textsignup.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controllerImp = Get.put(LoginControllerImp());
    controllerImp.setContext(context); // Set the context in the controller
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundsecond,
        elevation: 0.0,
        centerTitle: true,
        //sing in
        title: Text("11".tr,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColor.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(
          children: [
            const LogoAuth(),
            const SizedBox(height: 15),
            CustomeTextTitleAuth(text: "2".tr), //welcomeback
            const SizedBox(height: 20),
            CustomeTextBodyAuth(text: "3".tr), //body intro
            const SizedBox(height: 15),
            CustomeTextFormAuth(
              //Phone number field
              mycontroller: controllerImp.email,
              hinttext: "9".tr, //enter Email
              labeltext: "8".tr, //Email
              iconData: Icons.email_outlined,
            ),
            const SizedBox(height: 10),
            CustomeTextFormAuth(
              //password field
              mycontroller: controllerImp.password,
              hinttext: "7".tr, //enter pass
              labeltext: "6".tr, //pass
              iconData: Icons.password_outlined,
            ),
            InkWell(
              onTap: () {
                controllerImp.goToForgetPass();
              },
              child: Text(
                //forget password
                "10".tr,
                textAlign: TextAlign.end,
              ),
            ),
            CustomeButtonAuth(
              text: '11'.tr, //signUp button
              onPressed: () async {
                final signIn = await AuthService().signIn(
                    controllerImp.email.text, controllerImp.password.text);
                // Check if the sign-in was successful and the user's email is verified
                if (signIn != null) {
                  // Navigate to the home page
                  Get.toNamed(AppRoute.homeNavPage);
                } else {
                  // Show a snackbar indicating an error
                  const snackBar = SnackBar(content: Text('Error'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextSignUpIn(
              textone: "12".tr, //no account field
              texttwo: "13".tr, //SignUp
              onTap: () {
                controllerImp.goToSignUp();
              },
            )
          ],
        ),
      ),
    );
  }
}
