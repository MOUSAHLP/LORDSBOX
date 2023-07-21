import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/functions/background_service.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;

  MyServices myServices = Get.find();

  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString(MyConstants.appStageKey) ==
        "map") {
      service.startService();
      return const RouteSettings(name: AppRoute.mapPage);
    } else if (myServices.sharedPreferences
            .getString(MyConstants.appStageKey) ==
        "PM") {
      return RouteSettings(
        name: AppRoute.uploadImage,
        arguments: {
          "appbarText": "Before You Go".tr,
          "worksHour": counterFormat(myServices.sharedPreferences
              .getInt(MyConstants.counterCachedKey)!)
        },
      );
    } else if (myServices.sharedPreferences
            .getBool(MyConstants.isLoggedInKey) ==
        true) {
      return const RouteSettings(name: AppRoute.homePage);
    } else if (myServices.sharedPreferences
            .getBool(MyConstants.isLanguageKey) ==
        true) {
      return const RouteSettings(name: AppRoute.signup);
    }
    return null;
  }
}
