import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../../../view_model/zego_controller.dart';
import '../zegocloud/../zim_zego_sdk/components/common/zego_audio_video_view.dart';
import '../zegocloud/../zim_zego_sdk/internal/business/business_define.dart';

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
                    // if(liveStreamingModel.getIsPkBattleLive == null || liveStreamingModel.getIsPkBattleLive == false ){
                    //   createPkLive();
                    // }
                  }
                  if (showPKView || zegoController.liveStreamingManager.isLocalUserHost()) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return Stack(children:
                      [
                        // pkBattleView(fem,ffem,constraints)
                      ]);

                    });
                  } else {
                    if (zegoController.liveStreamingManager.hostNoti.value == null) {
                      return Container();
                    }
                    return ZegoAudioVideoView(userInfo: zegoController.liveStreamingManager.hostNoti.value!) ;
                  }
                } else {
                  if(pkState == RoomPKState.isNoPK && zegoController.liveStreamingManager.isLocalUserHost() ){
                    // if(liveStreamingModel.getIsPkBattleLive == true){
                    //   endPkLive(liveStreamingModel);
                    //   if(pkCohostLiveModel!=null){
                    //     endPkLive(pkCohostLiveModel!);
                    //   }
                    // }
                  }
                  if (zegoController.liveStreamingManager.hostNoti.value == null) {
                    return Container();
                  }
                  return ZegoAudioVideoView(userInfo: zegoController.liveStreamingManager.hostNoti.value!);
                }
              });
        });;
  }

}
