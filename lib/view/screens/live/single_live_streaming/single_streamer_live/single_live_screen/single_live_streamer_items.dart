import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/bottom_bar.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/top_bar.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/battle_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../single_audience_live/widgets/audience_bottom_bar.dart';
import '../../single_audience_live/widgets/audience_top_bar.dart';
import 'battle/animations/versus_animation.dart';
import 'battle/battle_view.dart';

class SingleStreamerLiveItemWidget extends StatelessWidget {

  SingleStreamerLiveItemWidget();


  @override
  Widget build(BuildContext context) {
    final BattleViewModel battleViewModel = Get.find();
    final AnimationViewModel animationViewModel = Get.find();
    return GetBuilder<LiveViewModel>(builder: (liveViewModel)  {
      return  GetBuilder<BattleViewModel>(builder: (battleViewModel)  {
            return Column(
              children: [
                SizedBox(height: 45),
               AudienceTopBar(liveViewModel,  battleViewModel),
                const SizedBox(height: 10),
                if (battleViewModel.isBattleView)
                BattleView(),
                if (battleViewModel.isBattleView==false)
                  const Spacer(),
                if (battleViewModel.isBattleView == false)
                ChatFeature(),
                if (battleViewModel.isBattleView)
                  Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width*0.65,
                                  // height: 220.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 8.h),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: ChatFeature(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(top:15.h),
                                  child: Image.asset(AppImagePath.shopIcon, height: 125.h, width: 105.w),
                                ),
                                SizedBox(width: Get.width*0.04),
                              ],
                            ),
                            SizedBox(height: 16.w),
                            liveViewModel.role== ZegoLiveRole.host ? BottomBar() : AudienceBottomBar(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                      ),
                if (battleViewModel.isBattleView == false)
                  Column(
                    children: [
                      SizedBox(height: 16),
                      liveViewModel.role== ZegoLiveRole.host ? BottomBar() : AudienceBottomBar(),
                      SizedBox(height: 20),
                    ],
                  ),
              ],
            );
          }
        );
      }
    );
  }
}
