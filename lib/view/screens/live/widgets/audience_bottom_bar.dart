import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_sheet.dart';
import 'package:teego/view/screens/live/widgets/subscrption/subscriber_sheet.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/zego_controller.dart';


import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../../../../view_model/recording_controller.dart';
import '../audio_live_streaming/widgets/audio_live_invitation_sheet.dart';
import '../single_live_streaming/single_streamer_live/single_live_screen/battle/battle_disconnect_sheet.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import 'subscrption/susbcription_audience_sheet.dart';
import '../single_live_streaming/single_audience_live/share_friends/share_friends_sheet.dart';
import '../single_live_streaming/single_audience_live/widgets/audience_list_sheet.dart';
import 'basic_audience_feature_sheet.dart';

class AudienceBottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    RecordingController recordingController = Get.put(RecordingController());
    BattleViewModel battleViewModel = Get.find();
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    RxBool joined = false.obs;
    return GetBuilder<ZegoController>(
        init: zegoController,
        builder: (zegoController) {
          return ValueListenableBuilder<ZegoLiveRole>(
              valueListenable: ZegoLiveStreamingManager.instance.currentUserRoleNoti,
              builder: (context, role, _) {
                return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: ()=> openBottomSheet(Subscribe(), context),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: Image.asset(AppImagePath.subscriber, width: 25, height: 25),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: (){
                      if(Get.find<LiveViewModel>().isUserInChatDisableList()==true){
                        QuickHelp.showAppNotificationAdvanced(title: 'The streamer has disabled your access to the chat feature.', context: context);
                      }
                      else{
                        Get.find<LiveViewModel>().chatField.value=true;
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: Image.asset(AppImagePath.chat, width: 22, height: 22),
                    ),
                  ),
                  const SizedBox(width: 8),
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
                        backgroundColor: AppColors.grey500,
                        builder: (context) => BasicAudienceFeatureSheet(),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: Image.asset(AppImagePath.menu, width: 25, height: 25),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if(role == ZegoLiveRole.audience)
                  ValueListenableBuilder<bool>(
                      valueListenable: zegoController.isApplyStateNoti,
                      builder: (context, applying, _) {
                      return GestureDetector(
                        onTap: () {
                          if(applying==false)
                          zegoController.applyCoHost();
                          else{
                            showModalBottomSheet(
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
                                  AudioBottomModalSheet(),
                                ],
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: Image.asset(AppImagePath.link, width: 25, height: 25, color: applying==false ? AppColors.white : AppColors.yellowBtnColor,),
                        ),
                      );
                    }
                  ),
                  if(role == ZegoLiveRole.coHost || battleViewModel.isCurrentUserPlayerB==true)
                    if(ZEGOSDKManager.instance.currentUser!=null)
                      ValueListenableBuilder<bool>(
                          valueListenable: ZEGOSDKManager.instance.currentUser!.isMicOnNotifier,
                          builder: (context, isMicOn, _) {
                            return GestureDetector(
                              onTap: () {
                                ZEGOSDKManager.instance.expressService.turnMicrophoneOn(!isMicOn);
                                isMicOn = !isMicOn;
                              },
                              child:
                              CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: Image.asset( AppImagePath.micIcon , width: 25, height: 25, color:  isMicOn ? AppColors.white  : AppColors.yellowBtnColor,),
                              ),
                            );
                          }
                      ),
                  const Spacer(),
                  if(role == ZegoLiveRole.coHost)
                    GestureDetector(
                      onTap: (){
                          zegoController.endCoHost();
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: Image.asset(AppImagePath.end_call, width: 25, height: 25),
                      ),
                    ),

                  if(role == ZegoLiveRole.coHost)
                    const SizedBox(width: 8),
                  if(battleViewModel.isCurrentUserPlayerB==false)
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
                        isScrollControlled: true,
                        backgroundColor: AppColors.grey500,
                        builder: (context) => Wrap(
                          children: [
                            AudienceGiftSheet(battleViewModel: battleViewModel,),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.progressPinkColor,
                            AppColors.progressPinkColor2,
                          ],
                        ),
                      ),
                      child: Image.asset(AppImagePath.giftIcon, width: 25, height: 25),
                    ),
                  ),

                  if(battleViewModel.isCurrentUserPlayerB==true)
                    GestureDetector(
                      onTap: () {
                        if (battleViewModel.isBattleView) {
                          showModalBottomSheet(
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
                                BattleDisconnectSheet(),
                              ],
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.lightOrange,
                              AppColors.darkOrange,
                            ],
                          ),
                        ),
                        child: Image.asset(AppImagePath.sword, width: 25, height: 25),
                      ),
                    )
                ],
              ),
        );
            }
          );
      }
    );
  }
}