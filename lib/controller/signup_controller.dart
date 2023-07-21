import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lordsbox/core/classes/multipart_request.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/core/functions/mysnackbar.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

class SignUpController extends GetxController {
  @override
  void onInit() {
    emailController.addListener(() {
      update();
    });
    phoneController.addListener(() {
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  int currStep = 0;
  TextEditingController userNameController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void onStepCancel() {
    if (currStep != 0) {
      currStep--;
      update();
    }
  }

  void onStepContinue() {
    if (currStep != 2) {
      currStep++;
      update();
    } else {
      if (isStepOneActive() && isStepTwoActive() && isStepThreeActive()) {
        signup();
      } else {
        mySnackBar(
          "Error".tr,
          "Please Fill All The Required Inputs".tr,
          icon: Icons.close,
        );
      }
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

  MyServices myServices = Get.find();
  double progress = 0;
  bool isSignedUp = false;
  signup() async {
    request(
      url: signupUrl,
      body: {
        "name": userNameController.text,
        "carNumber": carNumberController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      },
      uploadImage: img,
      imageName: "${userNameController.text}_${dateFormat()}.png",
      onProgress: (int bytes, int total) {
        progress = bytes / total;
        print(progress);
        update();
      },
      onDone: (value) async {
        var responseString = await value.stream.bytesToString();
        var responseJson = json.decode(responseString);
        print(responseJson);
        if (responseJson["status"] == "success") {
          String userModel =
              jsonEncode(UserModel.fromJson(responseJson["data"]));
          await myServices.sharedPreferences.setString('userModel', userModel);

          isSignedUp = true;
          progress = .001;
          img = null;
        }
        update();
      },
    );
  }

  void onStepTapped(int stepIndex) {
    currStep = stepIndex;
    update();
  }

  bool isStepOneActive() {
    if (userNameController.text != "" && carNumberController.text != "") {
      return true;
    }
    return false;
  }

  StepState stepOneState() {
    if (!isStepOneActive() && currStep > 0) {
      return StepState.error;
    } else if (isStepOneActive() && currStep == 0) {
      return StepState.editing;
    } else if (isStepOneActive() && currStep > 0) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  bool isStepTwoActive() {
    if ((RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text) &&
        phoneController.text != "")) {
      return true;
    }
    return false;
  }

  StepState stepTwoState() {
    if (!isStepTwoActive() && currStep > 1) {
      return StepState.error;
    } else if (currStep == 1) {
      return StepState.editing;
    } else if (isStepTwoActive() && currStep > 1) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  String? emailValidator(String? text) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return "Please Enter A Valid Email".tr;
    }
    return null;
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

  bool isStepThreeActive() {
    if (img != null) {
      return true;
    }
    return false;
  }

  StepState stepThreeState() {
    if (!isStepThreeActive() && currStep == 2) {
      return StepState.error;
    } else if (isStepThreeActive()) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  Future<void> openPrivacyPolicy() async {
    String myprivacyPolicyUrl = privacyPolicyUrl.replaceAll("https://", "");
    final urlPrivacyPolicyLaunchUrl =
        Uri(scheme: "https", path: myprivacyPolicyUrl);
    if (await canLaunchUrl(urlPrivacyPolicyLaunchUrl)) {
      launchUrl(urlPrivacyPolicyLaunchUrl);
    }
    update();
  }

  navigateToLogin() {
    Get.offAllNamed(
      AppRoute.login,
    );
  }
}
