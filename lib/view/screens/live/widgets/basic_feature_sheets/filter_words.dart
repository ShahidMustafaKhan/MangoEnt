import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class FilterWordWidget extends StatelessWidget {
  const FilterWordWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 130),
                  child: Text(
                    'Filter words',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Spacer(),
                Icon(Icons.close)
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: AppColors.grey300,
              height: 3,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Edit the words you don't want to see in the comments, and the \nrelevant comments will be automatically filtered.One user can set \n(50) filtered words. It is not recommended to block common \nwords such as 'Hi, Hello, a, good...'",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  width: 91.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Color(0xff212121),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Call me",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(AppImagePath.deleteIcon),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 91.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Color(0xff212121),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Spam",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(AppImagePath.deleteIcon),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 91.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Color(0xff212121),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "WhatsApp",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(AppImagePath.deleteIcon),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  width: 163.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Color(0xff252626),
                      border: Border.all(color: AppColors.yellowBtnColor)),
                  child: Center(
                    child: Text(
                      "Clear",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.yellowBtnColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 163.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColors.yellowBtnColor),
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ));
  }
}
