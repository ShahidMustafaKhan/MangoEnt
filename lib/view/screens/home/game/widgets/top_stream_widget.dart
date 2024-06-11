import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';

import '../../../../../utils/theme/colors_constant.dart';

class TopStreamWidget extends StatelessWidget {
  const TopStreamWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            5,
            (index) => Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Column(
                    children: [
                      Container(
                        width: 250.w,
                        height: 141.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Stack(children: [
                          Image.asset(
                            ((index % 2 == 0)
                                ? AppImagePath.red_redemption
                                : AppImagePath.bravery),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                width: 41.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(child: Text("LIVE")),
                              )),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 81.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: AppColors.darkPurple,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text(
                                  "55,2k viewers",
                                  style: TextStyle(fontSize: 10.sp),
                                )),
                              )),
                        ]),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(right: 100.w),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.asset(
                                    AppImagePath.profilePic,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Whoopee Streamer',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Red Dead Redemption',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Container(
                                      width: 48.w,
                                      height: 19.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff494848),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Fantasy",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Container(
                                      width: 48.w,
                                      height: 19.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff494848),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Action",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
