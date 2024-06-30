import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../utils/theme/colors_constant.dart';

class AccountAndSecurity extends StatelessWidget {
  const AccountAndSecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
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
                    "Account and security",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Image.asset(
                AppImagePath.insecure,
                height: 128.h,
                width: 128.w,
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                "security level: Unsafe",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          width: double.infinity,
          height: 30.h,
          color: Color(0xff494848),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
            child: Text(
              "Add information to improve security",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImagePath.phone,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Phone",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "Unlinked",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.email,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Email",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.changeEmail);
                    },
                    child: Text(
                      "Unlinked",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.linkEmail);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.changePassword,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Change Password",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.changePassword);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.loginMethod,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Login method",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.loginMethod);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.selfBan,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Self ban",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.selfBan);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Image.asset(
                    AppImagePath.selfBan,
                    height: 24.h,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Delete account",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.deleteAccount);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Divider(color: Color(0xff494848)),
            ],
          ),
        ),
      ],
    ));
  }
}
