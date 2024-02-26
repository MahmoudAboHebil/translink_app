import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {required this.text,
      required this.circle,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.margin,
      super.key});
  final String text;
  final EdgeInsets margin;
  final double circle;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin,
      child: ElevatedButton(
        // color: Color(0xff7d53f3),
        style: ButtonStyle(
            // elevation: MaterialStatePropertyAll(10),
            // shadowColor: MaterialStatePropertyAll(Color(0xff7d53f3)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circle),
            )),
            padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        onPressed: () {
          onPressed();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
