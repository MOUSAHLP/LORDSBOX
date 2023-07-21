import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/classes/notification_listener.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

final service = FlutterBackgroundService();

String res = "";
sendRequest(userId, latitude, longitude) async {
  try {
    var url = Uri.parse(uploadPositionUrl);
    print("============================================");
    print(userId);
    print(latitude);
    print(longitude);
    print("============================================");

    var response = await http.post(url, body: {
      'userId': userId,
      'latitude': "$latitude",
      'longitude': "$longitude"
    });
    res = response.body;
    print(res);
  } catch (e) {
    print(e);
  }
}

initialAwesomeNotification() async {
  AwesomeNotifications().initialize(
    "resource://drawable/logo",
    [
      NotificationChannel(
        channelGroupKey: 'my_foreground',
        channelKey: 'my_foreground',
        channelName: 'LORDSBOX',
        channelDescription: 'Notification For Counting Work Hours',
        defaultColor: const Color(0xff585be6),
        ledColor: Colors.black,
        playSound: false,
        locked: true,
        channelShowBadge: false,
        enableVibration: false,
      ),
      NotificationChannel(
        channelGroupKey: 'my_foreground',
        channelKey: 'Notify',
        channelName: 'LORDSBOX',
        channelDescription: 'Notification For Notifying The User',
        defaultColor: Colors.transparent,
        ledColor: Colors.black,
        playSound: true,
        locked: false,
      ),
    ],
  );
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        (ReceivedNotification receivedNotification) async {
      NotificationController.onNotificationCreatedMethod(receivedNotification);
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

Future<void> initializeService() async {
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: serviceStart,
      autoStart: false,
      isForegroundMode: true,
      autoStartOnBoot: false,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Service Start',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 880,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: serviceStart,
    ),
  );
}

@pragma('vm:entry-point')
void serviceStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  int work = 0;
  bool isError = true;
  String title = '${Emojis.symbols_check_mark} ' + 'Online'.tr;
  Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    final connectivityResult = await (Connectivity().checkConnectivity());

    if ((checkPermission == LocationPermission.whileInUse ||
            checkPermission == LocationPermission.always) &&
        await Geolocator.isLocationServiceEnabled() &&
        (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.other)) {
      work++;

      title = '${Emojis.symbols_check_mark} ' + 'Online'.tr;

      isError = true;

      doInBackground(service, work);
    } else {
      title = "${Emojis.symbols_cross_mark} " + "Offline".tr;

      if (!await Geolocator.isLocationServiceEnabled()) {
        if (isError) {
          isError = false;

          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 888,
              channelKey: 'Notify',
              title: 'The GPS Is Disabled'.tr,
              body: 'Please Enable The GPS'.tr,
              actionType: ActionType.KeepOnTop,
              backgroundColor: Get.theme.primaryColor,
              color: Colors.blue,
            ),
          );
        }
      } else {
        if (isError) {
          isError = false;

          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 889,
              channelKey: 'Notify',
              title: 'No Internet Connection'.tr,
              body: 'Please Connect to Internet'.tr,
              actionType: ActionType.KeepOnTop,
              backgroundColor: Get.theme.primaryColor,
              color: Colors.blue,
            ),
          );
        }
      }
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 880,
        channelKey: 'my_foreground',
        title: title,
        body: 'You Worked For '.tr + '${counterFormat(work)}',
        actionType: ActionType.KeepOnTop,
        backgroundColor: Get.theme.primaryColor,
        color: Colors.blue,
        locked: true,
      ),
    );
  });
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

void doInBackground(ServiceInstance service, int seconds) async {
  Position? currPosition = await getUserCurrentPosition();
  if (currPosition != null) {
    if (seconds % 10 == 0) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? userData = sharedPreferences.getString("userModel");
      UserModel userModel = UserModel.fromJson(json.decode(userData!));
      await sendRequest(
          "${userModel.id}", currPosition.latitude, currPosition.longitude);
    }

    print("invoke on ");
    service.invoke(
      'update',
      {
        "seconds": seconds,
        "latitude": currPosition.latitude,
        "longitude": currPosition.longitude,
      },
    );
  }
}

Future<Position?> getUserCurrentPosition() async {
  try {
    Position currpos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currpos;
  } catch (e) {
    print(e);
    return null;
  }
}
