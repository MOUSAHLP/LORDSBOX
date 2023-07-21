import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/edit_profile_controller.dart';
import 'package:lordsbox/view/widget/auth/my_input.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile".tr)),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height - Get.statusBarHeight - kToolbarHeight,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            margin: EdgeInsets.all(10),
                            child: MyInput(
                              hint: "UserName".tr,
                              mycontroller: controller.nameInputController,
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            margin: EdgeInsets.all(10),
                            child: MyInput(
                                hint: "Car Number".tr,
                                mycontroller:
                                    controller.carNumberInputController,
                                icon: Icons.car_repair),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            margin: EdgeInsets.all(10),
                            child: MyInput(
                              hint: "Email".tr,
                              mycontroller: controller.emailInputController,
                              icon: Icons.email,
                              validatorFun: controller.emailValidator,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            margin: EdgeInsets.all(10),
                            child: MyInput(
                              hint: "Phone".tr,
                              mycontroller: controller.phoneInputController,
                              icon: Icons.phone,
                              isText: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<EditProfileController>(
                      builder: (controller) => Expanded(
                        flex: 3,
                        child: controller.userModel == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: (() {
                                  controller.pickAnImage();
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    children: [
                                      controller.img == null
                                          ? Image.network(
                                              controller.userModel!.userImage!)
                                          : Image.file(controller.img!),
                                      Container(
                                        padding: EdgeInsets.all(7),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Get.theme.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.photo_camera_outlined,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<EditProfileController>(
                builder: (controller) => controller.progress == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.updateUserData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                              child: Text("Save".tr),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.deleteUser();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 2,
                              ),
                              child: Text("Delete".tr),
                            ),
                          ),
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
