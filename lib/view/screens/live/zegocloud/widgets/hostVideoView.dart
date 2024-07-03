import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../../view_model/zego_controller.dart';
import '../../single_live_streaming/single_audience_live/widgets/guest_detail_screen.dart';
import '../zegocloud/../zim_zego_sdk/components/common/zego_audio_video_view.dart';
import '../zegocloud/../zim_zego_sdk/internal/business/business_define.dart';
import '../zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';

class HostVideoLive extends StatelessWidget {

  HostVideoLive({Key? key}) : super(key: key);

  final ZegoController zegoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: zegoController.liveStreamingManager.roomPKStateNoti,
        builder: (context, RoomPKState pkState, _) {
          return ValueListenableBuilder(
              valueListenable: zegoController.liveStreamingManager.onPKViewAvaliableNoti,
              builder: (context, bool showPKView, _) {
                if (pkState == RoomPKState.isStartPK) {
                  if(zegoController.liveStreamingManager.isLocalUserHost()){


                  }
                  if (showPKView || zegoController.liveStreamingManager.isLocalUserHost()) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return Stack(children:
                      [

                      ]);

                    });
                  } else {
                    if (zegoController.liveStreamingManager.hostNoti.value == null) {
                      return Container();
                    }
                    return ZegoAudioVideoView(userInfo: zegoController.liveStreamingManager.hostNoti.value!) ;
                  }
                } else {
                  return ValueListenableBuilder<List<ZegoSDKUser>>(
                    valueListenable: zegoController.liveStreamingManager.coHostUserListNoti,
                    builder: (context, coHostList, _) {

                      final videoList = zegoController.liveStreamingManager.coHostUserListNoti.value.map((user) {
                        return ZegoAudioVideoView(userInfo: user );
                      }).toList();

                      if(videoList.isNotEmpty)
                      return  Column(
                        children: [
                          Expanded(child: ZegoAudioVideoView(userInfo: zegoController.liveStreamingManager.hostNoti.value!)),
                          Expanded(child: Stack(children: [
                            videoList[0],
                            GuestDetailWidget(),
                          ],)),
                        ],
                      );

                      else
                      if (zegoController.liveStreamingManager.hostNoti.value == null) {
                        return Container();
                      }
                      return ZegoAudioVideoView(userInfo: zegoController.liveStreamingManager.hostNoti.value!);


                    },
                  );

                }
              });
        });;
  }

}
