import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/theme/colors_constant.dart';

class ConnectedAccount extends StatelessWidget {
  const ConnectedAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
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
                  Text(
                    "Connected Account",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: Center(
                            child: Image.asset(
                              AppImagePath.fIcon,
                              height: 11.h,
                              width: 11.w,
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Facebook",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Text(
                        "Connected",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
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
                      Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: Center(
                            child: Image.asset(
                              AppImagePath.tIcon,
                              height: 11.h,
                              width: 11.w,
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Tiktok",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Text(
                        "Connected",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.yellow),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(color: Color(0xff494848)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    ));
  }
}
