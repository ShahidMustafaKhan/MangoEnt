import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/Utils.dart';
import '../../../../../../../view_model/live_controller.dart';
import '../../../../../../../view_model/battle_controller.dart';
import '../../../single_audience_live/widgets/audience_detail_sheet.dart';




class TopBar extends StatefulWidget {
  TopBar();

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final LiveViewModel liveViewModel = Get.find();


  @override
  void initState() {
    liveViewModel.subscribeLiveStreamingModel();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    liveViewModel.unSubscribeLiveStreamingModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (controller) {
          return GetBuilder<BattleViewModel>(builder: (streamerViewModel) {
              return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                margin: const EdgeInsets.only(top: 0, left: 6),
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
                                          const CircleAvatar(
                                            radius: 17,
                                            backgroundColor: AppColors.grey300,
                                            backgroundImage: AssetImage(AppImagePath.cardImage2),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '🦊 LLOUISE',
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
                                                    '8811M',
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
                                    const SizedBox(width: 5),
                                    Image.asset(AppImagePath.badge, width: 28, height: 28),
                                    const SizedBox(width: 5),
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
                        radius: 16,
                        backgroundColor: AppColors.grey300,
                        child: Image.asset(AppImagePath.shareIcon, width: 22, height: 22),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.grey300,
                        child: Text(
                          controller.liveStreamingModel.getViewersId!.length.toString(),
                          style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: ()=> controller.closeAlert(context),
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.grey300,
                          child: Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.lightPurple, AppColors.darkPurple],
                              ),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppImagePath.gemStone, width: 10, height: 10),
                                const SizedBox(width: 4),
                                Text(
                                  'Top Fans',
                                  style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.only(left: 12, right: 8, top: 6, bottom: 6),
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
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      if(streamerViewModel.isBattleView==false)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(1.w, 7.h, 6.w, 3.h),
                          width: 107.w,
                          height: 43.h,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.grey300,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f6949ff),
                                offset: Offset(4.w, 8.h),
                                blurRadius: 12.r,
                              ),
                            ],
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
                                        style: SafeGoogleFont (
                                          'Fredoka One',
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: sfProDisplayRegular.copyWith (
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffffffff),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Add ',
                                            style: SafeGoogleFont (
                                              'DM Sans',
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '>',
                                            style: SafeGoogleFont (
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
                      ),
                    ],
                  ),
                ),
              ],
        );
            }
          );
      }
    );
  }
}
