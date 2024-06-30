import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../utils/theme/colors_constant.dart';

class DataSheetWidget extends StatefulWidget {
  const DataSheetWidget();

  @override
  _DataSheetWidgetState createState() => _DataSheetWidgetState();
}

class _DataSheetWidgetState extends State<DataSheetWidget> {
  LiveViewModel liveViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (controller) {
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
                    child: QuickActions.avatarWidget(
                      liveViewModel.liveStreamingModel.getAuthor!,
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
                        "${liveViewModel.liveStreamingModel.getAuthor!.getFollowers!.length}",
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
                        "${liveViewModel.liveStreamingModel.getTotalCoins ?? 0}",
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
                        Obx(() {
                            return Text(
                              formatTime(liveViewModel.liveTime.value),
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                            );
                          }
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
                          "${liveViewModel.liveStreamingModel.getViewersId!.length ?? 0}",
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
    );
  }

  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String formattedTime = '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    return formattedTime;
  }
}
