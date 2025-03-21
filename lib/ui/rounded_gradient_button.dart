import 'package:flutter/material.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../utils/Utils.dart';

class RoundedGradientButton extends StatelessWidget {
  final Function? onTap;
  final double? marginTop;
  final double? marginLeft;
  final double? marginRight;
  final double? marginBottom;
  final String text;
  final TextAlign? textAlign;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final Color? textColor;
  final Color? shadowColor;
  final List<Color> colors;
  final FontWeight? fontWeight;

  const RoundedGradientButton({
    Key? key,
    required this.text,
    this.fontWeight,
    this.textAlign,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius,
    this.borderRadiusTopLeft = 0,
    this.borderRadiusTopRight = 0,
    this.borderRadiusBottomLeft = 0,
    this.borderRadiusBottomRight = 0,
    this.textColor,
    this.shadowColor,
    this.colors = const [Colors.red, Colors.blue],
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      padding: EdgeInsets.all(0.0),
      // shadowColor: shadowColor != null ? shadowColor : colors[0],
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius != null
            ? BorderRadius.all(Radius.circular(borderRadius!))
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadiusTopLeft!),
                topRight: Radius.circular(borderRadiusTopRight!),
                bottomLeft: Radius.circular(borderRadiusBottomLeft!),
                bottomRight: Radius.circular(borderRadiusBottomRight!),
              ),
      ),
    );

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(
          left: marginLeft!,
          top: marginTop!,
          bottom: marginBottom!,
          right: marginRight!),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          // style: flatButtonStyle,
          child: Ink(
            width: size.width,
            decoration: BoxDecoration(
              color: AppColors.yellowBtnColor,
              // gradient: LinearGradient(
              //   colors: colors,
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
              borderRadius: borderRadius != null
                  ? BorderRadius.all(Radius.circular(borderRadius!))
                  : BorderRadius.only(
                topLeft: Radius.circular(borderRadiusTopLeft!),
                topRight: Radius.circular(borderRadiusTopRight!),
                bottomLeft: Radius.circular(borderRadiusBottomLeft!),
                bottomRight: Radius.circular(borderRadiusBottomRight!),
              ),
            ),
            child: Container(
              width: size.width,
              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: textAlign,
                style: SafeGoogleFont (
                  'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.375,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
