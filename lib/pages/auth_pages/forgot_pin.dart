import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:translink_app/pages/auth_pages/verify_email.dart';

import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import 'components/auth_button.dart';

class ForgotPIN extends StatefulWidget {
  @override
  State<ForgotPIN> createState() => _ForgotPINState();
}

class _ForgotPINState extends State<ForgotPIN> {
  bool isPressed = false;
  bool isHasFocus = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    setState(() {
      isHasFocus = focusNode.hasFocus ? true : false;
      print('######################');
      print(isHasFocus);
    });
  }

  bool isValidEmail(bool isPress) {
    if (isPress) {
      return EmailValidator.validate(_emailController.text);
    }
    return true;
  }

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: isHasFocus ? 600 : null,
        padding: EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isHasFocus
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Forgot PIN Code',
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text:
                            'Enter your email for the verification process we will sent 6 digits code to your email',
                        size: 14,
                        align: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(
                  text: 'Email Address',
                  size: 14,
                  color: Colors.black.withOpacity(0.7),
                  align: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: _emailController,
                    focusNode: focusNode,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AuthButton(
                      isActive: _emailController.text.isNotEmpty,
                      text: 'Enter your email',
                      onPressed: () {
                        setState(() {
                          isPressed = true;
                        });
                        // if Email exists
                        if (isValidEmail(isPressed)) {
                          Navigator.pushNamed(
                              context, VerifyEmailPage.routeName,
                              arguments: _emailController.text);
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
