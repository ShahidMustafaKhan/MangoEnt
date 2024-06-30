import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/app_constants.dart';

import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../../../widgets/custom_buttons.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../../zegocloud/zim_zego_sdk/live_audio_room_manager.dart';

class GuestsWidget extends StatefulWidget {
  const GuestsWidget();

  @override
  State<GuestsWidget> createState() => _GuestsWidgetState();
}

class _GuestsWidgetState extends State<GuestsWidget> {
  final ZegoController zegoController = Get.find();
  List<ZegoSDKUser> userList = [];

  @override
  void initState() {

    if(zegoController.streamingType == LiveStreamingModel.keyTypeAudioLive)
    for (int index = 0; index < 8; index++) {
      ZegoLiveAudioRoomSeat seat = zegoController.getRoomSeatWithIndex(index + 1);
      ZegoSDKUser? user = seat.currentUser.value;
      if (user != null) {
        userList.add(user);
      }
    }
    else
      userList = zegoController.liveStreamingManager.coHostUserListNoti.value;


    setState(() {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (userList.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
          Text("Nothing is here", style: sfProDisplayMedium.copyWith(
            fontSize: 14.sp,
          ),),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  userList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        ValueListenableBuilder<String?>(
                            valueListenable: userList[index].avatarUrlNotifier,
                            builder: (context, url, _) {
                              if(url!=null)
                                return CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(url),
                                );
                              else
                                return SizedBox();

                          }
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(userList[index].userName ?? ''),
                                const SizedBox(width: 16),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'id: ${userList[index].userID}',
                                  style: sfProDisplayRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.white.withOpacity(0.7)),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.copy,
                                    size: 15,
                                    color: AppColors.white.withOpacity(0.7)),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        PrimaryButton(
                          width: 65.w,
                          height: 32.h,
                          title: 'Options',
                          borderRadius: 35,
                          textStyle: sfProDisplayMedium.copyWith(
                              fontSize: 16, color: AppColors.black),
                          bgColor: AppColors.yellowBtnColor,
                          onTap: () {
                            Get.back();
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
                                  GuestOption(userList[index]),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GuestOption extends StatelessWidget {
  final ZegoSDKUser targetUser;

  GuestOption(this.targetUser);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          ValueListenableBuilder<bool>(
              valueListenable: targetUser.isMicOnNotifier,
              builder: (context, isMicOn, _) {
              return PrimaryButton(
                width: 342.w,
                height: 59.h,
                title: isMicOn
                    ? 'Mute '
                    : 'UnMute',
                borderRadius: 12,
                textStyle: sfProDisplayMedium.copyWith(
                    fontSize: 16, color: AppColors.white),
                bgColor: Color(0xFF363339),
                onTap: () {
                  Navigator.pop(context);
                  ZegoLiveAudioRoomManager.instance.muteSpeaker(
                      targetUser.userID, targetUser.isMicOnNotifier.value);
                },
              );
            }
          ),
          Container(
            width: 342.w,
            height: 0.3.h,
            color: AppColors.white,
          ),
          PrimaryButton(
            width: 342.w,
            height: 59.h,
            title: 'Kick out',
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: Color(0xFF363339),
            onTap: () {
              Navigator.pop(context);
              if(zegoController.streamingType == LiveStreamingModel.keyTypeAudioLive)
              ZegoLiveAudioRoomManager.instance
                  .removeSpeakerFromSeat(targetUser.userID);
              else
                zegoController.liveStreamingManager.kickOutRoom(targetUser.userID.toString());
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            width: 342.w,
            height: 48.h,
            title: 'Cancel',
            borderRadius: 12,
            textStyle: sfProDisplayMedium.copyWith(
                fontSize: 16, color: AppColors.white),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
