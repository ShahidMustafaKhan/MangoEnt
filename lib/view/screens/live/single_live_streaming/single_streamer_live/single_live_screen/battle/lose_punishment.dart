import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/constants/typography.dart';



class LosePunishment extends StatelessWidget {
  LosePunishment();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: AppColors.darkPurple,
      ),
      child: Text('Loser punishment is set by winner', style: sfProDisplayMedium.copyWith(fontSize: 11.sp)),
    );
  }
}
