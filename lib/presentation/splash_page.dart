import 'package:assignment/provider/splash_provider.dart';
import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Consumer<SplashProvider>(builder: (context, provider, child) {
      provider.handleNavigation(context);
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppImages.dashboardImg,
                  height: height * 0.2,
                ),
              ),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Create your own study plan",
                  style: AppTextStyle.ts18BB.copyWith(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Study according to the study plan, make study more motivated",
                  style: AppTextStyle.ts16MB
                      .copyWith(color: AppColors.borderColor),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
