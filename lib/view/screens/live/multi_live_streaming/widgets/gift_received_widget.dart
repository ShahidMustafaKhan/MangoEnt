import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../utils/constants/app_constants.dart';

import '../../../../../view_model/zego_controller.dart';


class GiftReceivedWidget extends StatelessWidget {
   GiftReceivedWidget();

  final ZegoController zegoController = Get.find();

  @override
  Widget build(BuildContext context) {
      return Stack(
              children: [
                Positioned(
                    bottom: 105,
                    left: 5,
                    child: Container(
                      height: 36.h,
                      width: 122.w,
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
                          Image.asset(
                            AppImagePath.profilePic,
                            height: 28.h,
                            width: 28.w,
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
                                "Wahid",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                "Sent heart",
                                style:
                                TextStyle(fontSize: 8.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image.asset(AppImagePath.heartsImage)
                        ],
                      ),
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
                        "x99",
                        style: TextStyle(
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    }
}

