
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../utils/routes/app_routes.dart';
import '../../../../view_model/live_controller.dart';
import '../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';
import 'bottom_bar.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'chat_text_field.dart';

class BottomCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: liveViewModel.isMultiGuest ? 12.w : 0),
      child: Container(
        height: liveViewModel.isAudioLive && liveViewModel.liveStreamingModel.getAudioSeats == 11 ? 200.h : 230.h,
        child: Obx(() {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: ChatFeature(),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: ()=> Get.toNamed(AppRoutes.store),
                        child: Padding(
                          padding: EdgeInsets.only(top:15.h),
                          child: Image.asset(AppImagePath.shopIcon, height: 115.h, width: 100.w),
                        ),
                      ),
                      // SizedBox(
                      //   height: 5.h,
                      // )
                    ],
                  ),
                ),
                if(liveViewModel.chatField.value==false)
                  BottomBar(),
                if(liveViewModel.chatField.value==true)
                  SizedBox(height: 67.h),
                if(liveViewModel.chatField.value==false)
                  SizedBox(height: Get.find<LiveViewModel>().role==ZegoLiveRole.audience ? 18 : 20),
              ],
            );
          }
        ),
      ),
    );
  }
}