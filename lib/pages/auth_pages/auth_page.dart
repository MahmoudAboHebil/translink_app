import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import 'components/auth_button.dart';
import 'enter_pin.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
  static const String routeName = '/authPage';
}

class _AuthPageState extends State<AuthPage> {
  bool isPressed = false;
  bool isValidEmail(bool isPress) {
    if (isPress) {
      return EmailValidator.validate(_emailController.text);
    }
    return true;
  }

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff4b00b8), Colors.grey.shade300])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height / 2.3,
                width: double.maxFinite,
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 50, right: 10),
                  height: 250,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/welcome_images/welcome1.png'),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: AppLargeText(
                      text: 'English',
                      size: 18,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: size.height - (size.height / 2.3),
                  width: double.maxFinite,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: AppLargeText(
                          text: 'Get Started With TransLink',
                          color: Colors.black.withOpacity(0.8),
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppLargeText(
                            text: 'Email Address',
                            size: 14,
                            color: Colors.black.withOpacity(0.7),
                            align: TextAlign.end,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: 'Enter your email address',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: !isValidEmail(isPressed)
                                              ? Colors.red
                                              : Colors.grey))),
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                          ),
                          !isValidEmail(isPressed)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    AppText(
                                      text: 'Invalid email address',
                                      color: Colors.red,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 50,
                                ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AuthButton(
                                    isActive: _emailController.text.isNotEmpty,
                                    text: 'Continue With Email',
                                    onPressed: () {
                                      setState(() {
                                        isPressed = true;
                                      });
                                      // if (isValidEmail(isPressed)) {
                                      //   Navigator.pushNamed(
                                      //       context, VerifyEmailPage.routeName,
                                      //       arguments: _emailController.text);
                                      // }
                                      if (isValidEmail(isPressed)) {
                                        Navigator.pushNamed(
                                            context, EnterPINPage.routeName,
                                            arguments: _emailController.text);
                                      }
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: AppText(
                              text: 'Or continue with',
                              color: Colors.black.withOpacity(0.7),
                              size: 14,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AuthButton(
                                    iconImage:
                                        'assets/images/google-symbol.png',
                                    text: 'Continue With Google',
                                    onPressed: () {}),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppLargeText(
                                text: 'By continuing you agree to our',
                                size: 13,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              AppLargeText(
                                text: 'terms & conditions',
                                size: 13,
                                color: Colors.blue.shade700,
                              ),
                            ],
                          )
                        ],
                      )
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
