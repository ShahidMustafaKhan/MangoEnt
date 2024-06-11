import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/battle_controller.dart';

import '../../../../../../utils/Utils.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/routes/app_routes.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../../../../../view_model/userViewModel.dart';
import '../../../widgets/wishList_streamer_sheet.dart';
import 'audience_detail_sheet.dart';
import 'audience_list_sheet.dart';
import 'gift_wish_sheet.dart';

class AudienceTopBar extends StatefulWidget {
  AudienceTopBar(this.liveViewModel, this.battleViewModel);
  final LiveViewModel liveViewModel;
  final BattleViewModel battleViewModel;
  @override
  State<AudienceTopBar> createState() => _AudienceTopBarState();
}

class _AudienceTopBarState extends State<AudienceTopBar> {

  @override
  void initState() {
    Get.find<LiveViewModel>().subscribeLiveStreamingModel();
    super.initState();
  }

  @override
  void dispose() {
    Get.find<LiveViewModel>().unSubscribeLiveStreamingModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (userViewModel) {
          return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 4, right: widget.liveViewModel.role==ZegoLiveRole.audience ? 3 : 6, top: 3, bottom: 3),
                        margin: const EdgeInsets.only(top: 0, left: 6),
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
                                  builder: (context) => AudienceDetailSheet(widget.liveViewModel.liveStreamingModel.getAuthor!),
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundColor: AppColors.grey300,
                                    backgroundImage: NetworkImage(widget.liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!, ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '🦊 ${widget.liveViewModel.role==ZegoLiveRole.audience ? widget.liveViewModel.liveStreamingModel.getAuthor!.getFirstName : widget.liveViewModel.liveStreamingModel.getAuthor!.getFullName}',
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
                                            widget.liveViewModel.liveStreamingModel.getAuthor!.getDiamondsTotal.toString() ,
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
                            if(widget.liveViewModel.role==ZegoLiveRole.audience)
                            const SizedBox(width: 5),
                            if(widget.liveViewModel.role==ZegoLiveRole.audience)
                            Image.asset(AppImagePath.badge, width: 28, height: 28),
                            SizedBox(width: widget.liveViewModel.role==ZegoLiveRole.audience ? 5 : 12),
                            if(widget.liveViewModel.role==ZegoLiveRole.audience && !userViewModel.followingUser(widget.liveViewModel.liveStreamingModel.getAuthor!) )
                            GestureDetector(
                              onTap:(){
                                userViewModel.followOrUnFollow(widget.liveViewModel.liveStreamingModel.getAuthor!.objectId!);
                              },
                              child: Container(
                                width: 40,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.yellowColor,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                            if(widget.liveViewModel.role==ZegoLiveRole.audience && userViewModel.followingUser(widget.liveViewModel.liveStreamingModel.getAuthor!) )
                              GestureDetector(
                                onTap: ()=>  userViewModel.followOrUnFollow(widget.liveViewModel.liveStreamingModel.getAuthor!.objectId!),
                                child: Container(
                                  width: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                                  child: Image.asset(AppImagePath.filterStar),
                                ),
                              ),
                          ],
                        ),
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
                        widget.liveViewModel.liveStreamingModel.getViewersId!.length.toString(),
                        style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      widget.liveViewModel.closeAlert(context);
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.grey300,
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.topFan);
                        },
                        child: Container(
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
                                'Top Score',
                                style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 13),
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
                  if(widget.battleViewModel.isBattleView==false && widget.liveViewModel.role==ZegoLiveRole.audience && widget.liveViewModel.liveStreamingModel.getDisableWishList==false)
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 4, right: 12, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: AppColors.grey300,
                            ),
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImagePath.wishBadge, width: 50, height: 50),
                                const SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wish List',
                                      style: sfProDisplayBlack.copyWith(color: Colors.white, fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: LinearPercentIndicator(
                                        animation: true,
                                        padding: const EdgeInsets.all(0),
                                        lineHeight: 5.0,
                                        width: 70,
                                        animationDuration: 2500,
                                        percent: 0.7,
                                        barRadius: const Radius.circular(10),
                                        progressColor: AppColors.yellowColor,
                                        backgroundColor: AppColors.greyColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(widget.battleViewModel.isBattleView==false && widget.liveViewModel.role!=ZegoLiveRole.audience && widget.liveViewModel.liveStreamingModel.getDisableWishList==false)
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: ()=> showModalBottomSheet(
                            isScrollControlled : true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return WishListStreamerSheet(); }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(1.w, 6.h, 8.w, 3.h),
                              margin: EdgeInsets.only(top: 4.h),
                              height: 45.h,
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
                                        Row(
                                          children: [
                                            Text(
                                              'Add',
                                              style: SafeGoogleFont (
                                                'DM Sans',
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            Icon(Icons.chevron_right, size: 16.w,)

                                          ],
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
}