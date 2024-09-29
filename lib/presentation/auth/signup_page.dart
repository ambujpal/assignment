import 'package:assignment/provider/signup_provider.dart';
import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:assignment/utils/routes/routes_name.dart';
import 'package:assignment/widgets/custom_elevated_btn.dart';
import 'package:assignment/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Consumer<SignupProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            // color: Colors.blueGrey.shade50,
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
                    "Sign Up",
                    style: AppTextStyle.ts18BB.copyWith(fontSize: 22),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Enter your details below & free sign up",
                    style: AppTextStyle.ts14RW
                        .copyWith(color: AppColors.borderColor),
                  ),
                ),
                SizedBox(height: height * 0.02),
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
                              height: height * 0.05,
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
                            const SizedBox(height: 50.0),
                            CustomElevatedBtn(
                              title: "Create account",
                              bgColor: AppColors.primaryColor,
                              isLoading: provider.isLoading,
                              indicatorColor: Colors.white,
                              onTap: () async {
                                provider.signupMethod(
                                  context,
                                  provider.emailC.text,
                                  provider.passwordC.text,
                                );
                                // provider.showSuccesDialog(context);
                              },
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Checkbox(
                                    value: provider.isChecked,
                                    onChanged: (value) =>
                                        provider.termCondition()),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  child: Text(
                                    "By creating an account you have to agree with our term & condition.",
                                    style: AppTextStyle.ts12RB,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppTextStyle.ts14RB,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutesName.loginScreen);
                                  },
                                  child: Text(
                                    "Login",
                                    style: AppTextStyle.ts16RB.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                )
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
