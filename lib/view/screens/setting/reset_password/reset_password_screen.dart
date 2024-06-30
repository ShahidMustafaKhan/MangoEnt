import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import '../../../../utils/routes/app_routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              Text(
                "Reset password",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(),
            ],
          ),
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
                    "Reset Password",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "*",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                  ),
                  Text(
                    " We will send a verification code to our account",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    " Via phone: +92 303****30303",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                  width: 343.w,
                  height: 48.h,
                  borderRadius: 35.r,
                  title: "Receive code",
                  textColor: AppColors.black,
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {
                    Get.toNamed(AppRoutes.retrievePasswordScreen);
                  }),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    " Via Email: Gmail@gmail.com",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                  width: 343.w,
                  height: 48.h,
                  borderRadius: 35.r,
                  title: "Receive code",
                  textColor: AppColors.black,
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {}),
            ],
          ),
        ),
      ],
    ));
  }
}
