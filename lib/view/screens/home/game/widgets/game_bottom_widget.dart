import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';

import '../../../../../utils/theme/colors_constant.dart';

class GameBottomWidget extends StatelessWidget {
  const GameBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? Colors.black : AppColors.white;
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(5.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5.h,
            crossAxisSpacing: 15.w,
            childAspectRatio: 1.1),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 165.w,
                height: 93.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.asset(
                        (index % 2 == 0
                            ? AppImagePath.red_redemption
                            : AppImagePath.bravery),
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 5,
                      child: Container(
                        width: 41.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Text("LIVE")),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child: Container(
                        width: 81.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "55,2k viewers",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            AppImagePath.profilePic,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Whoopee Streamer',
                          style: TextStyle(
                            // color: AppColors.white,
                            color: textColor,

                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Red Dead Redemption',
                          style: TextStyle(
                            // color: AppColors.grey,
                            color: textColor,

                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
