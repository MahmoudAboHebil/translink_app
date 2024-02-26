import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String text;
  double size;
  Color color;
  TextAlign align;
  AppText(
      {required this.text,
      this.size = 16,
      this.color = Colors.black54,
      this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: align,
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
