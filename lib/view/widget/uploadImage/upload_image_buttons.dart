import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/upload_image_controller.dart';

class UploadImageButtons extends StatelessWidget {
  const UploadImageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadImageController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                controller.pickAnImage();
              },
              child: Text(
                "Retry".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                controller.isbuttonPressed = false;
                print("${controller.isbuttonPressed}");

                await controller.uploadImage();
              },
              child: Text(
                "Continue".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
