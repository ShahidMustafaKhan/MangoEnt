import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/zego_controller.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/global_variables.dart';
import '../single_live_streaming/single_audience_live/widgets/audience_gift_sheet.dart';
import 'basic_audience_feature_sheet.dart';
import 'basic_feature_sheet.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../zegocloud/zim_zego_sdk/internal/sdk/zim/Define/zim_room_request.dart';
import '../zegocloud/zim_zego_sdk/live_audio_room_manager.dart';
import '../zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../audio_live_streaming/widgets/audio_live_invitation_sheet.dart';


class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    RoomRequest? myRoomRequest;
    return GetBuilder<ZegoController>(
        init: zegoController,
        builder: (zegoController) {
          return ValueListenableBuilder<ZegoLiveRole>(
              valueListenable: liveViewModel.isAudioLive ? ZegoLiveAudioRoomManager.instance.roleNoti :  ZegoLiveStreamingManager.instance.currentUserRoleNoti,
              builder: (context, role, _) {
                return Row(
                  children: [
                    if(liveViewModel.role == ZegoLiveRole.audience)
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: Image.asset(AppImagePath.subscriber, width: 25, height: 25),
                        ),
                      ),
                    if(liveViewModel.role == ZegoLiveRole.audience)
                      const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: Image.asset(AppImagePath.chat, width: 22, height: 22),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: AppColors.grey900,
                          builder: (context) => liveViewModel.role == ZegoLiveRole.audience ? BasicAudienceFeatureSheet() : BasicFeatureSheet(),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: Image.asset(AppImagePath.menu, width: 25, height: 25),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if(role != ZegoLiveRole.audience)
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
                    if(role == ZegoLiveRole.host)
                      ValueListenableBuilder(
                          valueListenable:
                          ZEGOSDKManager.instance.zimService.roomRequestMapNoti,
                          builder: (context, Map<String, dynamic> requestMap, _) {
                            return GestureDetector(
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
                                  backgroundColor: AppColors.grey500,
                                  builder: (context) => Wrap(
                                    children: [
                                      AudioBottomModalSheet(),
                                    ],
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: SvgPicture.asset(AppImagePath.sofaFilled, width: 32, height: 32, color: requestMap.isNotEmpty ? AppColors.yellowColor : AppColors.white,),
                              ),
                            );
                          }
                      ),
                    if(role == ZegoLiveRole.audience)
                      ValueListenableBuilder<bool>(
                          valueListenable: zegoController.isApplyStateNoti,
                          builder: (context, applying, _) {
                            if(applying==false)
                              return GestureDetector(
                                onTap: (){
                                  if(liveViewModel.isAudioLive) {
                                    final senderMap = {
                                      'room_request_type': RoomRequestType
                                          .audienceApplyToBecomeCoHost
                                    };
                                    ZEGOSDKManager.instance.zimService
                                        .sendRoomRequest(
                                        zegoController.liveAudioRoomManager
                                            .hostUserNoti.value?.userID ?? '',
                                        jsonEncode(senderMap))
                                        .then((value) {
                                      zegoController.isApplyStateNoti.value =
                                      true;
                                      zegoController.currentRequestID =
                                          value.requestID;
                                    });
                                  }
                                  else if (liveViewModel.isMultiGuest)
                                    zegoController.applyCoHost();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(AppImagePath.hand_wave, height: 24.w, width: 24.w,),
                                      SizedBox(width: 6.w,),
                                      Text('Join', style: sfProDisplayRegular.copyWith(
                                        fontSize: 14.sp,
                                      ),)
                                    ],
                                  ),
                                ),
                              );
                            else
                              return GestureDetector(
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
                                    backgroundColor: AppColors.grey500,
                                    builder: (context) => Wrap(
                                      children: [
                                        AudioBottomModalSheet(),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(AppImagePath.hand_wave, height: 24.w, width: 24.w,color: AppColors.yellowColor,),
                                      SizedBox(width: 6.w,),
                                      Text('Waiting', style: sfProDisplayRegular.copyWith(
                                        fontSize: 14.sp,
                                      ),)
                                    ],
                                  ),
                                ),
                              );

                          }
                      ),
                    if(role == ZegoLiveRole.coHost)
                      GestureDetector(
                        onTap: (){
                          if(liveViewModel.isAudioLive)
                          for (final element in zegoController.liveAudioRoomManager.seatList) {
                            if (element.currentUser.value?.userID ==
                                ZEGOSDKManager.instance.currentUser?.userID) {
                              zegoController.liveAudioRoomManager.leaveSeat(element.seatIndex).then((value) {
                                zegoController.liveAudioRoomManager.roleNoti.value = ZegoLiveRole.audience;
                                zegoController.isApplyStateNoti.value = false;
                                ZEGOSDKManager().expressService.stopPublishingStream();
                              });
                            }
                          }
                          else if(liveViewModel.isMultiGuest)
                            zegoController.endCoHost();
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: Image.asset(AppImagePath.end_call, width: 32, height: 32),
                        ),
                      ),
                    if(liveViewModel.role == ZegoLiveRole.audience)
                      SizedBox(width: 8,),
                    if(liveViewModel.role != ZegoLiveRole.host)
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
                                AudienceGiftSheet(),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          margin: EdgeInsets.only(bottom: 4),
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
                      )

                  ],
                );
            }
          );
      }
    );
  }
}
