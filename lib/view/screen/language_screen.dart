import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/view/widget/language/language_content.dart';
import 'package:lordsbox/view/widget/language/language_title.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Choose Language".tr,
            style: TextStyle(
              fontSize: 22,
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            LanguageTitle(),
            LanguageContent(),
          ],
        ),
      ),
    );
  }
}
