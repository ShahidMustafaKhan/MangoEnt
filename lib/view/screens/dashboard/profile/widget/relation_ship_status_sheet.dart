import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../view_model/relationship_status_controller.dart';
import '../../../../widgets/custom_buttons.dart';

class RelationshipStatusSheet extends StatelessWidget {
  final RelationshipStatusController relationStatusController =
      Get.find<RelationshipStatusController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: 'Single',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  relationStatusController.updateStatus('Single');
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
                title: 'Married',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  relationStatusController.updateStatus('Married');
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
                title: 'In a Relationship',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  relationStatusController.updateStatus('In a Relationship');
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
                title: 'Actively Seeking',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  relationStatusController.updateStatus('Actively Seeking');
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
                title: 'Secret',
                textStyle: sfProDisplayMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
                bgColor: const Color(0xFF363339),
                onTap: () {
                  relationStatusController.updateStatus('Secret');
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
