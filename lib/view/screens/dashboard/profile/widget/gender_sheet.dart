import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../view_model/gender_controller.dart';
import '../../../../widgets/custom_buttons.dart';

class GenderSheet extends StatelessWidget {
  final GenderController genderController = Get.find<GenderController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, 
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: 'Male',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  genderController.updateGender('Male');
                  Navigator.pop(context);
                },
              ),
              Container(
                width: 342.w,
                height: 0.4.h,
                color: AppColors.white,
              ),
              PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: 'Female',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  genderController.updateGender('Female');
                  Navigator.pop(context);
                },
              ),
              Container(
                width: 342.w,
                height: 0.3.h,
                color: AppColors.white,
              ),
              PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: 'Secret',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  genderController.updateGender('Secret');
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.h),
              PrimaryButton(
                width: 342.w,
                height: 48.h,
                title: 'Cancel',
                borderRadius: 12,
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: AppColors.yellowBtnColor,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
