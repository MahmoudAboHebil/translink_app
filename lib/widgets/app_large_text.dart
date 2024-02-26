import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  String text;
  double size;
  Color color;
  TextAlign align;
  AppLargeText(
      {required this.text,
      this.size = 30,
      this.color = Colors.black,
      this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style:
          TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size),
    );
  }
}
