import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../helpers/quick_help.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/typography.dart';
import '../../../utils/theme/colors_constant.dart';
import '../../../view_model/userViewModel.dart';
import '../../widgets/custom_buttons.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
                    onTap :()=> Get.back() ,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  Text(
                    "Settings",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Text(
                    "Account and Security",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "Unsafe",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.accountAndSecurity);
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
              GestureDetector(
                onTap: ()=> Get.toNamed(AppRoutes.connectedAccount),
                child: Row(
                  children: [
                    Text(
                      "Connected Account",
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.white),
                      child: Center(
                          child: Image.asset(
                        AppImagePath.fIcon,
                        height: 12.h,
                        width: 12.w,
                      )),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.connectedAccount);
                        },
                        child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: double.infinity,
          height: 16.h,
          color: Color(0xff494848),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Notifications",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.notificationScreen);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // Divider(color: Color(0xff494848)),
              Divider(color: Colors.white),

              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "Privacy",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.privacySettingScreen);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "Dislike",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.dislikeSetting);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: Color(0xff494848)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "General",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.generalSetting);
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: double.infinity,
          height: 16.h,
          color: Color(0xff494848),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Clear Cache",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
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
                  Text(
                    "About Us",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "1.1.1",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: double.infinity,
          height: 16.h,
          color: Color(0xff494848),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "App Update",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "1.0.0",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow),
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
                  Text(
                    "Logout",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: AppColors.card,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Do you really want to log out',
                                    style: sfProDisplayRegular.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: PrimaryButton(
                                          title: 'No',
                                          height: 40,
                                          borderRadius: 35,
                                          textStyle: sfProDisplayBold.copyWith(
                                              fontSize: 16,
                                              color: AppColors.yellowColor),
                                          bgColor: AppColors.grey500,
                                          borderColor: AppColors.yellowColor,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: PrimaryButton(
                                          title: 'Yes',
                                          height: 40,
                                          borderRadius: 35,
                                          textStyle: sfProDisplayBold.copyWith(
                                              fontSize: 16,
                                              color: AppColors.black),
                                          bgColor: AppColors.yellowBtnColor,
                                          onTap: () {
                                            QuickHelp.showLoadingDialog(context);
                                            Get.find<UserViewModel>().currentUser
                                                .logout(deleteLocalUserData: true)
                                                .then((value) {
                                              QuickHelp.hideLoadingDialog(context);
                                              Get.offAllNamed(AppRoutes.onBoarding);
                                            }).onError(
                                                  (error, stackTrace) {
                                                QuickHelp.hideLoadingDialog(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),

            ],
          ),
        ),
      ],
    ));
  }
}
