import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/typography.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObSecure;
  final String hintText;
  final Color? txtColor;
  final String? Function(String?)? validator;
  final bool isPrefixIcon;
  final Widget? prefixIcon;
  final bool isSuffixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final double borderRadius;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final AutovalidateMode? autoValidateMode;
  final String? headingText;
  final bool enableHeadingText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;

  const AppTextFormField(
      {Key? key,
      required this.controller,
      this.keyboardType = TextInputType.text,
      required this.validator,
      required this.hintText,
      this.txtColor,
      this.isObSecure = false,
      this.isPrefixIcon = false,
      this.prefixIcon,
      this.isSuffixIcon = false,
      this.suffixIcon,
      this.maxLines = 1,
      this.borderRadius = 100,
      this.textInputAction = TextInputAction.none,
      this.onChanged,
      this.autoValidateMode,
      this.headingText,
      this.hintStyle,
      this.enableHeadingText = false, this.fillColor, this.borderColor,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enableHeadingText ?
        Text(
            headingText ?? '',
        style: sfProDisplayMedium.copyWith(fontSize: 18, color: Colors.white70))
            : const SizedBox.shrink(),
        SizedBox(
          height: ScreenUtil().setHeight(8),
        ),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          cursorColor: txtColor ?? Colors.white,
          obscureText: isObSecure,
          maxLines: maxLines,
          style:sfProDisplayMedium.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.7)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.0),
            hintText: hintText,
            fillColor: fillColor,
            hintStyle: hintStyle ?? sfProDisplayMedium.copyWith(fontSize: 12.sp, color: Colors.white.withOpacity(0.5)),
            prefixIcon: isPrefixIcon ? prefixIcon : null,
            suffixIcon: isSuffixIcon ? suffixIcon : null,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                //<-- SEE HERE
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.transparent)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius), // Adjust the radius as needed
              borderSide: const BorderSide(color: Colors.red), // Border color when there's an error
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius), // Adjust the radius as needed
              borderSide: const BorderSide(color: Colors.red), // Border color when there's an error
            ),
          ),
          validator: validator,
          onChanged: onChanged,
          autovalidateMode: autoValidateMode,
        ),
      ],
    );
  }
}
