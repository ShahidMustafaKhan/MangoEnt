import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_buttons.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail();

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                ),
                Text("Change Email",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
                SizedBox(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          SizedBox(
            height: 40.h,
          ),
          Image.asset(AppImagePath.changeEmail),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 55.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Linked email:hu***@gmail.com",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    Text(
                      " You can use the linked email to log in, do security\n verification or reset pasword",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                PrimaryButton(
                    width: 343.w,
                    height: 48.h,
                    borderRadius: 35.r,
                    title: "Change",
                    textColor: Color(0xff1E2121),
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {
                      Get.toNamed(AppRoutes.securityVerificationEmail);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
