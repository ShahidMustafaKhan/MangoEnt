import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class SubscriberSheet extends StatefulWidget {
  const SubscriberSheet({Key? key}) : super(key: key);

  @override
  State<SubscriberSheet> createState() => _SubscriberSheetState();
}

class _SubscriberSheetState extends State<SubscriberSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 543.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Subscriber",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Divider(
                  height: 3.h,
                  color: AppColors.grey300,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: 343.w,
                  height: 122.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Color(0xff0F0C15),
                      border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffBD8DF4)),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset(
                                  AppImagePath.multiGuestImage,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  "LLOUISE DNLO",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  width: 99.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Color(0xff3F3D44)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Subscriber 2",
                                        style: TextStyle(
                                            color: Color(0xffBD8DF4),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xffBD8DF4),
                                        size: 18,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Welcome my dear subscribers.",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      "Estimated revenue:",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "\$75",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.yellowBtnColor),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Container(
                      height: 35.h,
                      width: 1.w,
                      color: AppColors.yellowBtnColor,
                    ),
                    Column(
                      children: [
                        Text(
                          "25",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Subscribers",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Container(
                      height: 35.h,
                      width: 1.w,
                      color: AppColors.yellowBtnColor,
                    ),
                    Column(
                      children: [
                        Text(
                          "30",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Expired",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Subscriber Announcement",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text("50/200")
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 100.h,
                  width: 343.w,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          "Thanks for subscribing and enjoy yourself here!",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xffB9B8BB),
                      contentPadding:
                          EdgeInsets.only(left: 20.h, top: 10.h, bottom: 60),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none, // No border
                      ),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    minLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
