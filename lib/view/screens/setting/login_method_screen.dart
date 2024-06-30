import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

class LoginMethod extends StatelessWidget {
  const LoginMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
              ),
              Text(
                "Login method",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 80.h,
          ),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.yellowBtnColor, width: 1.5),
            ),
            child: Image.asset(
              AppImagePath.profilePic,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "LLOUISE DNLO",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "id: 0125124",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                Icons.copy,
                size: 12,
              )
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "- You can log in with these services -",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54.w,
                height: 54.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.yellow, width: 2)),
                child: Image.asset(AppImagePath.gIcon),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 54.w,
                height: 54.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.yellow, width: 2)),
                child: Image.asset(AppImagePath.fIcon),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
