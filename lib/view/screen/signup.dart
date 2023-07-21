import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/signup_controller.dart';
import 'package:lordsbox/view/widget/auth/signup_content.dart';
import 'package:lordsbox/view/widget/auth/signup_title.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SignUp".tr,
            style: TextStyle(
              fontSize: 22,
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  controller.navigateToLogin();
                },
                child: Text("Or LogIn".tr))
          ],
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: GetBuilder<SignUpController>(
          builder: (controller) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SignupTitle(),
                SignupContent(),
              ],
            );
          },
        ),
      ),
    );
  }
}
