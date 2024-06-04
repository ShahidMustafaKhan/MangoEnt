import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/active_seat_widget.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/empty_seat_widget.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';



class AudioCoHostView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    final ZegoController zegoController = Get.find();
    return Expanded(
      child: GetBuilder<ZegoController>(
          init: zegoController,
          builder: (zegoController) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding:EdgeInsets.only(top:20.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 7.h,
                  crossAxisSpacing: 32.w,
                  childAspectRatio: 1 / 1.5),
              itemCount: liveViewModel.liveStreamingModel.getAudioSeats ?? 8,
              itemBuilder: (BuildContext context, int index) {
                ZegoLiveAudioRoomSeat seat= zegoController.getRoomSeatWithIndex(index + 1);
                return ValueListenableBuilder<ZegoSDKUser?>(
                    valueListenable: seat.currentUser,
                    builder: (context, user, _) {
                      if (user != null) {
                        return ActiveSeat(user);
                      } else {
                        int circleNumber = index - 1 + 2;
                        return EmptySeat(circleNumber);
                      }
                    });
              },
            );

        }
      ),
    );
  }
}
