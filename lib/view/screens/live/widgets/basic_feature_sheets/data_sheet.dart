import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class DataSheetWidget extends StatefulWidget {
  const DataSheetWidget();

  @override
  _DataSheetWidgetState createState() => _DataSheetWidgetState();
}

class _DataSheetWidgetState extends State<DataSheetWidget> {
  List<bool> isPlayingList = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.yellowBtnColor, width: 3.w)),
                child: Image.asset(
                  AppImagePath.profilePic,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                width: 55.w,
                height: 20.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                    color: Color(0xff0D0D0D)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Live",
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Image.asset(AppImagePath.graph)
                  ],
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
              Container(
                width: 1,
                height: 35.h,
                color: AppColors.yellowBtnColor,
              ),
              SizedBox(
                width: 35.w,
              ),
              Column(
                children: [
                  Text(
                    "25",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp),
                  ),
                  Text(
                    "Followers",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(
                width: 35.w,
              ),
              Container(
                width: 1,
                height: 35.h,
                color: AppColors.yellowBtnColor,
              ),
              SizedBox(
                width: 40.w,
              ),
              Column(
                children: [
                  Text(
                    "350",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp),
                  ),
                  Text(
                    "Coins",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Information",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 32.h,
                width: 94.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xff212121)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "01:00:45",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                height: 32.h,
                width: 66.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xff212121)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(AppImagePath.views),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "122",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Visible in:",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 32.h,
                width: 63.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xff212121)),
                child: Center(
                  child: Text(
                    "Global",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                height: 32.h,
                width: 63.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xff212121)),
                child: Center(
                  child: Text(
                    "Popular",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                height: 32.h,
                width: 63.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Color(0xff212121)),
                child: Center(
                  child: Text(
                    "Follow",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
