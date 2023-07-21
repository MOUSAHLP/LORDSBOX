import 'dart:convert';

import 'package:get/get.dart';
import 'package:lordsbox/core/localization/change_localization.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';

class MyDrawerController extends GetxController {
  MyServices myServices = Get.find();
  LocaleController LanguageController = Get.find<LocaleController>();
  Future<void> onInit() async {
    await initializeUserModel();
    super.onInit();
  }

  UserModel? userModel;

  initializeUserModel() async {
    String? userData =
        await myServices.sharedPreferences.getString("userModel");
    userModel = UserModel.fromJson(json.decode(userData!));
    update();
  }

  ChangeLocalDrawer(String localCode) {
    LanguageController.changeLang(localCode);
    update();
  }

  logout() async {
    await myServices.sharedPreferences.remove("isLoggedIn");
    await myServices.sharedPreferences.remove("userModel");
    Get.offAllNamed(AppRoute.login);
  }
}
