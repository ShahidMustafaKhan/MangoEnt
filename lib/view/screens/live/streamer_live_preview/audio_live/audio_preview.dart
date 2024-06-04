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
//       child: Column(
//         children: [
//           Container(
//             height: 200.h, // Adjust height as needed
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                         height: 25.h,
//                         width: double.parse(message['width']!).w,
//                         decoration: BoxDecoration(
//                           color: Color(int.parse(message['color']!)),
//                           borderRadius: BorderRadius.circular(19),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 5.w,
//                             ),
//                             Image.asset(AppImagePath.profilePic,
//                                 width: 16.h, height: 16.h),
//                             const SizedBox(width: 4),
//                             Text(
//                               message['text']!,
//                               style: sfProDisplayMedium.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Color(0xFF08060B),
//                 child: Image.asset(AppImagePath.chat, width: 22, height: 22),
//               ),
//               SizedBox(width: 8),
//               CircleAvatar(
//                 backgroundColor: Color(0xFF08060B),
//                 child: Image.asset(AppImagePath.menu, width: 25, height: 25),
//               ),
//               SizedBox(width: 8),
//               CircleAvatar(
//                 backgroundColor: Color(0xFF08060B),
//                 child: Image.asset(
//                   AppImagePath.micIcon,
//                   width: 25,
//                   height: 25,
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox(width: 160.w),
//               CircleAvatar(
//                 backgroundColor: Color(0xFF08060B),
//                 child: SvgPicture.asset(
//                   AppImagePath.sofaFilled,
//                   width: 25,
//                   height: 25,
//                   color: AppColors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
//         flex: 10,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Image.asset(AppImagePath.badge, width: 50.h, height: 50.h),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: Column(
//               children: [
//                 Container(
//                   height: 200.h, // Adjust height as needed
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
//                                   Image.asset(AppImagePath.profilePic,
//                                       width: 16.h, height: 16.h),
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
//                   height: 20.h,
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child:
//                           Image.asset(AppImagePath.chat, width: 22, height: 22),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child:
//                           Image.asset(AppImagePath.menu, width: 25, height: 25),
//                     ),
//                     SizedBox(width: 8),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: Image.asset(
//                         AppImagePath.micIcon,
//                         width: 25,
//                         height: 25,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     SizedBox(width: 100.w),
//                     CircleAvatar(
//                       backgroundColor: Color(0xFF08060B),
//                       child: SvgPicture.asset(
//                         AppImagePath.sofaFilled,
//                         width: 25,
//                         height: 25,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ]));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';

class AudioEmptyPreview extends StatelessWidget {
  final RxList<String> personList = <String>["9P", "12P"].obs;
  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return Obx(() {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 72.r,
                width: 72.r,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.yellowBtnColor, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(55.r)),
                  child: Image.network(
                    Get.find<UserViewModel>().currentUser.getAvatar!.url!,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Expanded(
                flex: 10,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 21.h,
                    crossAxisSpacing: 32.w,
                    childAspectRatio: 1
                  ),
                  // shrinkWrap: true,

                  itemCount: liveViewModel.nineMemberIndex.value == 0 ? 8 : 11,

                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 52.r,
                      width: 52.r,
                      decoration: BoxDecoration(
                        color: Color(0xFF29464D),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Image.asset(AppImagePath.sofa, height: 18.w, width: 18.w,)),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  personList.length,
                      (index) => GestureDetector(
                    onTap: () {
                      liveViewModel.nineMemberIndex.value = index;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        height: 28.h,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: liveViewModel.nineMemberIndex.value == index
                                ? AppColors.black
                                : AppColors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImagePath.sofaFilled),
                            Text(personList[index]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      }
    );
  }
}
