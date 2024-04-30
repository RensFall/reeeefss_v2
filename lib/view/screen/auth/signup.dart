import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/services/auth_service.dart';
import '../../../controller/auth/signupcontroller.dart';
import '../../widget/auth/customebuttonauth.dart';
import '../../widget/auth/custometextdoubleauth.dart';
import '../../widget/auth/custometextformauth.dart';
import '../../widget/auth/textsignup.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controllerImp = Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundsecond,
        elevation: 0.0,
        centerTitle: true,
        title: Text("13".tr,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColor.white)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 100),
            CustomeTextFormAuth(
              hinttext: "18".tr, //enter UserName
              labeltext: "17".tr, //User name
              iconData: Icons.person_outline,
              mycontroller: controllerImp.username,
            ),
            CustomeTextFormAuth(
              hinttext: "9".tr, //Enter Email
              labeltext: "8".tr, //Email
              iconData: Icons.email_outlined,
              mycontroller: controllerImp.email,
            ),
            CustomeTextFormAuth(
              hinttext: "7".tr, //Enter Password
              labeltext: "6".tr, //Password
              iconData: Icons.password_outlined,
              mycontroller: controllerImp.password,
            ),
            CustomeTextFormAuth(
              hinttext: "16".tr, //Confirm Password
              labeltext: "15".tr, //Confirm Password
              iconData: Icons.password_outlined,
              mycontroller: controllerImp.confirmpass,
            ),
            CustomeTextFormAuthfuel(
              hinttext: '86'.tr, //Enter Fuel
              labeltext: '87'.tr, //Fuel
              iconData: Icons.local_gas_station,
              mycontroller: controllerImp.fuel,
            ),
            CustomeButtonAuth(
              text: '13'.tr, //SignUp
              onPressed: () async {
                // Check if email is valid
                bool isEmailValid = validateEmail(controllerImp.email.text);
                if (!isEmailValid) {
                  Get.snackbar('77'.tr, '107'.tr,
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Check if passwords match
                bool passwordsMatch = confirmPasswordMatch(
                  controllerImp.password.text,
                  controllerImp.confirmpass.text,
                );

                if (!passwordsMatch) {
                  Get.snackbar('77'.tr, "108".tr,
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Check if fuel consumption rate is a valid number
                if (!isValidFuel(controllerImp.fuel.text)) {
                  Get.snackbar('77'.tr, "109".tr,
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Check if first name is entered
                if (controllerImp.username.text.isEmpty) {
                  Get.snackbar("77".tr, "110".tr,
                      snackPosition: SnackPosition.BOTTOM);
                  return;
                }

                // Proceed with sign-up if all validations pass
                final signUp = await AuthService().signUp(
                  controllerImp.email.text,
                  controllerImp.password.text,
                  controllerImp.username.text,
                  controllerImp.fuel.text,
                );

                if (signUp != null) {
                  Get.toNamed(AppRoute.login);
                } else {
                  AuthService().errorCode;
                }
              },
            ),
            const SizedBox(height: 30),
            TextSignUpIn(
              textone: "14".tr, //Have Account?
              texttwo: "11".tr, //SignIn
              onTap: () {
                controllerImp.goToLogin();
              },
            )
          ],
        ),
      ),
    );
  }

  // Define the confirmPasswordMatch function
  bool confirmPasswordMatch(String password, String confirmPassword) {
    return password == confirmPassword;
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

  // Define the isValidFuel function
  bool isValidFuel(String fuel) {
    try {
      // Attempt to parse the fuel value as a double
      double.parse(fuel);
      return true; // If parsing succeeds, return true
    } catch (e) {
      return false; // If parsing fails, return false
    }
  }
}
