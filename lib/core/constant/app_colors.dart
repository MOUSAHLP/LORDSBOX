import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static Color primaryColorlight = const Color(0xff585be6);
  static Color primaryColordark = const Color(0xff585be6);
  static Color get primaryColor =>
      Get.isDarkMode ? primaryColordark : primaryColorlight;

  static Color secondaryColorlight = const Color(0xff7677f5);
  static Color secondaryColordark = const Color(0xff7677f5);

  static Color get secondaryColor =>
      Get.isDarkMode ? secondaryColordark : secondaryColorlight;

  static Color textColorLight = Colors.black;
  static Color textColorDark = Colors.white;
  static Color get textColor => Get.isDarkMode ? textColorDark : textColorLight;

  static Color backgroundLight = Colors.white;
  static Color backgroundDark = const Color(0xff202f36);
  static Color get background =>
      Get.isDarkMode ? backgroundDark : backgroundLight;

  static Color backgroundScaffoldLight = const Color(0xfff8fbfe);
  static Color backgroundScaffoldDark = const Color(0xff141f23);
  static Color get backgroundScaffold =>
      Get.isDarkMode ? backgroundDark : backgroundLight;
}
