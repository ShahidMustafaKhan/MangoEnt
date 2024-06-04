// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// import '../../../../../../../utils/constants/app_constants.dart';
// import '../../../../../../../utils/constants/typography.dart';
// import '../../../../../../../utils/theme/colors_constant.dart';
// import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';

// class AudioLiveBottomCard extends StatelessWidget {
//   final List<Map<String, String>> messages = [
//     {
//       'text': 'The broadcaster invites you to join a PK',
//       'color': '0XFF3B0073',
//       'width': '209',
//     },
//     {
//       'text': 'Ankush joined the LIVE 😍 ',
//       'color': '0XFF08070B',
//       'width': '160.',
//     },
//     {
//       'text': 'The broadcaster invites you to join a PK',
//       'color': '0XFF3B0073',
//       'width': '209',
//     },
//     {
//       'text': 'Sumit joined the Live ',
//       'color': '0XFF08070B',
//       'width': '160.',
//     },
//     {
//       'text': 'Ankush joined the LIVE 😍 ',
//       'color': '0XFF3B0073',
//       'width': '160.',
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 10,
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Container(
//                   height: 200.h,
//                   child: ListView.builder(
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: 25.h,
//                               width: double.parse(message['width']!).w,
//                               decoration: BoxDecoration(
//                                 color: Color(int.parse(message['color']!)),
//                                 borderRadius: BorderRadius.circular(19),
//                               ),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 5.w,
//                                   ),
//                                   Image.asset(
//                                     AppImagePath.profilePic,
//                                     width: 16.h,
//                                     height: 16.h,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     message['text']!,
//                                     style: sfProDisplayMedium.copyWith(
//                                       color: Colors.white,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   children: [
//                 //     Padding(
//                 //       padding: EdgeInsets.only(bottom: 100.h),
//                 //       child: Image.asset(AppImagePath.audioLiveBadge,
//                 //           width: 93.w, height: 112.h),
//                 //     ),
//                 //   ],
//                 // ),

//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: Image.asset(
//                         AppImagePath.chat,
//                         width: 25,
//                         height: 25,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: Image.asset(
//                         AppImagePath.menu,
//                         width: 25,
//                         height: 25,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: Image.asset(AppImagePath.micIcon,
//                           width: 25, height: 25),
//                     ),
//                     SizedBox(width: 90.w),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: SvgPicture.asset(AppImagePath.sofaFilled,
//                           width: 22, height: 22),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Image.asset(AppImagePath.audioLiveBadge, width: 93.w, height: 112.h),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../widgets/bottom_bar.dart';
import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';

class AudioLiveBottomCard extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'text': 'The broadcaster invites you to join a PK',
      'color': '0XFF3B0073',
      'width': '209',
    },
    {
      'text': 'Ankush joined the LIVE 😍 ',
      'color': '0XFF08070B',
      'width': '160.',
    },
    {
      'text': 'The broadcaster invites you to join a PK',
      'color': '0XFF3B0073',
      'width': '209',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 230.h,
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
                                child: Container(
                                  height: 25.h,
                                  width: double.parse(message['width']!).w,
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
                              ),
                              if(index!=messages.length-1)
                              SizedBox(
                                height: 10.h,
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