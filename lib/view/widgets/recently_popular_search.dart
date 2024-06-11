import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../utils/theme/colors_constant.dart';

class RecentlyPopular extends StatelessWidget {
  const RecentlyPopular({Key? key}) : super(key: key);

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
                        width: 87.w,
                        height: 106.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Color(0xff212121)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.yellow),
                              child: Image.asset(
                                AppImagePath.profilePic,
                                fit: BoxFit.cover,
                                height: 40.h,
                                width: 40.w,
                              ),
                            ),
                            Text(
                              "Maxwell",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: 36.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: AppColors.yellowBtnColor),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
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
