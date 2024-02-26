import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:translink_app/pages/auth_pages/sign_up.dart';

import '../../widgets/app_text.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;
  const VerifyEmailPage({super.key, required this.email});
  static const routeName = '/verifyEmailPage';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  // ..text = "123456";

  // ignore: close_sinks

  bool hasError = false;
  bool showSpinner = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  late Timer _timer;
  int _start = 25;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    setState(() {
      _start = 25;
    });
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2e0073),
          Color(0xff4b00b8),
        ])),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppText(
                      text: 'Verify your email',
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.white,
                      size: 22,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'We have sent a code to your email',
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      AppText(
                        text: 'A 6-digit code has been sent to:${widget.email}',
                        color: Colors.black.withOpacity(0.6),
                        size: 14,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: formKey,
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
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
                              selectedColor:
                                  hasError ? Colors.red : Colors.black87,
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
                          enableActiveFill: true,
                          autoFocus: true,
                          keyboardType: TextInputType.number,
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
                            debugPrint("Completed");
                            setState(() {
                              showSpinner = true;
                            });
                            // if Email exists
                            if (currentText != '123456') {
                              setState(() {
                                showSpinner = true;
                                hasError = false;
                              });
                              Future.delayed(Duration(milliseconds: 200), () {
                                setState(() {
                                  hasError = true;
                                  showSpinner = false;
                                });
                              });
                            } else {
                              setState(() {
                                hasError = false;
                                showSpinner = false;
                              });
                              Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                            }
                            // if Email exists
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
                      SizedBox(
                        height: 5,
                      ),
                      hasError
                          ? AppText(
                              text: 'Wrong code.Please try again',
                              color: Colors.red,
                              size: 12,
                              align: TextAlign.center,
                            )
                          : showSpinner
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Container(),
                      SizedBox(
                        height: 15,
                      ),
                      (_start == 0)
                          ? TextButton(
                              onPressed: () {
                                startTimer();
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.grey.shade100),
                              ),
                              child: Text(
                                'Resend code',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff4b00b8),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: 'Resend code ',
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      AppText(
                                        text: '(',
                                        color: Colors.grey,
                                      ),
                                      AppText(
                                        text: '$_start',
                                        color: Color(0xff4b00b8),
                                      ),
                                      AppText(
                                        text: ')',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
