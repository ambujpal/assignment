import 'package:assignment/provider/home_provider.dart';
import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              profileWidget(height, width),
              SizedBox(height: height * 0.15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coruselWidget(height, provider, width),
                    SizedBox(height: height * 0.05),
                    Text("Learning Plan", style: AppTextStyle.ts18BB),
                    SizedBox(height: height * 0.02),
                    Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Column(
                          children: [
                            circularProgessBar("Packaging Design", 40, 48),
                            SizedBox(height: height * 0.02),
                            circularProgessBar("Product Design", 6, 24),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      height: height * 0.2,
                      decoration: BoxDecoration(
                          color: const Color(0xffEFE0FF),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    "Meetup",
                                    style: AppTextStyle.ts18MB,
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    "Off-line exchange of learning experiences",
                                    style: AppTextStyle.ts14MB,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              AppImages.dashImg,
                              height: height * 0.08,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget circularProgessBar(String lablel, int value, int max) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircularProgressIndicator(
              value: value / max,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
            const SizedBox(width: 10),
            Text(
              lablel,
              style: AppTextStyle.ts14MB,
            ),
          ],
        ),
        Text(
          '$value/$max',
          style: AppTextStyle.ts14RB,
        ),
      ],
    );
  }

  Widget profileWidget(double height, double width) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height * 0.2,
          decoration: BoxDecoration(color: AppColors.primaryColor),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, Kritsin",
                      style: AppTextStyle.ts18BW.copyWith(fontSize: 22),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "Let's start learning",
                  style: AppTextStyle.ts14RW,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          top: 120,
          left: 20,
          right: 20,
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Learned today",
                        style: AppTextStyle.ts14RB,
                      ),
                      Text(
                        "My Courses",
                        style: AppTextStyle.ts14RB
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  RichText(
                    text: TextSpan(
                        text: "46min",
                        style: AppTextStyle.ts18BB,
                        children: [
                          TextSpan(
                            text: "/60min",
                            style: AppTextStyle.ts14BB
                                .copyWith(color: AppColors.borderColor),
                          )
                        ]),
                  ),
                  SizedBox(height: height * 0.01),
                  Stack(
                    children: [
                      Container(
                        height: height * 0.007,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColors.borderColor,
                        ),
                      ),
                      Container(
                        height: height * 0.007,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade200,
                              const Color(0xffFF5106),
                            ],
                            stops: const [0.1, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget coruselWidget(double height, HomeProvider provider, double width) {
    return SizedBox(
      height: height * 0.2,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: provider.horizontalList.length,
          itemBuilder: (context, index) {
            var items = provider.horizontalList[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: height * 0.19,
                width: width * 0.7,
                decoration: BoxDecoration(
                    color: const Color(0xffCEECFE),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: Image.asset(items["image"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Text(
                        items["title"],
                        style: AppTextStyle.ts16BB,
                      ),
                    ),
                    index == 0
                        ? Positioned(
                            bottom: 20,
                            left: 10,
                            right: 100,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xffFF6905),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Text(
                                "Get Started",
                                style: AppTextStyle.ts16BW,
                              ),
                            ))
                        : Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
