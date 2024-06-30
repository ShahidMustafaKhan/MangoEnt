import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../widgets/custom_buttons.dart';


class DeleteModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          PrimaryButton(
            width: 342.w,
            height: 80.h,
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: Color(0xFF363339),
            child: Column(
              children: [
                Text(
                  "Delete",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.grey300,
                )
              ],
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            width: 342.w,
            height: 48.h,
            title: 'Cancel',
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {},
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
