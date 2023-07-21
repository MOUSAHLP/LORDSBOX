import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInput extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final bool isText;
  final IconData icon;
  final Function(String)? function;
  final String? Function(String?)? validatorFun;

  const MyInput({
    super.key,
    required this.hint,
    required this.mycontroller,
    this.isText = true,
    this.function,
    required this.icon,
    this.validatorFun,
  });

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return TextFormField(
      validator: validatorFun,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: mycontroller,
      onChanged: function,
      // enableIMEPersonalizedLearning: true,
      style: TextStyle(color: Get.theme.primaryColor),
      cursorColor: Get.theme.primaryColor,
      textAlign: TextAlign.end,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        focus.nextFocus();
      },
      textDirection: TextDirection.rtl,
      keyboardType: isText ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        hintStyle: Get.theme.textTheme.bodyText1!
            // ignore: deprecated_member_use
            .copyWith(fontSize: 12, color: Get.theme.accentColor),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: Get.theme.textTheme.bodyText1!
            .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
        label: Text(
          hint,
        ),
        hintTextDirection: TextDirection.ltr,
        prefixIcon: Icon(
          icon,
          color: Get.theme.primaryColor,
        ),
        prefixIconColor: Get.theme.primaryColor,
        fillColor: Get.theme.backgroundColor,
        filled: true,
      ),
    );
  }
}
