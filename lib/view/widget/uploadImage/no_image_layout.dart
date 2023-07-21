import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/upload_image_controller.dart';

class NoImageLayout extends StatelessWidget {
  const NoImageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadImageController>();

    return GestureDetector(
      onTap: () {
        controller.pickAnImage();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.accentColor.withAlpha(100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Upload Image".tr,
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
    );
  }
}
