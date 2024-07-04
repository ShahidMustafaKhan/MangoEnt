import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/parse/LiveMessagesModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/bottom_bar.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/chat_feature.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/top_bar.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/live_messages_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/battle_controller.dart';
import '../../../../../../view_model/whisper_list_controller.dart';
import '../../../../../widgets/custom_buttons.dart';
import '../../../multi_live_streaming/widgets/gift_received_widget.dart';
import '../../../widgets/background_image.dart';
import '../../../widgets/chat_text_field.dart';
import '../../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../../widgets/audience_bottom_bar.dart';
import '../../../widgets/audience_top_bar.dart';
import 'battle/animations/versus_animation.dart';
import 'battle/battle_view.dart';

class SingleStreamerLiveItemWidget extends StatelessWidget {

  SingleStreamerLiveItemWidget();


  @override
  Widget build(BuildContext context) {
    WhisperListViewModel whisperListViewModel = Get.put(WhisperListViewModel());

    final BattleViewModel battleViewModel = Get.find();
    final AnimationViewModel animationViewModel = Get.find();
    final LiveMessagesViewModel liveMessagesViewModel = Get.find();
    return GetBuilder<LiveViewModel>(builder: (liveViewModel)  {
      return  GetBuilder<BattleViewModel>(builder: (battleViewModel)  {
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 45),
                   AudienceTopBar(liveViewModel,  battleViewModel),
                    const SizedBox(height: 10),
                    if (battleViewModel.isBattleView)
                    BattleView(),
                    if (battleViewModel.isBattleView==false)
                      const Spacer(),
                    if (battleViewModel.isBattleView == false)
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 10.w),
                        child: ChatFeature(height: 200,),
                    ),
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
                            child: Obx(() {
                                return Column(
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
                                                padding: EdgeInsets.only(left: 15.w, right: 10.w,bottom: 10.h),
                                                child: ChatFeature(height: 200,),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap :(){
                                            Get.toNamed(AppRoutes.store);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(top:15.h),
                                            child: Image.asset(AppImagePath.shopIcon, height: 125.h, width: 105.w),
                                          ),
                                        ),
                                        SizedBox(width: Get.width*0.04),
                                      ],
                                    ),
                                    // SizedBox(height: 16.w),
                                    if(liveViewModel.chatField.value==false)
                                      liveViewModel.role== ZegoLiveRole.host ? BottomBar() : AudienceBottomBar(),
                                    if(liveViewModel.chatField.value==false)
                                      SizedBox(height: 20),
                                    if(liveViewModel.chatField.value==true)
                                      SizedBox(height: 67.h),
                                  ],
                                );
                              }
                            ),
                          ),
                        ),
                      ),
                          ),
                    if (battleViewModel.isBattleView == false)
                      Obx(() {
                          return Column(
                            children: [
                              SizedBox(height: 16),
                              if(liveViewModel.chatField.value==false)
                              liveViewModel.role== ZegoLiveRole.host ? BottomBar() : AudienceBottomBar(),
                              if(liveViewModel.chatField.value==true)
                                ChatTextField(),
                              if(liveViewModel.chatField.value==false)
                              SizedBox(height: 20),
                            ],
                          );
                        }
                      ),
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
