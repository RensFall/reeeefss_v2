import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/constant/color.dart';
import 'package:reefs_nav/core/services/services.dart';
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => TileProviderModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            color: AppColor.white,
          ),
          displayMedium: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.white),
          bodyLarge: TextStyle(
            height: 2,
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          bodyMedium: TextStyle(
            height: 2,
            color: Color.fromARGB(255, 172, 170, 170),
            fontSize: 14,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(background: const Color.fromARGB(255, 206, 206, 206)),
      ),
      getPages: routes,
    );
  }
}
