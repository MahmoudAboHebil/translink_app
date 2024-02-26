import 'package:flutter/material.dart';

import '../pages/auth_pages/auth_page.dart';
import '../pages/auth_pages/confirm_pin.dart';
import '../pages/auth_pages/create_pin.dart';
import '../pages/auth_pages/enter_pin.dart';
import '../pages/auth_pages/sign_up.dart';
import '../pages/auth_pages/user_name.dart';
import '../pages/auth_pages/verify_email.dart';
import '../pages/welcome_page/welcome_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case WelcomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => WelcomePage(),
        );
      case AuthPage.routeName:
        return MaterialPageRoute(
          builder: (context) => AuthPage(),
        );
      case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
        );
      case ConfirmPIN.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              ConfirmPIN(pinCode: routeSettings.arguments as String),
        );
      case CreatePIN.routeName:
        return MaterialPageRoute(
          builder: (context) => CreatePIN(),
        );
      case EnterPINPage.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              EnterPINPage(email: routeSettings.arguments as String),
        );
      case UserNamePage.routeName:
        return MaterialPageRoute(
          builder: (context) => UserNamePage(),
        );
      case VerifyEmailPage.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              VerifyEmailPage(email: routeSettings.arguments as String),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => WelcomePage(),
        );
    }
  }
}
