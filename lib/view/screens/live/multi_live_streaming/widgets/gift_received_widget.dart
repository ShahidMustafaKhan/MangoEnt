import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../utils/constants/app_constants.dart';



class GiftReceivedWidget extends StatelessWidget {
   GiftReceivedWidget();


  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
      return Positioned(
        top:220.h,
        left: 10.w,
        child: Obx(() {
          if(liveViewModel.showGiftBanner.value)
            return Container(
              height: 220.h,
                width: 255.w,
              child: Stack(
                      children: [
                        Positioned(
                            bottom: 105,
                            left: 5,
                            child: Row(
                              children: [
                                Container(
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF000000).withOpacity(
                                            1.0), // 100% opacity
                                        Color(0xFF000000).withOpacity(
                                            0.3), // 30% opacity
                                      ],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                    // color: Color(0xFF0C0C0D)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      CircleAvatar(
                                        radius: 14.r,
                                        backgroundImage: NetworkImage(liveViewModel.senderDetail[LiveStreamingModel.keySenderAvatar],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                           liveViewModel.senderDetail[LiveStreamingModel.keySenderName].toString().split(" ")[0],
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          SizedBox(height: 5.h,),
                                          Text(
                                            "Sent ${liveViewModel.senderDetail[LiveStreamingModel.keyGiftName]}",
                                            style:
                                            TextStyle(fontSize: 8.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Image.asset(liveViewModel.senderDetail[LiveStreamingModel.keyGiftPath]),

                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: 105,
                          right: 45,
                          child: Container(
                            height: 36.h,
                            width: 56.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF000000)
                                      .withOpacity(1.0), // 100% opacity
                                  Color(0xFF000000)
                                      .withOpacity(0.3), // 30% opacity
                                ],
                              ),
                              // borderRadius: BorderRadius.circular(50),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              // color: AppColors.grey300
                              // color: Color(0xFF0C0C0D)
                            ),
                            child: Center(
                              child: Text(
                                "x${liveViewModel.senderDetail[LiveStreamingModel.keyQuantity]}",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          return SizedBox();
          }
        ),
      );
    }
}

