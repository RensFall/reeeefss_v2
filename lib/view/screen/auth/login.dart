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
        //sign in
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
              text: '11'.tr, //login button
              onPressed: () async {
                // Validate email format
                bool isEmailValid = validateEmail(controllerImp.email.text);
                if (!isEmailValid) {
                  Get.snackbar('77'.tr, '107'.tr,
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Perform sign-in
                final signIn = await AuthService().signIn(
                  controllerImp.email.text,
                  controllerImp.password.text,
                );

                if (signIn != null) {
                  // Navigate to the home page
                  Get.toNamed(AppRoute.homeNavPage);
                  disableBackButton(context);
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
            ),
            SizedBox(height: 10), // Add some space
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoute.homeNavPage);
              },
              child: Text(
                '132  '.tr,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Define the email validation function
  bool validateEmail(String email) {
    // Regular expression for validating email
    // This regex checks for a valid email format
    // It may not cover all possible cases, but it's a common and basic validation
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Regular expression for email
    RegExp regex = RegExp(emailRegex); // Compile the regex
    return regex.hasMatch(email); // Check if email matches the regex
  }

  void disableBackButton(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoute.homeNavPage, (Route<dynamic> route) => false);
  }
}
