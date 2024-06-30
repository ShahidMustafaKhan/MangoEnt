import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/youtube_sheet.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../../../single_audience_live/widgets/screen_recording_sheet.dart';
import '../../../single_audience_live/widgets/settings_sheet.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Column(
                      children: [
                        Image.asset(AppImagePath.wishBadge, width: 80, height: 60),
                        Text(
                          'Wish List',
                          style: sfProDisplayRegular.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Image.asset(AppImagePath.subscriber, width: 50, height: 50),
                        const SizedBox(height: 11),
                        Text(
                          'Subscriber',
                          style: sfProDisplayRegular.copyWith(fontSize: 12),
                        ),
                      ],
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
                      if(isMultiGuest)
                      ToolWidget(title: 'Boost', icon: AppImagePath.boost),
                      if(isMultiGuest)
                        SizedBox(width: 32),
                      ToolWidget(title: 'Filter word', icon: AppImagePath.filterWord),
                      if(isMultiGuest && !isMultiSeat3)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat3)
                        GestureDetector(
                            onTap: () => liveViewModel.changeMultiGuestSeatView(3),
                            child: ToolWidget(title: '3P', icon: AppImagePath.sofa)),
                      if(isMultiGuest && !isMultiSeat4)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat4)
                        GestureDetector(
                            onTap: () => liveViewModel.changeMultiGuestSeatView(4),
                            child: ToolWidget(title: '4P', icon: AppImagePath.sofa)),
                      if(isMultiGuest && !isMultiSeat6)
                        SizedBox(width: 32),
                      if(isMultiGuest && !isMultiSeat6)
                        GestureDetector(
                            onTap: () => liveViewModel.changeMultiGuestSeatView(6),
                            child: ToolWidget(title: '6P', icon: AppImagePath.sofa)),
                      if((isAudioLive &&  !isAudioSeat9) || (isMultiGuest && !isMultiSeat9))
                        SizedBox(width: 32),
                      if((isAudioLive &&  !isAudioSeat9) ||  (isMultiGuest && !isMultiSeat9))
                        GestureDetector(
                            onTap: () => isAudioLive ? liveViewModel.changeAudioSeatView(9) :liveViewModel.changeMultiGuestSeatView(9),
                            child: ToolWidget(title: '9P', icon: AppImagePath.sofa)),
                      if((isAudioLive &&  !isAudioSeat12)  || (isMultiGuest && !isMultiSeat12))
                        SizedBox(width: 32),
                      if((isAudioLive &&  !isAudioSeat12)  || (isMultiGuest && !isMultiSeat12))
                        GestureDetector(
                            onTap: () => isAudioLive ? liveViewModel.changeAudioSeatView(12) :liveViewModel.changeMultiGuestSeatView(12),
                            child: ToolWidget(title: '12P', icon: AppImagePath.sofa)),
                        SizedBox(width: 32),
                      ToolWidget(title: 'Beauty', icon: AppImagePath.beauty),
                      SizedBox(width: 32),
                      ToolWidget(title: 'BGM', icon: AppImagePath.bgm),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Whispers', icon: AppImagePath.whisper),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Announcement', icon: AppImagePath.announcement),
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
                            return GestureDetector(
                                onTap: ()=> ZEGOSDKManager.instance.expressService.turnCameraOn(!cameraOn),
                                child: ToolWidget(title: cameraOn ? 'OFF' : 'ON', icon: AppImagePath.cameraOff, iconColor: cameraOn ? null : AppColors.yellowColor,));
                        }
                      ),
                      if(!zegoController.expressService.isSharingScreen.value && !isAudioLive && !isSingleLive)
                        SizedBox(width: 32),
                      if(!zegoController.expressService.isSharingScreen.value && !isAudioLive && !isSingleLive)
                      GestureDetector(onTap: (){
                        if(!zegoController.expressService.isSharingScreen.value){
                          Get.back();
                          zegoController.startScreenSharing();
                        }
                      }, child: ToolWidget(title: 'Share Screen', icon: AppImagePath.screenShare)),
                      if(!isAudioLive)
                        SizedBox(width: 32),
                      if(!isAudioLive)
                      GestureDetector(
                          onTap: (){
                            final user = zegoController.expressService.currentUser!;
                            user.isCameraFront.value= !user.isCameraFront.value;
                            ZEGOSDKManager.instance.expressService.useFrontCamera(user.isCameraFront.value);
                          },
                          child: ToolWidget(title: 'Switch', icon: AppImagePath.switchIcon)),
                      if(!isAudioLive)
                        SizedBox(width: 32),
                      ToolWidget(title: 'Data', icon: AppImagePath.dataIcon),
                      SizedBox(width: 32),
                      InkWell(
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
                          child: ToolWidget(title: 'Record', icon: AppImagePath.recordIcon)),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Mirror', icon: AppImagePath.mirrorIcon),
                      SizedBox(width: 32),
                      ToolWidget(title: 'Admin', icon: AppImagePath.admin),
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
                          child:  ToolWidget(title: 'Setting', icon: AppImagePath.settings)),
                    ],
                  ),
                ),
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

  const ToolWidget({

    required this.title,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
