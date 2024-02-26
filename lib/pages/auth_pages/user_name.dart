import 'package:flutter/material.dart';
import 'package:translink_app/pages/auth_pages/create_pin.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});
  static const routeName = '/userNamePage';

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final FocusNode _userNameNode = FocusNode();
  final TextEditingController _userController = TextEditingController();
  bool isUHasFocus = false;
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    _userNameNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _userNameNode.removeListener(_onFocusChange);
    _userNameNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isUHasFocus = _userNameNode.hasFocus ? true : false;
    });
    if (_userNameNode.hasFocus) {
      setState(() {
        isPressed = true;
      });
    }
  }

  String? _errorN;

  String? _error(TextEditingController controller, bool isPressed) {
    final alphanumeric = RegExp(r'^[a-z][a-z0-9]{4,18}$');

    if (controller.text.isEmpty && isPressed) {
      setState(() {
        _errorN = 'This field is required';
      });
      return null;
    } else if (!alphanumeric.hasMatch(_userController.text) && isPressed) {
      setState(() {
        _errorN =
            'Username cannot contain:\n-Special characters(!@#)\n-Capital letters\n-Arabic letters\n-Spaces\n-And must be less than 20 characters\n-And must be at least characters\n-And must start with a letter not a number.';
      });
      return null;
    } else {
      setState(() {
        _errorN = null;
      });
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
                          text: 'What do you want to be called on TransLink?',
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
                              text: 'Username',
                              color: Colors.black.withOpacity(0.8),
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                onChanged: (value) {
                                  _error(_userController, isPressed);
                                  setState(() {});
                                },
                                textAlign: TextAlign.right,
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlignVertical: (_errorN == null &&
                                        _userController.text.isNotEmpty)
                                    ? TextAlignVertical.center
                                    : null,
                                controller: _userController,
                                focusNode: _userNameNode,
                                decoration: InputDecoration(
                                  prefixIcon: (_errorN == null &&
                                          _userController.text.isNotEmpty)
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : null,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  errorText: _error(_userController, isPressed),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _errorN != null
                                              ? Colors.red.shade700
                                              : Colors.blue.shade700,
                                          width: 1)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1)),
                                  filled: isUHasFocus,
                                  fillColor: _errorN != null
                                      ? Colors.red.withOpacity(0.08)
                                      : Colors.blueAccent.withOpacity(0.08),
                                ),
                              ),
                            ),
                            _errorN != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: AppText(
                                      text: _errorN!,
                                      color: Colors.red,
                                      size: 12,
                                      align: TextAlign.end,
                                    ),
                                  )
                                : _userController.text.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: AppText(
                                          text: 'Username available',
                                          color: Colors.green,
                                          size: 12,
                                        ),
                                      )
                                    : Container()
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
                          if (_userController.text.isNotEmpty &&
                              _errorN == null) {
                            Navigator.pushNamed(context, CreatePIN.routeName);
                          }
                        },
                        textColor: Colors.white,
                        backgroundColor:
                            (_errorN == null && _userController.text.isNotEmpty)
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
