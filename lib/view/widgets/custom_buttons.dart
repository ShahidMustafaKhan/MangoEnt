import 'package:flutter/material.dart';

import '../../utils/constants/typography.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final Color? bgColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color borderColor;
  final Function()? onTap;
  final Widget? child;
  final double width;
  final double height;
  final double borderRadius;

  const PrimaryButton({
    this.title,
    this.textStyle,
    this.bgColor,
    this.textColor,
    this.disabledColor,
    this.disabledTextColor,
    this.borderColor = Colors.transparent,
    required this.onTap,
    this.child,
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: bgColor,
      disabledColor: disabledColor,
      disabledTextColor: disabledTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: borderColor, width: 1.3),
      ),
      onPressed: onTap,
      child: child ??
          Text(
            title ?? '',
            style: textStyle ?? sfProDisplayBold.copyWith(color: textColor, fontSize: 20),
          ),
    );
  }
}

class UnderlineTextButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Color? color;

  const UnderlineTextButton({
    this.onTap,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: sfProDisplayRegular.copyWith(
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationColor: color ?? Colors.white,
          color: color,
        ),
      ),
    );
  }
}
