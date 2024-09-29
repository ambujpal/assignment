import 'package:assignment/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  void handleNavigation(context) {
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus(context);
    });
  }

  Future<void> checkLoginStatus(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == true) {
      Navigator.pushReplacementNamed(context, AppRoutesName.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutesName.loginScreen);
    }
  }
}
