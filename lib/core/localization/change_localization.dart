import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/services/storage_service.dart';

class LocaleController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    language = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == null) {
      if (Get.deviceLocale!.languageCode == "ar") {
        language = const Locale("ar");
      } else {
        language = const Locale("en");
      }
    } else {
      if (sharedPrefLang == "ar") {
        language = const Locale("ar");
      } else {
        language = const Locale("en");
      }
    }
    super.onInit();
  }
}
