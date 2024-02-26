import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/app_text.dart';
import 'forgot_pin.dart';

class EnterPINPage extends StatefulWidget {
  EnterPINPage({required this.email, super.key});
  final String email;
  static const routeName = '/EnterPINPage';

  @override
  State<EnterPINPage> createState() => _EnterPINPageState();
}

class _EnterPINPageState extends State<EnterPINPage> {
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  bool showWidget = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(0),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff4b00b8),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
          )
        ],
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
            Column(
              children: [
                AppText(
                  text: 'Enter PIN Code',
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                showWidget
                    ? hasError
                        ? AppText(
                            text: 'Invalid PIN',
                            color: Colors.red,
                            size: 14,
                            align: TextAlign.end,
                          )
                        : Container(
                            height: 18,
                          )
                    : Center(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                SizedBox(
                  height: 60,
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
                          inactiveColor: hasError
                              ? Colors.red
                              : Colors.black.withOpacity(0.4),
                          inactiveFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          selectedColor: hasError ? Colors.red : Colors.black87,
                          activeColor: hasError
                              ? Colors.red
                              : Colors.black.withOpacity(0.4),
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
                      textStyle: TextStyle(
                          color: hasError ? Colors.red : Colors.black),
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        setState(() {
                          showWidget = false;
                        });
                        Future.delayed(Duration(seconds: 1), () {
                          if (currentText != '1234') {
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            setState(() {
                              hasError = false;
                            });
                          }
                          setState(() {
                            showWidget = true;
                          });
                        });
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
            SizedBox(
              height: 80,
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ForgotPIN(),
                );
              },
              child: Text(
                'Forgot PIN?',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
