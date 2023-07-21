import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/upload_image_controller.dart';
import 'package:lordsbox/view/widget/uploadImage/row_text_color.dart';

class ImageLayout extends StatelessWidget {
  const ImageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadImageController>();
    return Column(
      children: [
        Expanded(
          child: Image.file(
            controller.img!,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RowTextColor(
            text: "Make Sure The Photo Is".tr,
            colorizedText: "Good".tr,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
