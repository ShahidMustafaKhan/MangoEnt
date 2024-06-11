
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../view_model/live_controller.dart';
import '../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';
import 'bottom_bar.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';

class BottomCard extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'text': 'The broadcaster invites you to join as a co-host',
      'color': '0XFF3B0073',
      'width': '225',
    },
    {
      'text': 'Ankush joined the LIVE 😍 ',
      'color': '0XFF08070B',
      'width': '160.',
    },
    {
      'text': 'The broadcaster invites you to join as a co-host',
      'color': '0XFF3B0073',
      'width': '225',
    },
    {
      'text': 'Sumit joined the Live ',
      'color': '0XFF08070B',
      'width': '160.',
    },
    {
      'text': 'Ankush joined the LIVE 😍 ',
      'color': '0XFF3B0073',
      'width': '160.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: liveViewModel.isMultiGuest ? 12.w : 0),
      child: Container(
        height: liveViewModel.isAudioLive && liveViewModel.liveStreamingModel.getAudioSeats == 11 ? 200.h : 230.h,
        child: Column(
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
                  Padding(
                    padding: EdgeInsets.only(top:15.h),
                    child: Image.asset(AppImagePath.shopIcon, height: 115.h, width: 100.w),
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // )
                ],
              ),
            ),
            BottomBar(),
            SizedBox(height: Get.find<LiveViewModel>().role==ZegoLiveRole.audience ? 18 : 20),
          ],
        ),
      ),
    );
  }
}