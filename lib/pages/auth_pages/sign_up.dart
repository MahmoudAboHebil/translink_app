import 'package:flutter/material.dart';
import 'package:translink_app/pages/auth_pages/user_name.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  static const routeName = '/signUPPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _firstNameNode = FocusNode();
  final TextEditingController _fController = TextEditingController();
  final FocusNode _lastNameNode = FocusNode();
  final TextEditingController _lController = TextEditingController();
  bool isFHasFocus = false;
  bool isLHasFocus = false;
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    _firstNameNode.addListener(_onFocusChange);
    _lastNameNode.addListener(_onFocusChangeLast);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameNode.removeListener(_onFocusChange);
    _lastNameNode.removeListener(_onFocusChangeLast);
    _firstNameNode.dispose();
    _lastNameNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFHasFocus = _firstNameNode.hasFocus ? true : false;
    });
    if (_firstNameNode.hasFocus) {
      setState(() {
        isPressed = true;
      });
    }
  }

  void _onFocusChangeLast() {
    setState(() {
      isLHasFocus = _lastNameNode.hasFocus ? true : false;
    });
    if (_lastNameNode.hasFocus) {
      setState(() {
        isPressed = true;
      });
    }
  }

  String? _errorF;
  String? _errorL;
  String? _error(
      TextEditingController controller, bool isFirstName, bool isPressed) {
    String x = isFirstName ? 'First' : 'Last';
    if (controller.text.isEmpty && isPressed) {
      setState(() {
        if (isFirstName) {
          _errorF = 'This field is required';
        } else {
          _errorL = 'This field is required';
        }
      });
      return null;
    } else if (controller.text.length < 2 && isPressed) {
      setState(() {
        if (isFirstName) {
          _errorF = '$x name should be al least 2 characters';
        } else {
          _errorL = '$x name should be al least 2 characters';
        }
      });
      return null;
    } else {
      if (isFirstName) {
        setState(() {
          _errorF = null;
        });
      } else {
        setState(() {
          _errorL = null;
        });
      }
      return null;
    }
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
                      text: 'Sign Up',
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
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: AppLargeText(
                          text: 'Hey there! What\'s your name?',
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              size: 15,
                              text: 'First Name',
                              color: Colors.black.withOpacity(0.8),
                            ),
                            Container(
                              height: 50,
                              // color: isFHasFocus
                              //     ? _errorF != null
                              //         ? Colors.red.withOpacity(1)
                              //         : Colors.blueAccent.withOpacity(0.08)
                              //     : Colors.transparent,
                              child: TextFormField(
                                onChanged: (value) {
                                  _error(_fController, true, isPressed);
                                  setState(() {});
                                },
                                textAlign: TextAlign.right,
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlignVertical: (_errorF == null &&
                                        _fController.text.isNotEmpty)
                                    ? TextAlignVertical.center
                                    : null,
                                controller: _fController,
                                focusNode: _firstNameNode,
                                decoration: InputDecoration(
                                  prefixIcon: (_errorF == null &&
                                          _fController.text.isNotEmpty)
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : null,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  errorText:
                                      _error(_fController, true, isPressed),
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _errorF != null
                                              ? Colors.red.shade700
                                              : Colors.blue.shade700,
                                          width: 1)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1)),
                                  filled: isFHasFocus,
                                  fillColor: _errorF != null
                                      ? Colors.red.withOpacity(0.08)
                                      : Colors.blueAccent.withOpacity(0.08),
                                ),
                              ),
                            ),
                            _errorF != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: AppText(
                                      text: _errorF!,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              size: 15,
                              text: 'Last Name',
                              color: Colors.black.withOpacity(0.8),
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                onChanged: (value) {
                                  _error(_lController, false, isPressed);
                                  setState(() {});
                                },
                                textAlign: TextAlign.right,
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                controller: _lController,
                                focusNode: _lastNameNode,
                                textAlignVertical: (_errorL == null &&
                                        _lController.text.isNotEmpty)
                                    ? TextAlignVertical.center
                                    : null,
                                decoration: InputDecoration(
                                  prefixIcon: (_errorL == null &&
                                          _lController.text.isNotEmpty)
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : null,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  errorText:
                                      _error(_lController, false, isPressed),
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _errorL != null
                                              ? Colors.red.shade700
                                              : Colors.blue.shade700,
                                          width: 1)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1)),
                                  filled: isLHasFocus,
                                  fillColor: _errorL != null
                                      ? Colors.red.withOpacity(0.08)
                                      : Colors.blueAccent.withOpacity(0.08),
                                ),
                              ),
                            ),
                            _errorL != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: AppText(
                                      text: _errorL!,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Spacer(),
                      AppButton(
                        text: 'Continue',
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        circle: 20,
                        onPressed: () {
                          if (_fController.text.isNotEmpty &&
                              _lController.text.isNotEmpty &&
                              _errorL == null &&
                              _errorF == null) {
                            Navigator.pushNamed(
                                context, UserNamePage.routeName);
                          }
                        },
                        textColor: Colors.white,
                        backgroundColor: (_errorL == null &&
                                _errorF == null &&
                                _lController.text.isNotEmpty &&
                                _fController.text.isNotEmpty)
                            ? Color(0xff7d53f3)
                            : Colors.grey.withOpacity(0.3),
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
