import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/view/widget/homePage/my_drawer.dart';

class HomePagetitle extends StatelessWidget {
  const HomePagetitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Start Your Day".tr,
        style: TextStyle(
          color: Get.theme.primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
