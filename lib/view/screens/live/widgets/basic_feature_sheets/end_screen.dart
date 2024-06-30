import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/live_messages_controller.dart';

import '../../../../../view_model/live_controller.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  late Uint8List imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool kickOut = false;
    LiveViewModel liveViewModel = Get.find();
    kickOut = Get.arguments ?? false;
    return WillPopScope(
      onWillPop: () async {
        liveViewModel.popBackToHomePage();
        return await false;
      },
      child: BaseScaffold(
        body: Screenshot(
          controller: screenshotController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 4),
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                          onTap: ()=> liveViewModel.popBackToHomePage(),
                          child: Icon(Icons.close)),
                    ],
                  ),
                ),
                SizedBox(height: 96.h),
                Center(
                  child: Text(
                    kickOut==true ? 'You Got Kicked Out' :  "Live Stream Ended",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!,),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("${liveViewModel.liveStreamingModel.getViewsCount ?? 0}",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Views",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${liveViewModel.liveStreamingModel.getFansCount ?? 0}",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "New Fans",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${liveViewModel.liveStreamingModel.getGifterCount ?? 0}",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Gifters",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${liveViewModel.liveStreamingModel.getTotalCoins ?? 0}",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Coins",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  width: 313.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Color(0xff414242),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Time",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          formatTime(int.parse(liveViewModel.liveStreamingModel.getLiveTime ?? "0")),
                          // '0',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.yellowBtnColor),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 313.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Color(0xff414242),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subscriber gain",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${liveViewModel.liveStreamingModel.getSubscriberGain ?? 0}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.yellowBtnColor),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 313.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Color(0xff414242),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Comments",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${liveViewModel.liveStreamingModel.getComments ?? 0}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.yellowBtnColor),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Share",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: (){
                    screenshotController.capture().then((value) {
                      QuickActions.shareImage(value!);
                      // setState(() {
                      //   imageFile = value!;
                      // });
                    });

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 105.w, right: 105.w),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                          child: Image.asset(AppImagePath.fIcon),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                          child: Image.asset(AppImagePath.tIcon),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                          child: Image.asset(AppImagePath.twIcon),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
