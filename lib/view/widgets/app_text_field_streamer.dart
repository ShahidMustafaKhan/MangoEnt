import 'package:flutter/material.dart';

import '../../utils/constants/typography.dart';

class AppTextFormSField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObSecure;
  final String hintText;
  final Color? txtColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isPrefixIcon;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final bool isSuffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final Widget? suffixIcon;
  final int maxLines;

  const AppTextFormSField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.onChanged,
    required this.hintText,
    this.txtColor,
    this.isObSecure = false,
    this.isPrefixIcon = false,
    this.textStyle,
    this.prefixIcon,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.borderRadius = 24,
    this.fillColor,
    this.borderColor,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: TextInputAction.none,
      // style:  TextStyle(color:txtColor?? AppColors.kBlack),
      controller: controller,
      cursorColor: txtColor ?? Colors.white,
      obscureText: isObSecure,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle ?? sfProDisplayRegular.copyWith(fontSize: 18, color: Colors.white),
        fillColor: fillColor,
        prefixIcon: isPrefixIcon ? prefixIcon : null,
        suffixIcon: isSuffixIcon ? suffixIcon : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          //<-- SEE HERE
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.transparent)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Adjust the radius as needed
          borderSide: const BorderSide(color: Colors.red), // Border color when there's an error
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Adjust the radius as needed
          borderSide: const BorderSide(color: Colors.red), // Border color when there's an error
        ),
      ),
      validator: validator,
    );
  }
}