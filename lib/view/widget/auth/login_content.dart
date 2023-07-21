import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/login_controller.dart';
import 'package:lordsbox/view/widget/auth/my_input.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogInController>();

    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(20),
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
        constraints: const BoxConstraints(
          minHeight: 200,
          minWidth: double.infinity,
          maxHeight: 300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Enter Your Id".tr,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyInput(
                hint: "id",
                mycontroller: controller.idController,
                icon: Icons.person,
                validatorFun: controller.validator,
              ),
            ),
            const Spacer(),
            controller.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: Text(
                        "Login".tr,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
