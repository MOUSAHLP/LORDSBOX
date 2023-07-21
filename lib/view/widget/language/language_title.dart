import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageTitle extends StatelessWidget {
  const LanguageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Get.theme.primaryColor,
        width: double.infinity,
        height: Get.height * .3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Any Language Do You Want To Continue With".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
