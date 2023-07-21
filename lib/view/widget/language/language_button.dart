import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:lordsbox/core/localization/change_localization.dart';

class LanguageButton extends StatelessWidget {
  final String local;
  const LanguageButton({super.key, required this.local});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();
    return InkWell(
      onTap: () {
        localeController.changeLang(local);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: local == localeController.language.toString()
              ? Get.theme.accentColor.withAlpha(100)
              : null,
          border: Border.all(
            color: Get.theme.primaryColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            local == "en"
                ? Flag.fromCode(FlagsCode.US, height: 20, width: 20)
                : Flag.fromCode(FlagsCode.SY, height: 20, width: 20),
            SizedBox(
              width: 20,
            ),
            Text(
              local == "en" ? "English".tr : "Arabic".tr,
              style: Get.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
