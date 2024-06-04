
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../view_model/live_controller.dart';
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
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 0),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(message['color']!)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Image.asset(
                                            AppImagePath.profilePic,
                                            width: 16.h,
                                            height: 16.h,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            message['text']!,
                                            style: sfProDisplayMedium.copyWith(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if(index!=messages.length-1)
                              SizedBox(
                                height: 9.h,
                              ),
                            ],
                          );
                        },
                      ),
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