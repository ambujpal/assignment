import 'package:assignment/provider/login_provider.dart';
import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:assignment/utils/routes/routes_name.dart';
import 'package:assignment/widgets/custom_elevated_btn.dart';
import 'package:assignment/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Consumer<LoginProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            color: AppColors.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Login",
                    style: AppTextStyle.ts18BB.copyWith(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.06,
                            ),
                            Text(
                              "Email",
                              style: AppTextStyle.ts16RB,
                            ),
                            const SizedBox(height: 5.0),
                            CustomTextFormField(
                              controller: provider.emailC,
                              textInputType: TextInputType.emailAddress,
                              hintText: "Enter your email",
                              prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              "Password",
                              style: AppTextStyle.ts16RB,
                            ),
                            const SizedBox(height: 5.0),
                            CustomTextFormField(
                              controller: provider.passwordC,
                              obscureText: provider.ishowPassword,
                              textInputType: TextInputType.number,
                              hintText: "Enter your password",
                              prefixIcon: Icons.lock,
                              suffixIcon: provider.ishowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixIconOnTap: () => provider.hidePass(),
                            ),
                            SizedBox(height: height * 0.03),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  provider.forgotPassword(context);
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: AppTextStyle.ts16RB,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            CustomElevatedBtn(
                              title: "Log In",
                              bgColor: AppColors.primaryColor,
                              isLoading: provider.isLoading,
                              indicatorColor: Colors.white,
                              onTap: () async {
                                provider.signInWithEmailAndPass(
                                  provider.emailC.text,
                                  provider.passwordC.text,
                                  context,
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: AppTextStyle.ts14RB,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutesName.signupScreen);
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: AppTextStyle.ts16RB.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Divider(
                                  color: AppColors.borderColor,
                                ),
                                Container(
                                  color: AppColors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Text(
                                    "Or login with",
                                    style: AppTextStyle.ts14RB
                                        .copyWith(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    provider.signInWithGoogle(context);
                                  },
                                  child: Image.asset(
                                    AppImages.googleImg,
                                    height: height * 0.05,
                                  ),
                                ),
                                SizedBox(width: width * 0.08),
                                Image.asset(
                                  AppImages.fbImg,
                                  height: height * 0.05,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
