import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

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
            "Wellcome Back".tr,
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
