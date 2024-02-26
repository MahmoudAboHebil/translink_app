import 'package:flutter/material.dart';

class BoxTitleAnimation extends StatelessWidget {
  String title;
  bool value;
  Function onTap;
  BoxTitleAnimation(
      {required this.title, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: value ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
