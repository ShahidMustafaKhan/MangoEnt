import 'package:flutter/material.dart';
import '../../utils/constants/typography.dart';
import '../../utils/theme/colors_constant.dart';

Widget AppButton(BuildContext context,String btnText,Function()? onTap, {Color? textColor, Color? backgroundColor}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width:double.infinity,
      height: 48,
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.yellow,
          borderRadius: BorderRadius.circular(24)
      ),
      child:  Center(child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(btnText,style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: textColor ?? AppColors.kBlack)),
      )),
    ),
  );
}