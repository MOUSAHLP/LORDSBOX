import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/core/functions/mysnackbar.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:http/http.dart' as http;
import 'package:lordsbox/core/services/storage_service.dart';

class LogInController extends GetxController {
  TextEditingController idController = TextEditingController();

  MyServices myServices = Get.find();
  bool isLoading = false;
  login() async {
    if (idController.text.trim() != "") {
      try {
        isLoading = true;
        update();

        var url = Uri.parse(loginUrl);

        var response = await http.post(url, body: {
          "uniqueId": idController.text.trim(),
        });
        var responseJson = json.decode(response.body);
        print(responseJson);

        if (responseJson["status"] == "success") {
          String userModel =
              jsonEncode(UserModel.fromJson(responseJson["data"][0]));
          await myServices.sharedPreferences.setString('userModel', userModel);
          await myServices.sharedPreferences
              .setBool(MyConstants.isLoggedInKey, true);
          navigateTofirstPage();
        } else {
          mySnackBar(
            "Error".tr,
            "ID Not Found Or UnApproved Id".tr,
            icon: Icons.close,
          );
        }

        isLoading = false;
        update();
      } catch (e) {
        print(e);
      }
    } else {
      mySnackBar(
        "Error".tr,
        "Please Enter A Valid id".tr,
        icon: Icons.close,
      );
    }
  }

  String? validator(String? text) {
    if (idController.text == "") {
      return "Please Enter A Valid id".tr;
    }
    return null;
  }

  navigateTofirstPage() {
    Get.offAllNamed(AppRoute.firstPage);
  }

  navigateToSignUp() {
    Get.offAllNamed(AppRoute.signup);
  }
}
