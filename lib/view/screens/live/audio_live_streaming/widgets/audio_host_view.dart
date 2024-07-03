import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';



class AudioHostView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final LiveViewModel liveViewModel = Get.find();
    final ZegoController zegoController = Get.find();
    ZegoLiveAudioRoomSeat seat= zegoController.getRoomSeatWithIndex(0);
    return Column(
      children: [
        Container(
          height: 72.r,
          width: 72.r,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.yellowBtnColor, width: 2)),
          child: Stack(children: [

            ValueListenableBuilder<ZegoSDKUser?>(
                valueListenable: seat.currentUser,
                builder: (context, user, _) {
                  if(user!=null)
                    return Positioned.fill(
                        child: ValueListenableBuilder<String?>(
                            valueListenable: user.avatarUrlNotifier,
                            builder: (context, avatarUrl, _) {
                              if (avatarUrl != null && avatarUrl.isNotEmpty) {
                                return ClipOval(
                                  child: Image.network(
                                    liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }));
                  else
                    return SizedBox();
                }
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.r),
                  bottomRight: Radius.circular(100.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Center(
                    child: Text(
                      "Host",
                      style: TextStyle(
                        color: AppColors.yellowBtnColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if(seat.currentUser.value!=null)
            Positioned(
                top: 0,
                right: 0,
                left: 52,
                child: ValueListenableBuilder<bool?>(
                    valueListenable: seat.currentUser.value!.isMicOnNotifier,
                    builder: (context, isMicOn, _) {
                      return Visibility(
                        visible: isMicOn==false,
                        child: Container(
                          height: 20.w,
                          width: 20.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white),
                          child: Center(
                              child: Image.asset(
                                  AppImagePath.mic_off, fit: BoxFit.cover)),
                        ),
                      );
                    }
                )),
          ]),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                liveViewModel.liveStreamingModel.getAuthor!.getFullName!,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFF231E28),
                child: Image.asset(
                  AppImagePath.audioLiveCoin,
                  width: 10.w,
                  height: 10.w,
                ),
              ),
            ),
            Text(
              liveViewModel.liveStreamingModel.getTotalCoins.toString() ,
              style: TextStyle(color: AppColors.yellowBtnColor),
            )
          ],
        ),
      ],
    );
  }
}
