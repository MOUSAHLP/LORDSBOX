import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/upload_image_controller.dart';

class UploadImageProccess extends StatelessWidget {
  const UploadImageProccess({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadImageController>();

    return Column(
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
              "${(controller.progress * 100).toStringAsFixed(0)} %",
        ),
      ],
    );
  }
}
