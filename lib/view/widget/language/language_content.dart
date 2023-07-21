import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/constant/constant.dart';
import 'package:lordsbox/core/localization/change_localization.dart';
import 'package:lordsbox/core/routes/routes.dart';
import 'package:lordsbox/core/services/storage_service.dart';
import 'package:lordsbox/view/widget/language/language_button.dart';

class LanguageContent extends StatelessWidget {
  const LanguageContent({super.key});

  @override
  Widget build(BuildContext context) {
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
          maxHeight: 250,
        ),
        child: GetBuilder<LocaleController>(
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LanguageButton(
                local: "en",
              ),
              LanguageButton(
                local: "ar",
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    MyServices myServices = Get.find();
                    myServices.sharedPreferences
                        .setBool(MyConstants.isLanguageKey, true);
                    Get.offAllNamed(AppRoute.signup);
                  },
                  child: Text(
                    "Continue".tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
