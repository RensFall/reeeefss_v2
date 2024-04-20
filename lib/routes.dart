import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/middleware/middleware.dart';
import 'package:reefs_nav/view/screen/auth/login.dart';
import 'package:reefs_nav/view/screen/auth/signup.dart';
import 'package:reefs_nav/view/screen/home/homepage.dart';
import 'package:reefs_nav/view/screen/language.dart';
import 'package:reefs_nav/view/screen/onBoarding.dart';
import 'package:reefs_nav/view/screen/auth/forgotpassword.dart';
import 'view/screen/home/pages/profile/profile.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signup, page: () => const SignUp()),
  GetPage(name: AppRoute.forgotpassword, page: () => const ForgetPassword()),
  //Onboarding
  GetPage(name: AppRoute.onBoarding, page: () => const onBoarding()),
  //MapPage
  GetPage(name: AppRoute.homeNavPage, page: () => const HomeNavPage()),
  //UserPage
  // GetPage(
  GetPage(name: AppRoute.profileScreen, page: () => const ProfileScreen()),
  GetPage(name: AppRoute.login, page: () => const Login()),
];
