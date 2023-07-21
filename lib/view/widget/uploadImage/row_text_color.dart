import 'package:flutter/material.dart';

class RowTextColor extends StatelessWidget {
  final String text;
  final String colorizedText;
  final Color color;
  const RowTextColor({
    super.key,
    required this.text,
    required this.colorizedText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: "$text ",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        children: <InlineSpan>[
          TextSpan(
            text: colorizedText,
            style: TextStyle(
                fontSize: 20, color: color, fontWeight: FontWeight.bold),
          )
        ]));
  }
}
