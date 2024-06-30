import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';

import '../../../../utils/constants/app_constants.dart';


class AddBadgeEmojiSheet extends StatelessWidget {
  const AddBadgeEmojiSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 269.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: const Color(0xff252626),
        // border: const Border.symmetric(
        //   horizontal: BorderSide(
        //     color: Color(0xff494848),
        //   ),
        // ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.transparent,
                ),
              ),
              Text(
                "Add Badge",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: Get.back,
                icon: Text(
                  "x",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xff494848)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: ()=> Get.toNamed(AppRoutes.bag),
                  child: icon(bag, "My Bag")),
              icon(upload, "Upload"),
            ],
          ),
          SizedBox(height: 13.h),

        ],
      ),
    );
  }

  Widget icon(String icon, String text) => Column(
        children: [
          Image.asset(
            icon,
            height: 96.h,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
}
