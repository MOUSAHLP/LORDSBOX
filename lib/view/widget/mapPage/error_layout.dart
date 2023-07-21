import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  final String errorMessage;
  const ErrorLayout({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 250,
        height: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.9),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
