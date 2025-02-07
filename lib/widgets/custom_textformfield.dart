import 'package:assignment/style/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final VoidCallback? suffixIconOnTap;
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLines;
  final Function(String)? onChanged;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.labelText, // Corrected spelling to "labelText"
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.suffixIconOnTap,
      this.obscureText = false,
      this.textInputType,
      this.minLines,
      this.maxLines,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: suffixIconOnTap,
                child: Icon(
                  suffixIcon,
                  color: AppColors.borderColor,
                ),
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.borderColor,
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.borderColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.borderColor)),
      ),
    );
  }
}
