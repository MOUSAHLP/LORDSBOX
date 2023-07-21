import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/signup_controller.dart';
import 'package:lordsbox/view/widget/auth/wait_approvement_layout.dart';
import 'package:lordsbox/view/widget/auth/my_stepper.dart';

class SignupContent extends StatelessWidget {
  const SignupContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1,
              color: Colors.grey,
            )
          ],
        ),
        constraints: BoxConstraints(
          minHeight: 300,
          minWidth: double.infinity,
          maxHeight: controller.isSignedUp ? 300 : 450,
        ),
        child:
            controller.isSignedUp ? const WaitApprovementLayout() : MyStepper(),
      ),
    );
  }
}
