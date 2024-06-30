import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/screen_recording_sheet.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/settings_sheet.dart';
import 'package:teego/view/screens/live/widgets/subscrption/susbcription_audience_sheet.dart';
import 'package:teego/view/screens/live/widgets/whisper/whisper_chat.dart';
import 'package:teego/view_model/subscription_model.dart';

import '../../../../helpers/quick_actions.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../../../../view_model/zego_controller.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import 'basic_feature_sheets/live_setting_sheet.dart';
import 'basic_feature_sheets/manage_modal.dart';


class BasicAudienceFeatureSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SubscriptionViewModel subscriptionViewModel = Get.find();
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    subscriptionViewModel.getSubscribee();
    subscriptionViewModel.getExpiredSubscription();
    bool isAudioLive = liveViewModel.isAudioLive;
    return SizedBox(
      height: 320,
      child: Padding(
        padding: EdgeInsets.only(left: 16 , right: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Basic Features',
              style: sfProDisplaySemiBold.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
                openBottomSheet(Subscribe(), context);
                },
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset(AppImagePath.subscriber, width: 50, height: 50),
                      const SizedBox(height: 11),
                      Text(
                        'Subscriber',
                        style: sfProDisplayRegular.copyWith(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Other',
              style: sfProDisplaySemiBold.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            GetBuilder<SubscriptionViewModel>(
                init: subscriptionViewModel,
                builder: (subscriptionViewModel) {
                  return ValueListenableBuilder<ZegoLiveRole>(
                      valueListenable: ZegoLiveStreamingManager.instance.currentUserRoleNoti,
                      builder: (context, role, _) {
                        return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  Get.find<LiveViewModel>().toggleDislike=Get.find<LiveViewModel>().dislike.value;
                                },
                                child: ToolWidget(title: 'Dislike', icon: AppImagePath.dislikeIcon, color: Get.find<LiveViewModel>().dislike.value ? AppColors.yellowBtnColor : null,),
                              );
                            }
                          ),
                          if(Get.find<SubscriptionViewModel>().isStreamerSubscribed(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!)==true)
                            SizedBox(width: 32),
                          if(Get.find<SubscriptionViewModel>().isStreamerSubscribed(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!)==true)
                          GestureDetector(
                              onTap: (){openBottomSheet( WhisperChat(
                                  Get.find<LiveViewModel>().liveStreamingModel.getAuthor), context);},
                              child: ToolWidget(title: 'Whispers', icon: AppImagePath.whisperIcon)),
                          if(role == ZegoLiveRole.coHost && isAudioLive == false)
                            SizedBox(width: 32),
                          if(role == ZegoLiveRole.coHost && isAudioLive == false)
                          ValueListenableBuilder<bool>(
                              valueListenable: zegoController.expressService.currentUser!.isCamerOnNotifier,
                              builder: (context, cameraOn, _) {
                                return GestureDetector(
                                    onTap: ()=> ZEGOSDKManager.instance.expressService.turnCameraOn(!cameraOn),
                                    child: ToolWidget(title: cameraOn ? 'OFF' : 'ON', icon: AppImagePath.cameraOff, color: cameraOn ? null : AppColors.yellowColor));
                              }
                          ),
                          if(role == ZegoLiveRole.coHost && isAudioLive == false)
                            SizedBox(width: 32),
                          if(role == ZegoLiveRole.coHost && isAudioLive == false)
                            GestureDetector(
                                onTap : (){
                                  final user = zegoController.expressService.currentUser!;
                                  user.isCameraFront.value= !user.isCameraFront.value;
                                  ZEGOSDKManager.instance.expressService.useFrontCamera(user.isCameraFront.value);
                                },
                                child: ToolWidget(title: 'Switch', icon: AppImagePath.switchIcon)),
                          SizedBox(width: 32),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor: AppColors.grey500,
                                builder: (context) => ScreenRecordingSheet(),
                              );
                            },
                            child: ToolWidget(title: 'Record', icon: AppImagePath.recordIcon),
                          ),
                          SizedBox(width: 32),
                          if(Get.find<LiveViewModel>().isCurrentUserInAdminList()==true)
                          GestureDetector(
                            onTap: ()=> openBottomSheet(ManageModalSheet(initialTab: 'Disable Chat'), context, back: true),
                            child:  ToolWidget(title: 'Admin', icon: AppImagePath.admin ),

                          ),
                          if(Get.find<LiveViewModel>().isCurrentUserInAdminList()==true)
                            SizedBox(width: 32),
                          GestureDetector(
                            onTap: ()=> openBottomSheet(LiveSettingSheet(), context, back: true),
                            child: ToolWidget(title: 'Setting', icon: AppImagePath.settings),
                          ),
                          SizedBox(width: 32),
                        ],
                      ),
                );
                    }
                  );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class ToolWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? color;


  const ToolWidget({
    required this.title,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.darkBlue,
          ),
          child: Image.asset(icon, width: 28, height: 28, color: color,),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: sfProDisplayRegular.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
