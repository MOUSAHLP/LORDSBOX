import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/login_controller.dart';
import 'package:lordsbox/view/widget/auth/login_content.dart';
import 'package:lordsbox/view/widget/auth/login_title.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogInController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login".tr,
            style: TextStyle(
              fontSize: 22,
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.navigateToSignUp();
              },
              child: Text("Or SignUp".tr),
            )
          ],
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: GetBuilder<LogInController>(
          builder: (controller) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                LoginTitle(),
                LoginContent(),
              ],
            );
          },
        ),
      ),
    );
  }
}
