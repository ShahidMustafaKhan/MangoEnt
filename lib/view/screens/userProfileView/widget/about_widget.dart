import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
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
              "GMA THE CLASH TOP 320 GMA STUDIOS \nCHAMPION ARTIST",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 20.h,
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
                      "Canada",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    SvgPicture.asset(
                      AppImagePath.Canada,
                      width: 22.w,
                      height: 16.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 134.w,
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
                      "Iphone14 pro",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    Image.asset(AppImagePath.mobileButton),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
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
            height: 10.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Social",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 5.h,
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
    );
  }
}
