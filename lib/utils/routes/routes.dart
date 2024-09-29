import 'package:assignment/presentation/auth/login_page.dart';
import 'package:assignment/presentation/auth/signup_page.dart';
import 'package:assignment/presentation/home_page.dart';
import 'package:assignment/presentation/splash_page.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:assignment/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case AppRoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupPage());
      case AppRoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case AppRoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                "No route defined",
                style: AppTextStyle.ts16MB,
              ),
            ),
          );
        });
    }
  }
}
