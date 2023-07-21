import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lordsbox/core/classes/multipart_request.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/core/functions/background_service.dart';
import 'package:lordsbox/core/functions/mysnackbar.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:http/http.dart' as http;
import 'package:lordsbox/core/services/storage_service.dart';

class UploadImageController extends GetxController {
  @override
  void onInit() {
    getConnectivity();
    connectivityStartListen();
    super.onInit();
  }

  getConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    isconnect = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.other;
    update();
  }

  bool isconnect = false;
  connectivityStartListen() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isconnect = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.other ||
          result == ConnectivityResult.mobile;
      update();
    });
  }

  File? img;
  double progress = 0;
  pickAnImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      img = File(photo.path);
      update();
    }
  }

  bool isbuttonPressed = false;
  uploadImage() async {
    if (!isbuttonPressed) {
      isbuttonPressed = true;
      if (Get.arguments["worksHour"] == null) {
        await uploadImageAM();
      } else {
        await uploadImagePM();
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

  handleError() {
    isbuttonPressed = false;
    progress = 0;
    mySnackBar("Error".tr, "Some Error Has occured".tr);
    update();
  }

  MyServices myServices = Get.find();
  String taskId = "";
  uploadImageAM() async {
    try {
      final request = MultipartRequest(
        'POST',
        Uri.parse(uploadImageUrlAM),
        onProgress: (int bytes, int total) {
          progress = bytes / total;
          print(progress);
          update();
        },
      );

      // get userModel
      String? userData = myServices.sharedPreferences.getString("userModel");
      UserModel userModel = UserModel.fromJson(json.decode(userData!));
      print(userModel.id);

      String date = dateFormat();
      request.files.add(
        await http.MultipartFile.fromPath('file', img!.path,
            filename: "${userModel.id}_AM_$date.png"),
      );

      print("${userModel.id}_AM_$date.png");

      // done
      await request.send().then((value) async {
        var responseString = await value.stream.bytesToString();
        var responseJson = json.decode(responseString);
        print(responseJson);
        if (responseJson["status"] == "success") {
          await myServices.sharedPreferences
              .setString(MyConstants.appStageKey, "map");

          progress = 0;
          img = null;
          isbuttonPressed = false;
          taskId = "${responseJson["data"]["id"]}";
          await myServices.sharedPreferences
              .setString(MyConstants.taskIdKey, taskId);

          update();

          await service.startService();

          Get.offAllNamed(
            AppRoute.mapPage,
          );
        }
      });
    } catch (e) {
      print(e);
      handleError();
    }
  }

  uploadImagePM() async {
    try {
      final request = MultipartRequest(
        'POST',
        Uri.parse(uploadImageUrlPM),
        onProgress: (int bytes, int total) {
          progress = bytes / total;
          print(progress);
          print("sfdwefd    ewf");
          update();
        },
      );

      taskId =
          await myServices.sharedPreferences.getString(MyConstants.taskIdKey) ??
              "0";
      print(taskId);
      print("taskId taskId taskId taskId taskId taskId ");
      request.fields["taskId"] = taskId;
      request.fields["worksHour"] = "${Get.arguments["worksHour"]}";

      // get userModel
      String? userData = myServices.sharedPreferences.getString("userModel");
      UserModel userModel = UserModel.fromJson(json.decode(userData!));
      print(userModel.id);
      print("userModel.id");
      String date = dateFormat();
      request.files.add(
        await http.MultipartFile.fromPath('file', img!.path,
            filename: "${userModel.id}_PM_$date.png"),
      );
      print("${userModel.id}_PM_$date.png");

      // done
      await request.send().then((value) async {
        var responseString = await value.stream.bytesToString();
        var responseJson = json.decode(responseString);
        print(responseJson);
        if (responseJson["status"] == "success") {
          await myServices.sharedPreferences
              .setString(MyConstants.appStageKey, "homePage");
          await updateIsOnlineRequst(userModel.id);
          progress = 0;
          isbuttonPressed = false;
          img = null;
          await myServices.sharedPreferences.remove(MyConstants.taskIdKey);
          update();
          mySnackBar(
              "success".tr,
              "You Have Successfuly Worked For ".tr +
                  "${Get.arguments["worksHour"]}");
          Get.offAllNamed(AppRoute.firstPage);
        }
      });
    } catch (e) {
      print(e);
      handleError();
    }
  }

  updateIsOnlineRequst(userId) async {
    try {
      var url = Uri.parse(isOnlineUrl);
      await http.post(url, body: {
        'userId': "$userId",
      });
    } catch (e) {
      print(e);
    }
  }
}
