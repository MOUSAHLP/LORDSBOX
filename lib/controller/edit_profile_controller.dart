import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lordsbox/core/classes/multipart_request.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/core/functions/mysnackbar.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';

class EditProfileController extends GetxController {
  MyServices myServices = Get.find();
  @override
  Future<void> onInit() async {
    await initializeUserModel();
    super.onInit();
  }

  UserModel? userModel;

  initializeUserModel() async {
    String? userData =
        await myServices.sharedPreferences.getString("userModel");
    userModel = UserModel.fromJson(json.decode(userData!));
    initializeInputController();
    update();
  }

  TextEditingController nameInputController = TextEditingController();
  TextEditingController carNumberInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();

  initializeInputController() {
    nameInputController.text = userModel!.name!;
    carNumberInputController.text = userModel!.carNumber!;
    emailInputController.text = userModel!.email!;
    phoneInputController.text = userModel!.phone!;
    update();
  }

  File? img;
  pickAnImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      img = File(photo.path);
      update();
    }
  }

  String dateFormat() {
    String date = DateTime.now().toString();
    date = date.substring(0, date.lastIndexOf("."));
    date = date.replaceAll(" ", "_");
    date = date.replaceAll("-", "_");
    date = date.replaceAll(":", "_");
    return date;
  }

  double progress = 0;
  deleteUser() async {
    try {
      var url = Uri.parse(deleteUserDataUrl);

      Map data = {
        "id": "${userModel!.id}",
      };
      var response = await http.post(
        url,
        body: data,
      );

      var responseJson = json.decode(response.body);
      print(responseJson);

      if (responseJson["status"] == "success") {
        mySnackBar(
          "Seccess".tr,
          "User Has Been Deleted".tr,
          icon: Icons.check,
        );

        await myServices.sharedPreferences.remove('userModel');
        await myServices.sharedPreferences
            .setBool(MyConstants.isLoggedInKey, false);

        Get.offAllNamed(AppRoute.signup);
      }
    } catch (e) {
      progress = 0;
      mySnackBar(
        "Failure".tr,
        "SomeThing Went Wrong".tr,
        icon: Icons.close,
      );
      print(e);
    }
    update();
  }

  updateUserData() async {
    try {
      final request = MultipartRequest(
        'POST',
        Uri.parse(updateUserUrl),
        onProgress: (int bytes, int total) {
          progress = bytes / total;
          update();
        },
      );

      request.fields["id"] = "${userModel!.id}";
      request.fields["name"] = nameInputController.text;
      request.fields["carNumber"] = carNumberInputController.text;
      request.fields["email"] = emailInputController.text;
      request.fields["phone"] = phoneInputController.text;

      if (img != null) {
        String filename = "${nameInputController.text}_${dateFormat()}.png";
        Uint8List? imgBytes;
        imgBytes = await img!.readAsBytes();
        request.files.add(
          await http.MultipartFile.fromBytes('file', imgBytes,
              filename: filename),
        );
      }
      // done
      await request.send().then((value) async {
        var responseString = await value.stream.bytesToString();
        var responseJson = json.decode(responseString);
        print(responseJson);
        if (responseJson["status"] == "success") {
          print(responseJson["data"]);

          userModel!.name = responseJson["data"]["name"];
          userModel!.carNumber = responseJson["data"]["carNumber"];
          userModel!.email = responseJson["data"]["email"];
          userModel!.phone = responseJson["data"]["phone"];
          userModel!.userImage = responseJson["data"]["userImage"];

          //update user model

          await updateUserModel();

          mySnackBar(
            "Seccess".tr,
            "User Information Has Been Updated".tr,
            icon: Icons.check,
          );
          progress = 0;
        }
      });
    } catch (e) {
      progress = 0;
      mySnackBar(
        "Failure".tr,
        "SomeThing Went Wrong".tr,
        icon: Icons.close,
      );
      print(e);
    }
    update();
  }

  updateUserModel() async {
    String upDatedUserModel = jsonEncode(userModel);
    await myServices.sharedPreferences.setString('userModel', upDatedUserModel);
  }

  String? emailValidator(String? text) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailInputController.text)) {
      return "Please Enter A Valid Email".tr;
    }
    return null;
  }
}
