import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/app_text.dart';
import 'confirm_pin.dart';

class CreatePIN extends StatefulWidget {
  const CreatePIN({super.key});
  static const routeName = '/CreatePINPage';

  @override
  State<CreatePIN> createState() => _CreatePINState();
}

class _CreatePINState extends State<CreatePIN> {
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
              text: 'Set PIN code',
              color: Colors.black,
              size: 20,
            ),
            SizedBox(
              height: 20,
            ),
            hasError
                ? AppText(
                    text: 'This code is easy to guess! Try again.',
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
                  enableActiveFill: true,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
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
                    for (int i = 0; i <= 9; i++) {
                      if (currentText == '$i$i$i$i') {
                        setState(() {
                          hasError = true;
                        });
                        break;
                      }
                      if (i == 9) {
                        setState(() {
                          hasError = false;
                        });
                      }
                    }
                    if (!hasError) {
                      Navigator.pushNamed(context, ConfirmPIN.routeName,
                          arguments: currentText);
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
