import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/streamer_profile_controller.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StreamerProfileController controller = Get.find();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Bio",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  controller.profile!.getBio ?? 'Hi! i am using Mango Ent.',
                  style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Basic Information",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  if(controller.profile!.getHideMyLocation == false)
                  Container(
                    width: 109.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color(0xff212121),
                        border: Border.all(
                          color: AppColors.grey300,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          controller.profile!.getCountry!,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        SvgPicture.asset(
                          QuickActions.getCountryFlag(controller.profile!),
                          width: 22.w,
                          height: 16.h,
                        )
                      ],
                    ),
                  ),
                  if(controller.profile!.getHideMyLocation == false)
                    SizedBox(
                    width: 10.w,
                  ),
                  if(controller.profile!.getDevice != null)
                  Container(
                    height: 32.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color(0xff212121),
                        border: Border.all(
                          color: AppColors.grey300,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Text(
                              controller.profile!.getDevice ?? '',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 6.w,),
                        Image.asset(AppImagePath.mobileButton),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Tags",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Container(
                    width: 62.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: AppColors.grey300,
                        )),
                    child: Center(
                      child: Text(
                        "Sweet",
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 62.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: AppColors.grey300,
                        )),
                    child: Center(
                      child: Text(
                        "Singer",
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 62.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: AppColors.grey300,
                        )),
                    child: Center(
                      child: Text(
                        "Gamer",
                        style:
                            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Social",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(color: AppColors.yellowBtnColor)),
                    child: Image.asset(AppImagePath.fIcon),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(color: AppColors.yellowBtnColor)),
                    child: Image.asset(AppImagePath.tIcon),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(color: AppColors.yellowBtnColor)),
                    child: Image.asset(AppImagePath.layerIcon),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(color: AppColors.yellowBtnColor)),
                    child: Image.asset(AppImagePath.kIcon),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
