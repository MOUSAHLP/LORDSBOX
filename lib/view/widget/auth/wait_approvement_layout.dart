import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/signup_controller.dart';

class WaitApprovementLayout extends StatelessWidget {
  const WaitApprovementLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "You Have Successfully Signed Up".tr,
            style: TextStyle(
              color: Get.theme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Now You Have To Wait For Admin Approvement".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          "You Have To Contact With Admin to get Your Id".tr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              controller.navigateToLogin();
            },
            child: Text(
              "Login".tr,
            ),
          ),
        ),
      ],
    );
  }
}
