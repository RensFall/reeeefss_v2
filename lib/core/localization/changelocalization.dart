import 'dart:ui';
import 'package:get/get.dart';
import 'package:reefs_nav/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  void changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences.setString("lang", langCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "Arabic") {
      language = const Locale("Arabic");
    } else if (sharedPrefLang == "English") {
      language = const Locale("English");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }

    super.onInit();
  }
}
