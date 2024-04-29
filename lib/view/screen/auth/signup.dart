// ignore_for_file: use_build_context_synchronously
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
  const SignUp({super.key});

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
                //UserName field
                hinttext: "18".tr, //enter UserName
                labeltext: "17".tr, //User name
                iconData: Icons.person_outline,
                mycontroller: controllerImp.username,
              ),
              CustomeTextFormAuth(
                  //Email field
                  hinttext: "9".tr,
                  labeltext: "8".tr,
                  iconData: Icons.email_outlined,
                  mycontroller: controllerImp.email),
              CustomeTextFormAuth(
                //password field
                hinttext: "7".tr, //enter pass
                labeltext: "6".tr, //pass
                iconData: Icons.password_outlined,
                mycontroller: controllerImp.password,
              ),
              CustomeTextFormAuth(
                //password confirmation field
                hinttext: "16".tr, //enter pass
                labeltext: "15".tr, //pass
                iconData: Icons.password_outlined,
                mycontroller: controllerImp.confirmpass,
              ),
              CustomeTextFormAuthfuel(
                hinttext: '86'.tr,
                labeltext: '87'.tr,
                iconData: Icons.local_gas_station,
                mycontroller: controllerImp.fuel,
              ),
              CustomeButtonAuth(
                  //signUp button
                  text: '13'.tr,
                  onPressed: () async {
                    final signUp = await AuthService().signUp(
                      controllerImp.email.text,
                      controllerImp.password.text,
                      controllerImp.username.text,
                      controllerImp.fuel.text,
                    );
                    if (signUp != null) {
                      Get.toNamed(AppRoute.login);
                    } else {
                      Text("77".tr);
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              TextSignUpIn(
                textone: "14".tr, //have account field
                texttwo: "11".tr,
                //SignIn
                onTap: () {
                  controllerImp.goToLogin();
                },
              )
            ],
          )),
    );
  }
}
