import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_constants.dart';

class StickerDialoge extends StatelessWidget {
  final String sticker;
  final String name;
  final bool avatarFrameSelected;
  const StickerDialoge({required this.sticker, required this.name, this.avatarFrameSelected=false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 320.w,
        decoration: BoxDecoration(
          color: const Color(0xff252626),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 150.h,
              width: 320.w,
              decoration: BoxDecoration(
                color: amberColor.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
              ),
              alignment: Alignment.center,
              child:avatarFrameSelected ? 
                  SvgPicture.asset( sticker,
                    height: 73.h,)
                  : Image.asset(
                sticker,
                height: 73.h,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text(
                "The top I on the broadcaster's top fans weekly leaderboard with over 100000 diamond sent will win the TOP I exclusive RIDE.(The RIDE is valid for 7 days)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 48.h,
                width: 242.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.r),
                  color: amberColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "GOT IT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
