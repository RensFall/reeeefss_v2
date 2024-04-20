import 'dart:ui';
import 'package:get/get.dart';
import 'package:reefs_nav/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences.setString("lang", langCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? SharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (SharedPrefLang == "Arabic") {
      language = const Locale("Arabic");
    } else if (SharedPrefLang == "English") {
      language = const Locale("English");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }

    super.onInit();
  }
}
