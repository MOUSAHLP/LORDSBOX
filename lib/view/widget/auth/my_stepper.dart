import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/signup_controller.dart';
import 'package:lordsbox/view/widget/auth/my_input.dart';

class MyStepper extends StatelessWidget {
  const MyStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    return Stepper(
      currentStep: controller.currStep,
      onStepCancel: controller.onStepCancel,
      onStepContinue: controller.onStepContinue,
      onStepTapped: controller.onStepTapped,
      steps: [
        Step(
          title: Text("Personal Details".tr),
          isActive: true,
          state: controller.stepOneState(),
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              MyInput(
                hint: "UserName".tr,
                icon: Icons.person_outline_rounded,
                mycontroller: controller.userNameController,
                function: (text) {},
              ),
              const SizedBox(
                height: 10,
              ),
              MyInput(
                hint: "Car Number".tr,
                icon: Icons.car_repair,
                mycontroller: controller.carNumberController,
                function: (text) {},
              ),
            ],
          ),
        ),
        Step(
          title: Text("Contact Details".tr),
          state: controller.stepTwoState(),
          isActive: true,
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              MyInput(
                hint: "Email".tr,
                icon: Icons.email_outlined,
                mycontroller: controller.emailController,
                function: (text) {},
                validatorFun: controller.emailValidator,
              ),
              const SizedBox(
                height: 10,
              ),
              MyInput(
                hint: "Phone".tr,
                icon: Icons.phone,
                isText: false,
                mycontroller: controller.phoneController,
                function: (text) {},
              ),
            ],
          ),
        ),
        Step(
            title: Text("Personal Image".tr),
            state: controller.stepThreeState(),
            isActive: true,
            content: Column(
              children: [
                controller.img == null
                    ? GestureDetector(
                        onTap: () {
                          controller.pickAnImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Get.theme.accentColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Personal Image".tr,
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 60,
                                color: Get.theme.primaryColor,
                              )
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.pickAnImage();
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          clipBehavior: Clip.none,
                          children: [
                            Image.file(
                              controller.img!,
                            ),
                            Positioned(
                              bottom: -15,
                              right: -15,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Get.theme.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                TextButton(
                    onPressed: controller.openPrivacyPolicy,
                    child: Text(
                      "By Creating An Account You Accept Our Privacy Policy".tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    )),
              ],
            )),
      ],
      controlsBuilder: (context, controls) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: controller.progress != 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: LinearProgressIndicator(
                        value: controller.progress,
                        color: Get.theme.primaryColor,
                        backgroundColor: Get.theme.accentColor.withAlpha(100),
                      ),
                    ),
                    Text(
                      "Uploading".tr +
                          " ${(controller.progress * 100).toStringAsFixed(0)} %",
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.onStepContinue,
                        child: controller.currStep != 2
                            ? Text("Continue".tr)
                            : Text("SignUp".tr),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (controller.currStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.onStepCancel,
                          child: Text("Back".tr),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
