import 'package:assignment/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? iconsColor;
  final IconData? icons;
  final Color? bgColor;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.titleColor,
    this.iconsColor,
    this.icons,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icons != null) Icon(icons, color: iconsColor, size: 15),
              if (icons != null) const SizedBox(width: 5.0),
              Text(
                title,
                style: AppTextStyle.ts12BW.copyWith(color: titleColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
