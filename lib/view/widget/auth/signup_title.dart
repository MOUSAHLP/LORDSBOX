import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupTitle extends StatelessWidget {
  const SignupTitle({super.key});

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
            "Create A New Account".tr,
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
