import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/view/widget/uploadImage/row_text_color.dart';

class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 140,
            color: Get.theme.primaryColor,
          ),
          SizedBox(
            height: 40,
          ),
          RowTextColor(
            text: "You Are",
            colorizedText: "Offline",
            color: Get.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
