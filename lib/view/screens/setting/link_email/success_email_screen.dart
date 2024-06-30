import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../widgets/custom_buttons.dart';

class SuccessEmailScreen extends StatefulWidget {
  const SuccessEmailScreen();

  @override
  State<SuccessEmailScreen> createState() => _SuccessEmailScreenState();
}

class _SuccessEmailScreenState extends State<SuccessEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Image.asset(
            AppImagePath.succeed,
            width: 90.w,
            height: 80.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 55.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Succeeded!",
                      style: TextStyle(
                          fontSize: 36.sp, fontWeight: FontWeight.w700),
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    Text(
                      " Your email has been set \n successfully",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                    title: "Back to menu",
                    textColor: Color(0xff1E2121),
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
