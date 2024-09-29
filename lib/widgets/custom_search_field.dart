import 'package:assignment/style/app_colors.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchC;
  final bool isShowCancelIcon;
  final Function(String) onValueChangeFunction;
  final Function() onCancelCallbackFunction;
  final Function() onFilterCallbackFunction;
  final String hintText;
  const CustomSearchField({
    super.key,
    required this.searchC,
    required this.isShowCancelIcon,
    required this.onValueChangeFunction,
    required this.onCancelCallbackFunction,
    required this.onFilterCallbackFunction,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        style: AppTextStyle.ts16MB,
        controller: searchC,
        onChanged: onValueChangeFunction,
        decoration: InputDecoration(
          fillColor: const Color(0xffF4F3FD),
          isDense: true,
          hintText: hintText,
          hintStyle: AppTextStyle.ts16MB,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                !isShowCancelIcon
                    ? Container()
                    : InkWell(
                        onTap: onCancelCallbackFunction,
                        child: Icon(
                          Icons.cancel,
                          size: 20.0,
                          color: AppColors.borderColor,
                        ),
                      ),
                const SizedBox(width: 10.0),
                InkWell(
                  onTap: onFilterCallbackFunction,
                  child: Image.asset(
                    AppImages.filterImg,
                    color: const Color(0xffB8B8D2),
                    height: 20.0,
                  ),
                ),
              ],
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
