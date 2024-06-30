import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';

class VideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 163.w / 220.h,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: 220.h,
                width: 163.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    AppImagePath.multiGuestImage,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: Image.asset(
                  AppImagePath.play,
                  height: 12.h,
                  width: 12.w,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 30,
                child: Text(
                  "1.5k",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 40,
                child: Image.asset(
                  AppImagePath.ic_heart,
                  height: 12.h,
                  width: 12.w,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 15,
                child: Text(
                  "1.5k",
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
