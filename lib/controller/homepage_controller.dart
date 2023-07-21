import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/classes/notification_listener.dart';
import 'package:lordsbox/core/functions/mysnackbar.dart';
import 'package:lordsbox/core/routes/routes.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      privacyDialog();
      awesomeNotificationStartListen();
    });
    super.onInit();
  }

  awesomeNotificationStartListen() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          (ReceivedNotification receivedNotification) async {
        NotificationController.onNotificationCreatedMethod(
            receivedNotification);
      },
      onNotificationDisplayedMethod:
          (ReceivedNotification receivedNotification) async {
        NotificationController.onNotificationDisplayedMethod(
            receivedNotification);
      },
      onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
        NotificationController.onDismissActionReceivedMethod(receivedAction);
      },
    );
  }

  void privacyDialog() {
    Get.defaultDialog(
        title: "",
        content: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Privacy Policy Agreement".tr + "\n",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This App Collects Location Data To Send The Current Location To The Admin Through The Server To Check That If The Delevaring Opration Is going Well Even When The App Is Closed Or Not In Use"
                    .tr,
                style: TextStyle(color: Colors.black, height: 2),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ));
  }

  bool ispermission = false;
  bool isAwesomeNotificationsPermission = false;
  void handlePermission() async {
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
        if (await AwesomeNotifications().isNotificationAllowed()) {
          isAwesomeNotificationsPermission = true;
        } else {
          isAwesomeNotificationsPermission = false;
        }
      } else {
        isAwesomeNotificationsPermission = true;
      }
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ispermission = false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ispermission = false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ispermission = false;
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      ispermission = true;
    }
  }

  navigateToUploadImage() async {
    if (await Geolocator.isLocationServiceEnabled() &&
        ispermission &&
        isAwesomeNotificationsPermission) {
      Get.toNamed(AppRoute.uploadImage,
          arguments: {"appbarText": "As A Start".tr});
    } else {
      if (!await Geolocator.isLocationServiceEnabled()) {
        mySnackBar(
          'The GPS Is Disabled'.tr,
          'Please Enable The GPS'.tr,
        );
      }
      handlePermission();
    }
  }
}
