import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/youtube_sheet.dart';
import 'package:teego/view/screens/live/widgets/beauty_filters_sheets/sticker_modal_sheets.dart';
import 'package:teego/view/screens/live/widgets/subscrption/subscriber_sheet.dart';
import 'package:teego/view/screens/live/widgets/whisper/whisper_modal.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../helpers/quick_actions.dart';
import '../single_live_streaming/single_streamer_live/single_live_screen/widgets/room_announcement_sheet.dart';
import 'basic_feature_sheets/data_sheet.dart';
import 'basic_feature_sheets/filter_words.dart';
import 'basic_feature_sheets/live_setting_sheet.dart';
import 'basic_feature_sheets/local_music.dart';
import 'basic_feature_sheets/manage.dart';
import 'basic_feature_sheets/manage_modal.dart';
import 'boost_sheet.dart';
import 'wishList_streamer_sheet.dart';
import '../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../single_live_streaming/single_audience_live/widgets/screen_recording_sheet.dart';
import '../single_live_streaming/single_audience_live/widgets/settings_sheet.dart';

class BasicFeatureSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    bool isMultiGuest = liveViewModel.isMultiGuest;
    bool isAudioLive = liveViewModel.isAudioLive;
    bool isSingleLive = liveViewModel.isSingleLive;
    bool isMultiSeat3 = liveViewModel.isMultiSeat3;
    bool isMultiSeat4 = liveViewModel.isMultiSeat4;
    bool isMultiSeat6 = liveViewModel.isMultiSeat6;
    bool isMultiSeat9 = liveViewModel.isMultiSeat9;
    bool isMultiSeat12 = liveViewModel.isMultiSeat12;
    bool isAudioSeat9 = liveViewModel.liveStreamingModel.getAudioSeats == 8;
    bool isAudioSeat12 = liveViewModel.liveStreamingModel.getAudioSeats == 11;
    return Container(
      child: GetBuilder<LiveViewModel>(
          init: liveViewModel,
          builder: (controller) {
            return Padding(
            padding: const EdgeInsets.only(left: 16, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Basic Features',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                        showModalBottomSheet(
                            isScrollControlled : true,
                            backgroundColor: Colors.transparent,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.vertical(
                            //     top: Radius.circular(20*fem), // Set the radius for the top border
                            //   ),),
                            context: context,
                            builder: (BuildContext context) {
                              return WishListStreamerSheet(); });
                      },
                      child: Column(
                        children: [
                          Image.asset(AppImagePath.wishBadge, width: 80, height: 60),
                          Text(
                            'Wish List',
                            style: sfProDisplayRegular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap:(){
                        Get.back();
                        openBottomSheet(SubscriberSheet(), context);
                      },
                      child: Column(
                        children: [
                          Image.asset(AppImagePath.subscriber, width: 50, height: 50),
                          const SizedBox(height: 11),
                          Text(
                            'Subscriber',
                            style: sfProDisplayRegular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 37),
                    if(isMultiGuest)
                    InkWell(
                      onTap: (){
                        Get.back();
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          backgroundColor: AppColors.white,
                          isScrollControlled : true,
                          builder: (context) => YoutubeSheet(),
                        );
                        // if(liveViewModel.liveStreamingModel.getYoutube == false)
                        // liveViewModel.setYoutube(true);
                        // else
                        //   liveViewModel.setYoutube(false);

                      },
                      child: Column(
                        children: [
                          Image.asset(AppImagePath.youtube, width: 50, height: 50, fit: BoxFit.cover,),
                          const SizedBox(height: 11),
                          Text(
                            "Youtube",
                            style: sfProDisplayRegular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Tools',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // if(isMultiGuest)
                      // ToolWidget(title: 'Boost', icon: "assets/png/streamer/boost.png", onTap: ()=> openBottomSheet(BoostSheet(), context, back: true),),
                      // if(isMultiGuest)
                      //   SizedBox(width: 32),
                      ToolWidget(title: 'Filter word', icon: AppImagePath.filterWord, onTap: ()=> openBottomSheet(FilterWordWidget(), context, back: true)),
                      if(isMultiGuest && !isMultiSeat3)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat3)
                        ToolWidget(title: '3P', icon: AppImagePath.sofa, onTap: () => liveViewModel.changeMultiGuestSeatView(3)),
                      if(isMultiGuest && !isMultiSeat4)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat4)
                        ToolWidget(title: '4P', icon: AppImagePath.sofa, onTap: () => liveViewModel.changeMultiGuestSeatView(4),),
                      if(isMultiGuest && !isMultiSeat6)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat6)
                        ToolWidget(title: '6P', icon: AppImagePath.sofa, onTap: () => liveViewModel.changeMultiGuestSeatView(6),),
                      if((isAudioLive &&  !isAudioSeat9) || (isMultiGuest && !isMultiSeat9))
                        SizedBox(width: 32),
                      if((isAudioLive &&  !isAudioSeat9) ||  (isMultiGuest && !isMultiSeat9))
                        ToolWidget(title: '9P', icon: AppImagePath.sofa, onTap: () => liveViewModel.changeMultiGuestSeatView(9)),
                      if((isAudioLive &&  !isAudioSeat12)  || (isMultiGuest && !isMultiSeat12))
                        SizedBox(width: 32),
                      if((isAudioLive &&  !isAudioSeat12)  || (isMultiGuest && !isMultiSeat12))
                        ToolWidget(title: '12P', icon: AppImagePath.sofa, onTap: () => isAudioLive ? liveViewModel.changeAudioSeatView(12) :liveViewModel.changeMultiGuestSeatView(12)),
                        SizedBox(width: 32),
                      ToolWidget(title: 'Beauty', icon: AppImagePath.beauty, onTap: ()=> openBottomSheet(StickerModalSheet(), context, back: true)),
                      SizedBox(width: 32),
                      ToolWidget(title: 'BGM', icon: AppImagePath.bgm, onTap: ()=> openBottomSheet(LocalMusicWidget(), context, back: true)),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Whispers', icon: AppImagePath.whisper, onTap: ()=> openBottomSheet(WhisperModal(), context, back: true)),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Announcement', icon: AppImagePath.announcement, onTap: ()=> showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: AppColors.grey500,
                        builder: (context) => const RoomAnnouncementSheet(),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Other',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if(!isAudioLive)
                      ValueListenableBuilder<bool>(
                          valueListenable: zegoController.expressService.currentUser!.isCamerOnNotifier,
                          builder: (context, cameraOn, _) {
                            return ToolWidget(title: cameraOn ? 'OFF' : 'ON', icon: AppImagePath.cameraOff, iconColor: cameraOn ? null : AppColors.yellowColor, onTap: ()=> ZEGOSDKManager.instance.expressService.turnCameraOn(!cameraOn),);
                        }
                      ),
                      if(!zegoController.expressService.isSharingScreen.value && !isAudioLive && !isSingleLive)
                        SizedBox(width: 32),
                      if(!zegoController.expressService.isSharingScreen.value && !isAudioLive && !isSingleLive)
                      ToolWidget(title: 'Share Screen', icon: AppImagePath.screenShare, onTap: (){
                        if(!zegoController.expressService.isSharingScreen.value){
                          Get.back();
                          zegoController.startScreenSharing();
                        }
                      },),
                      if(!isAudioLive)
                        SizedBox(width: 32),
                      if(!isAudioLive)
                      ToolWidget(title: 'Switch', icon: AppImagePath.switchIcon, onTap: (){
                        final user = zegoController.expressService.currentUser!;
                        user.isCameraFront.value= !user.isCameraFront.value;
                        ZEGOSDKManager.instance.expressService.useFrontCamera(user.isCameraFront.value);
                      },),
                      if(!isAudioLive)
                        SizedBox(width: 32),
                      ValueListenableBuilder<bool>(
                          valueListenable: zegoController.expressService.currentUser!.isMicOnNotifier,
                          builder: (context, micOn, _) {
                            return ToolWidget(title: "Mic", icon: micOn ? AppImagePath.micOn: AppImagePath.micOff, onTap: (){
                            final user = zegoController.expressService.currentUser!;
                            user.isMicOnNotifier.value= !user.isMicOnNotifier.value;
                            ZEGOSDKManager.instance.expressService.turnMicrophoneOn(user.isMicOnNotifier.value);
                          },);
                        }
                      ),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Data', icon: AppImagePath.dataIcon, onTap: ()=> openBottomSheet(DataSheetWidget(), context, back: true) ),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Record', icon: AppImagePath.recordIcon, onTap: ()=> openBottomSheet(ScreenRecordingSheet(), context, back: true)),
                      SizedBox(width: 32),
                      // ToolWidget(title: 'Mirror', icon: AppImagePath.mirrorIcon),
                      // SizedBox(width: 32),
                      ToolWidget(title: 'Admin', icon: AppImagePath.admin , onTap: ()=> openBottomSheet(ManageModalSheet(initialTab: 'Disable Chat'), context, back: true),),
                      SizedBox(width: 32),
                      GestureDetector(
                          onTap: (){
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
                              builder: (context) => SettingsSheet(),
                            );
                          },
                          child:  ToolWidget(title: 'Setting', icon: AppImagePath.settings, onTap: ()=> openBottomSheet(LiveSettingSheet(), context, back: true))),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,)
              ],
            ),
          );
        }
      ),
    );
  }
}

class ToolWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? iconColor;
  final onTap;

  const ToolWidget({

    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.darkBlue,
            ),
            child: Image.asset(icon, width: 28, height: 28, color: iconColor,),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: sfProDisplayRegular.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
