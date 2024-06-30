// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:teego/utils/constants/app_constants.dart';
// import 'package:teego/utils/constants/typography.dart';
// import 'package:teego/utils/theme/colors_constant.dart';
// import '../../../../../../../view_model/live_controller.dart';

// class AudioLiveTopBar extends StatefulWidget {
//   AudioLiveTopBar();

//   @override
//   State<AudioLiveTopBar> createState() => _AudioLiveTopBarState();
// }

// class _AudioLiveTopBarState extends State<AudioLiveTopBar> {
//   final LiveViewModel liveViewModel = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LiveViewModel>(builder: (controller) {
//       return Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: 40.h,
//                 width: 140.w,
//                 padding: const EdgeInsets.symmetric(vertical: 3),
//                 margin: const EdgeInsets.only(
//                   top: 0,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: AppColors.grey300,
//                 ),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       child: Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 23,
//                             backgroundColor: AppColors.grey300,
//                             backgroundImage:
//                                 AssetImage(AppImagePath.emptyRoomUser),
//                           ),
//                           const SizedBox(width: 8),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Enrique Pemala',
//                                 style: sfProDisplayMedium.copyWith(
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Image.asset(AppImagePath.diamondIcon,
//                                       width: 14, height: 14),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     '8811M',
//                                     style: sfProDisplayMedium.copyWith(
//                                       fontSize: 12,
//                                       color: AppColors.yellowColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // const Spacer(
//               //   flex: 2,
//               // ),
//               SizedBox(
//                 width: 38.w,
//               ),

//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.only(left: 28),
//                         child: Image.asset(AppImagePath.topPerson3,
//                             width: 36, height: 36),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 15),
//                         child: Image.asset(AppImagePath.topPerson2,
//                             width: 36, height: 36),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: Image.asset(AppImagePath.topPerson1,
//                             width: 36, height: 36),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 8),
//               CircleAvatar(
//                 radius: 16,
//                 backgroundColor: AppColors.grey300,
//                 child:
//                     Image.asset(AppImagePath.shareIcon, width: 22, height: 22),
//               ),
//               const SizedBox(width: 8),
//               CircleAvatar(
//                 radius: 16,
//                 backgroundColor: AppColors.grey300,
//                 child: Text(
//                   "387",
//                   style: sfProDisplayMedium.copyWith(
//                       color: Colors.white, fontSize: 12),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () => controller.closeAlert(context),
//                 child: const CircleAvatar(
//                   radius: 16,
//                   backgroundColor: AppColors.grey300,
//                   child: Icon(Icons.close, color: Colors.white, size: 20),
//                 ),
//               ),
//               // const SizedBox(width: 10),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 13, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Color(0XFFFDA949),
//                         borderRadius: BorderRadius.circular(19),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(AppImagePath.gemStone1,
//                               width: 10, height: 10),
//                           const SizedBox(width: 4),
//                           Text(
//                             'Top Score',
//                             style: sfProDisplayMedium.copyWith(
//                                 color: Colors.white, fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       padding: const EdgeInsets.only(
//                           left: 12, right: 8, top: 6, bottom: 6),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(19),
//                         color: AppColors.grey300,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'For You',
//                             style: sfProDisplayMedium.copyWith(
//                                 color: Colors.white, fontSize: 13),
//                           ),
//                           const SizedBox(width: 5),
//                           const Icon(Icons.arrow_forward_ios_outlined,
//                               size: 13, color: Colors.white),

//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../../../../../view_model/live_controller.dart';
import '../../../../../utils/Utils.dart';
import '../../../../../utils/routes/app_routes.dart';
import '../../single_live_streaming/single_audience_live/widgets/audience_detail_sheet.dart';
import '../../single_live_streaming/single_audience_live/widgets/audience_list_sheet.dart';
import '../../single_live_streaming/single_audience_live/widgets/gift_wish_sheet.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';

class AudioLiveTopBar extends StatefulWidget {
  AudioLiveTopBar();

  @override
  State<AudioLiveTopBar> createState() => _AudioLiveTopBarState();
}

class _AudioLiveTopBarState extends State<AudioLiveTopBar> {
  final LiveViewModel liveViewModel = Get.find();

  @override
  void initState() {
    liveViewModel.subscribeLiveStreamingModel();
    super.initState();
  }

  @override
  void dispose() {
    liveViewModel.unSubscribeLiveStreamingModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveViewModel>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: liveViewModel.isMultiGuest ? 10.w : 0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 0, right: liveViewModel.role==ZegoLiveRole.audience ? 0 : 6, top: 3, bottom: 3),
                      constraints: BoxConstraints(
                          minWidth: 120.w
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.grey300,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: AppColors.grey500,
                                builder: (context) => AudienceDetailSheet(liveViewModel.liveStreamingModel.getAuthor!),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!, ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '🦊 ${liveViewModel.role==ZegoLiveRole.audience ? liveViewModel.liveStreamingModel.getAuthor!.getFirstName : liveViewModel.liveStreamingModel.getAuthor!.getFullName}',
                                      style: sfProDisplayMedium.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Image.asset(AppImagePath.diamondIcon, width: 14, height: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          liveViewModel.liveStreamingModel.getAuthor!.getCoins.toString() ,
                                          style: sfProDisplayMedium.copyWith(
                                            fontSize: 12,
                                            color: AppColors.yellowColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if(liveViewModel.role==ZegoLiveRole.audience)
                            const SizedBox(width: 5),
                          if(liveViewModel.role==ZegoLiveRole.audience)
                            Image.asset(AppImagePath.badge, width: 28, height: 28),
                          SizedBox(width: liveViewModel.role==ZegoLiveRole.audience ? 5 : 12),
                          if(liveViewModel.role==ZegoLiveRole.audience)
                            Container(
                              width: 40,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10, right: 8),
                    //   child: Image.asset(AppImagePath.profileBorder, width: 60, height: 60),
                    // ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 28),
                          child: Image.asset(AppImagePath.topPerson3, width: 36, height: 36),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Image.asset(AppImagePath.topPerson2, width: 36, height: 36),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppImagePath.topPerson1, width: 36, height: 36),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.grey300,
                  child: Image.asset(AppImagePath.shareIcon, width: 20, height: 20),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: ()=> showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                    backgroundColor: AppColors.grey500,
                    builder: (context) => Wrap(
                      children: [
                        AudienceListSheet(),
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.grey300,
                    child: Text(
                      liveViewModel.liveStreamingModel.getViewersId!.length.toString(),
                      style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    liveViewModel.closeAlert(context);
                  },
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.grey300,
                    child: Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.topFan);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0XFFFDA949),
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppImagePath.gemStone1,
                                width: 10, height: 10),
                            const SizedBox(width: 4),
                            Text(
                              'Top Score',
                              style: sfProDisplayMedium.copyWith(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: AppColors.grey300,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'For You',
                              style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 13),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.arrow_forward_ios_outlined, size: 13, color: Colors.white),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                if(liveViewModel.role==ZegoLiveRole.audience)
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        isScrollControlled: true,
                        backgroundColor: AppColors.wishSheetColor,
                        builder: (context) => Wrap(
                          children: [
                            GiftWishSheet(),
                          ],
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(1.w, 7.h, 6.w, 3.h),
                        width: 107.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.grey300,
                          // boxShadow: [
                          // BoxShadow(
                          //   color: Color(0x3f6949ff),
                          //   offset: Offset(4.w, 8.h),
                          //   blurRadius: 12.r,
                          // ),
                          // ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0.w, 0.h, 2.w, 0.h),
                              child: Image.asset(
                                AppImagePath.wishBadge,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 1.h),
                                    child: Text(
                                      'Wish List',
                                      style: SafeGoogleFont(
                                        'Fredoka One',
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 45.w,
                                    child: LinearProgressIndicator(
                                      value: 0.5,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.yellowColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if(liveViewModel.role!=ZegoLiveRole.audience)
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(3.w, 2.h, 9.w, 0.h),
                          height: 32.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: AppColors.grey300,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0.w, 2.h, 2.w, 0.h),
                                child: Image.asset(
                                  AppImagePath.wishBadge,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 1.h),
                                      child: Text(
                                        'Wish List',
                                        style: SafeGoogleFont(
                                          'Fredoka One',
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: sfProDisplayRegular.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffffffff),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Add ',
                                            style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '>',
                                            style: SafeGoogleFont(
                                              'DM Sans',
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}