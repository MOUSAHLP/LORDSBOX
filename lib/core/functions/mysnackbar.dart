import 'package:flutter/material.dart';
import 'package:get/get.dart';

mySnackBar(title, message, {IconData? icon}) {
  if (!Get.isSnackbarOpen) {
    Get.snackbar(title, message,
        backgroundColor: Get.theme.primaryColor,
        margin: EdgeInsets.zero,
        borderRadius: 0,
        isDismissible: true,
        icon: Icon(
          icon,
          color: Get.theme.backgroundColor,
          size: 30,
        ),
        duration: const Duration(seconds: 2),
        colorText: Get.theme.backgroundColor,
        snackPosition: SnackPosition.BOTTOM);
  }
}
