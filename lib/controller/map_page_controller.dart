import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/functions/background_service.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';
import 'package:latlong2/latlong.dart';

class MapPageController extends GetxController {
  MyServices myServices = Get.find();

  @override
  void onInit() {
    startStream();
    getConnectivity();
    connectivityStartListen();
    gpsDisable();
    super.onInit();
  }

  @override
  void onClose() {
    service.invoke("stopService");
    super.onClose();
  }

  getConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    isconnect.value = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.other;
  }

  RxBool isconnect = false.obs;
  connectivityStartListen() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isconnect.value = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.other ||
          result == ConnectivityResult.mobile;
    });
  }

  RxBool isGPSdisable = false.obs;
  gpsDisable() async {
    isGPSdisable.value = !await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.disabled) {
        print("GPS DisAbled");
        isGPSdisable.value = true;
      } else {
        isGPSdisable.value = false;
      }
    });
  }

  String errorMessagge() {
    if (!isconnect.value) {
      return "You dont have Internet Connection\nSo The Counter Wont Count \nPlease Connect To The Internet"
          .tr;
    } else if (isGPSdisable.value) {
      return "The GPS Is Disabled \nSo The Counter Wont Count \nPlease Enable The GPS"
          .tr;
    }
    return "Error Occured".tr;
  }

  String counterFormat(int counter) {
    Duration duration = Duration(seconds: counter);
    int hours = duration.inHours;
    int minutes = duration.inMinutes;
    minutes = minutes % 60;
    int seconds = counter % 60;

    String hoursString = '$hours'.padLeft(2, '0');
    String minutesString = '$minutes'.padLeft(2, '0');
    String secondsString = '$seconds'.padLeft(2, '0');

    return '$hoursString:$minutesString:$secondsString';
  }

  MapController mapController = MapController();
  int worksHour = 0;
  RxMap posStream = {}.obs;
  startStream() {
    try {
      service.on('update').listen((event) {
        if (event != null) {
          posStream.value = event;
          worksHour = event["seconds"];

          try {
            mapController.move(
                LatLng(
                  event["latitude"],
                  event["longitude"],
                ),
                18);
            print("${event["latitude"]}");
          } catch (e) {
            print(e);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopTheService() async {
    Get.defaultDialog(
        title: "Are You Sure ??".tr,
        titleStyle: TextStyle(color: Colors.black),
        content: Center(
            child: Text(
          "Are You Sure You Want To Finish Today`s Work ??".tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (await service.isRunning()) {
                          service.invoke("stopService");
                          navigateToUploadImage();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Confirm".tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ]);
  }

  navigateToUploadImage() {
    Future.delayed(
      Duration(
        milliseconds: 100,
      ),
      () async {
        await myServices.sharedPreferences
            .setInt(MyConstants.counterCachedKey, worksHour);
        await myServices.sharedPreferences
            .setString(MyConstants.appStageKey, "PM");
        Get.offAllNamed(
          AppRoute.uploadImage,
          arguments: {
            "appbarText": "Before You Go".tr,
            "worksHour": counterFormat(worksHour)
          },
        );
      },
    );
  }
}
