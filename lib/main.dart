import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/core/constant/routes.dart';
import 'package:reefs_nav/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/localization/changelocalization.dart';
import 'core/localization/translation.dart';
import 'core/services/tileManager/TileProviderModel.dart';
import 'routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initialService();

  // Check if the app is being opened for the first time
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // Retrieve saved credentials from SharedPreferences
  final savedEmail = prefs.getString('email');
  final savedPassword = prefs.getString('password');

  // Define the initial route based on whether it's the first time opening the app
  String? initialRoute;
  if (isFirstTime) {
    initialRoute = "/";
  } else if (savedEmail != null && savedPassword != null) {
    initialRoute = AppRoute.homeNavPage;
  } else {
    initialRoute = AppRoute.login;
  }

  // If it's the first time, set isFirstTime to false
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => TileProviderModel(),
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialRoute;

  const MyApp({Key? key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: ThemeData(
        fontFamily: "PlayfairDisplay",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColor.backgroundsecond,
          ),
          displayMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: AppColor.backgroundsecond),
          bodyLarge: TextStyle(
            height: 2,
            color: AppColor.backgroundsecond,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          bodyMedium: TextStyle(
            height: 2,
            color: AppColor.backgroundsecond,
            fontSize: 14,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(background: const Color.fromARGB(255, 206, 206, 206)),
      ),
      initialRoute: initialRoute,
      getPages: routes,
    );
  }
}
