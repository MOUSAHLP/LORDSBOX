import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterWorkedFor extends StatelessWidget {
  final String counterFormat;
  const CounterWorkedFor({super.key, required this.counterFormat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "You Worked For ".tr,
              style: TextStyle(
                color: Get.theme.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              counterFormat,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
