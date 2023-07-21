import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Draweritem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() function;
  const Draweritem(
      {super.key,
      required this.function,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Get.theme.primaryColor,
                size: 35,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: Get.textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
