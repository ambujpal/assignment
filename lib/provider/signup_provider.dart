import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:assignment/utils/utils.dart';
import 'package:assignment/widgets/custom_elevated_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool _isLoading = false;
  bool _isChecked = false;
  bool _isShowPassword = true;

  bool get ishowPassword => _isShowPassword;

  bool get isLoading => _isLoading;
  bool get isChecked => _isChecked;

  hidePass() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  termCondition() {
    _isChecked = !_isChecked;
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
    } else if (_isChecked == false) {
      Utils.errorMessage(context, "Accept and checked  the terms & condition.");
      return false;
    } else {
      return true;
    }
  }

  clearTextFields() {
    emailC.clear();
    passwordC.clear();
  }

  Future<void> signupMethod(context, String email, String password) async {
    if (!validationForm(context)) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("User signed up: ${userCredential.user!.email}");
      showSuccesDialog(context);
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        Utils.errorMessage(context, 'The password provided is too weak.');
        _isLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        Utils.errorMessage(
            context, 'The account already exists for that email.');
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

  Future<void> showSuccesDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02),
              Image.asset(AppImages.successIc, height: height * 0.1),
              SizedBox(height: height * 0.01),
              Text(
                "Succes",
                style: AppTextStyle.ts18MB.copyWith(fontSize: 20),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Text(
                    "Congratulations, you have completed your registration!",
                    style: AppTextStyle.ts14RB.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              CustomElevatedBtn(
                title: "Done",
                bgColor: AppColors.primaryColor,
                indicatorColor: Colors.white,
                onTap: () async {
                  clearTextFields();
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        );
      },
    );
  }
}
