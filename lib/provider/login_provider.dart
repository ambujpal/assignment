import 'package:assignment/presentation/home_page_navigation.dart';
import 'package:assignment/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool _isLoading = false;
  bool _isShowPassword = true;

  bool get isLoading => _isLoading;
  bool get ishowPassword => _isShowPassword;

  void hidePass() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool validationForm(context) {
    if (emailC.text.isEmpty) {
      Utils.errorMessage(context, "Email is required.");
      return false;
    } else if (!isValidEmail(emailC.text)) {
      Utils.errorMessage(context, "Enter a valid email.");
      return false;
    } else if (passwordC.text.isEmpty) {
      Utils.errorMessage(context, "Password is required.");
      return false;
    } else {
      return true;
    }
  }

  clearTextFields() {
    emailC.clear();
    passwordC.clear();
  }

  void saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  signInWithEmailAndPass(
      String email, String password, BuildContext context) async {
    if (!validationForm(context)) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePageNavigation(),
        ),
      );
      saveLoginState();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Utils.errorMessage(context, "No user found for that email.");
        _isLoading = false;
        notifyListeners();
      } else if (e.code == "wrong-password") {
        Utils.errorMessage(context, "Wrong password provided for that email.");
        _isLoading = false;
        notifyListeners();
      } else {
        Utils.errorMessage(context, e.message ?? "Authentication error.");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      Utils.errorMessage(context, e.toString());

      _isLoading = false;
      notifyListeners();
    }
  }

  forgotPassword(context) {
    if (emailC.text.isEmpty) {
      Utils.errorMessage(context, "Enter the email.");
      return;
    }
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailC.text)
        .then((value) {
      Utils.succesMessage(context,
          "We have sent you email to recover password, please check email.");
    }).onError((e, s) {
      Utils.errorMessage(context, e.toString());
    });
  }

  Future<User?> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      saveLoginState();
      debugPrint("User credential: $userCredential");
      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      Utils.errorMessage(context, e.toString());
      return null;
    }
  }
}
