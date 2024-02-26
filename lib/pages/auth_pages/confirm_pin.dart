import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';

class ConfirmPIN extends StatefulWidget {
  ConfirmPIN({required this.pinCode, super.key});
  final String pinCode;
  static const routeName = '/confirmPINPage';

  @override
  State<ConfirmPIN> createState() => _ConfirmPINState();
}

class _ConfirmPINState extends State<ConfirmPIN> {
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: 'Confirm PIN Code',
              color: Colors.black,
              size: 20,
            ),
            SizedBox(
              height: 5,
            ),
            AppText(
              text: 'Re-enter your code for confirmation',
              size: 14,
              align: TextAlign.end,
            ),
            SizedBox(
              height: 20,
            ),
            hasError
                ? AppText(
                    text: 'PIN doesn\'t match',
                    color: Colors.red,
                    size: 14,
                    align: TextAlign.end,
                  )
                : Container(
                    height: 18,
                  ),
            SizedBox(
              height: 80,
            ),
            Form(
              key: formKey,
              child: Container(
                width: 250,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      fieldOuterPadding: EdgeInsets.all(5),
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 55,
                      fieldWidth: 50,
                      inactiveColor:
                          hasError ? Colors.red : Colors.black.withOpacity(0.4),
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      selectedColor: hasError ? Colors.red : Colors.black87,
                      activeColor:
                          hasError ? Colors.red : Colors.black.withOpacity(0.4),
                      inactiveBorderWidth: 1,
                      activeBorderWidth: 1,
                      disabledBorderWidth: 1,
                      selectedBorderWidth: 2,
                      borderWidth: 1,
                      selectedFillColor: Colors.white),
                  cursorColor: Color(0xff2e0073),
                  animationDuration: const Duration(milliseconds: 300),
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  autoDismissKeyboard: false,
                  textStyle:
                      TextStyle(color: hasError ? Colors.red : Colors.black),
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                    if (currentText != widget.pinCode) {
                      setState(() {
                        hasError = true;
                      });
                    } else {
                      setState(() {
                        hasError = false;
                      });
                    }
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                      hasError = false;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
