import 'package:assignment/model/product_model.dart';
import 'package:assignment/provider/course_provider.dart';
import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:assignment/widgets/custom_button.dart';
import 'package:assignment/widgets/custom_elevated_btn.dart';
import 'package:assignment/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseProvider>(context, listen: false)
          .getApiProducts(context);
      Provider.of<CourseProvider>(context, listen: false)
          .getApiCotegory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<CourseProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Course",
                        style: AppTextStyle.ts18BB,
                      ),
                      Image.asset(
                        AppImages.maskImg,
                        height: height * 0.05,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  CustomSearchField(
                    searchC: provider.searchC,
                    isShowCancelIcon: true,
                    onValueChangeFunction: (value) {
                      provider.searchTasks(
                          provider.title == "All"
                              ? provider.productList
                              : provider.title == "Popular"
                                  ? provider.popularProductList
                                  : provider.newProductList,
                          provider.filterList);
                    },
                    onCancelCallbackFunction: () {
                      provider.resetProductList(
                          provider.popularProductList, provider.filterList);
                    },
                    onFilterCallbackFunction: () {
                      bottomModelSheet(context, height, width, provider);
                    },
                    hintText: "Search",
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: height * 0.15,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.items.length,
                        itemBuilder: (context, index) {
                          var data = provider.items[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              width: width * 0.45,
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? const Color(0xffCEECFE)
                                    : const Color(0xffEFE0FF),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    data["image"],
                                    height: height * 0.08,
                                  ),
                                  SizedBox(width: width * 0.01),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? const Color(0xffF3FBFF)
                                            : const Color(0xffF8F2FF)),
                                    child: Text(
                                      data["title"],
                                      style: AppTextStyle.ts12RB.copyWith(
                                          color: index % 2 == 0
                                              ? AppColors.primaryColor
                                              : const Color(0xff9065BE)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    "Choice your course",
                    style: AppTextStyle.ts18BB,
                  ),
                  SizedBox(height: height * 0.01),
                  SizedBox(
                    height: height * 0.035,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.btnList.length,
                        itemBuilder: (context, index) {
                          var data = provider.btnList[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: CustomButton(
                              title: data["title"],
                              bgColor: provider.currentIndex == index
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                              titleColor: provider.currentIndex == index
                                  ? AppColors.white
                                  : AppColors.black,
                              onTap: () {
                                provider.assignIndex(index, data["title"]);
                              },
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: height * 0.01),
                  choiceItemsWidget(
                    provider.filterList,
                    provider.title == "All"
                        ? provider.productList
                        : provider.title == "Popular"
                            ? provider.popularProductList
                            : provider.newProductList,
                    height,
                    width,
                    provider.isLoading,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> bottomModelSheet(BuildContext context, double height,
      double width, CourseProvider provider) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: height * 0.9,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                              size: 25,
                            )),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Search Filter",
                          style: AppTextStyle.ts18BB,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Cotegories",
                      style: AppTextStyle.ts18BB,
                    ),
                    SizedBox(height: height * 0.01),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: provider.categoriesList.map((category) {
                        return FilterChip(
                          selectedColor: AppColors.primaryColor,
                          label: Text(category),
                          selected:
                              provider.selectedCategories.contains(category),
                          onSelected: (bool selected) {
                            provider.selectCotegoryItems(selected, category);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Price",
                      style: AppTextStyle.ts18BB,
                    ),
                    SizedBox(height: height * 0.01),
                    RangeSlider(
                        values: RangeValues(provider.minPrice.toDouble(),
                            provider.maxPrice.toDouble()),
                        min: 0.0,
                        max: 500.0,
                        onChanged: (value) {
                          provider.selectPriceRange(value);
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('\$${provider.minPrice}'),
                        Text('\$${provider.maxPrice}'),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "Duration",
                      style: AppTextStyle.ts18BB,
                    ),
                    SizedBox(height: height * 0.01),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: provider.durationsList.map((category) {
                        return FilterChip(
                          selectedColor: AppColors.primaryColor,
                          label: Text(category),
                          selected:
                              provider.selectedDurations.contains(category),
                          onSelected: (bool selected) {
                            provider.selectDurationItems(selected, category);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primaryColor)),
                          onPressed: () {
                            provider.clearFilters();
                          },
                          child: Text(
                            "Clear",
                            style: AppTextStyle.ts14MB
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                        Expanded(
                          child: CustomElevatedBtn(
                            title: "Apply",
                            bgColor: AppColors.primaryColor,
                            onTap: () {},
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget choiceItemsWidget(List<Product> filterList, List<Product> itemsList,
      double height, double width, bool isLoading) {
    return SizedBox(
        height: height * 0.4,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : itemsList.isEmpty
                ? Center(
                    child: Text("No Data Found!", style: AppTextStyle.ts16MB),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterList.isEmpty
                        ? itemsList.length
                        : filterList.length,
                    itemBuilder: (context, index) {
                      var data = filterList.isEmpty
                          ? itemsList[index]
                          : filterList[index];
                      return Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.08,
                                width: width * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              SizedBox(width: width * 0.07),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.title,
                                        style: AppTextStyle.ts14MB),
                                    SizedBox(height: height * 0.001),
                                    // Row(
                                    //   children: [
                                    //     Icon(Icons.person,
                                    //         color: Colors.grey.shade400, size: 20),
                                    //     SizedBox(width: width * 0.001),
                                    //     Text(data["name"],
                                    //         style: AppTextStyle.ts14MB),
                                    //   ],
                                    // ),
                                    SizedBox(height: height * 0.001),
                                    Row(
                                      children: [
                                        Text("\$${data.price}",
                                            style: AppTextStyle.ts16BB.copyWith(
                                                color: AppColors.primaryColor)),
                                        SizedBox(width: width * 0.01),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: const Color(0xffFFEBF0)),
                                            child: Text(
                                                data.warrantyInformation,
                                                style: AppTextStyle.ts14MB
                                                    .copyWith(
                                                        color: const Color(
                                                            0xffFF6905))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }));
  }
}
