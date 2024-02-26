import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final Function onPressed;
  final String? iconImage;
  AuthButton(
      {required this.text,
      this.isActive = false,
      required this.onPressed,
      this.iconImage});
  @override
  Widget build(BuildContext context) {
    return iconImage == null
        ? ElevatedButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStatePropertyAll(Colors.grey.withOpacity(0.5)),
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
              backgroundColor: MaterialStatePropertyAll(
                  isActive ? Colors.black : Colors.grey.withOpacity(0.5)),
              elevation: MaterialStatePropertyAll(0),
            ),
            onPressed: () {
              onPressed();
            },
            child: Text(
              text,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  fontSize: 15),
            ),
          )
        : ElevatedButton(
            style: ButtonStyle(
              side: MaterialStatePropertyAll(
                  BorderSide(color: Colors.grey.withOpacity(0.5))),
              overlayColor:
                  MaterialStatePropertyAll(Colors.grey.withOpacity(0.5)),
              padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.grey.withOpacity(0.1)),
              elevation: MaterialStatePropertyAll(0),
            ),
            onPressed: () {
              onPressed();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(iconImage!), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          );
  }
}
