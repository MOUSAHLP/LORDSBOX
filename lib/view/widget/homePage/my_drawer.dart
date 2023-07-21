import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/drawer_controller.dart';
import 'package:lordsbox/view/widget/homePage/drawer_item.dart';
import 'package:lordsbox/core/routes/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyDrawerController());
    return Column(
      children: [
        GetBuilder<MyDrawerController>(
          builder: (controller) => Container(
            width: double.infinity,
            height: 200,
            color: Get.theme.primaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                controller.userModel == null
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            controller.userModel!.userImage!,
                          ),
                        ),
                      ),
                controller.userModel == null
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${controller.userModel!.name}",
                          style: Get.textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Draweritem(
          title: "Edit Profile".tr,
          icon: Icons.settings,
          function: () {
            Get.toNamed(AppRoute.editProfile)!.then((value) {
              controller.initializeUserModel();
            });
          },
        ),
        ExpansionTile(
          // backgroundColor: Get.theme.accentColor.withAlpha(100),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.all(10),
          title: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.language,
                  color: Get.theme.primaryColor,
                  size: 35,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Change Language".tr,
                  style: Get.textTheme.bodyText1,
                ),
              ],
            ),
          ),
          children: [
            InkWell(
              onTap: () {
                controller.ChangeLocalDrawer("en");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Flag.fromCode(
                      FlagsCode.US,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "English".tr,
                      style: Get.textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.ChangeLocalDrawer("ar");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Flag.fromCode(
                      FlagsCode.SY,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Arabic".tr,
                      style: Get.textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Draweritem(
          title: "Log Out".tr,
          icon: Icons.logout,
          function: () async {
            await controller.logout();
          },
        ),
      ],
    );
  }
}
