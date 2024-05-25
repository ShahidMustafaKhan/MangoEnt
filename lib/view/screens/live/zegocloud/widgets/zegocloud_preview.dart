import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../parse/LiveStreamingModel.dart';
import '../zegocloud/../zim_zego_sdk/internal/business/business_define.dart';
import '../zegocloud/../zim_zego_sdk/zego_live_streaming_manager.dart';
import 'hostVideoView.dart';

class ZegoCloudPreview extends StatelessWidget {
  final ZegoLiveRole role;
  ZegoCloudPreview({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.put(ZegoController(role, LiveStreamingModel.keyTypeSingleLive));
      return GetBuilder<ZegoController>(
          init: zegoController,
          builder: (controller) {
            return ValueListenableBuilder<bool>(
              valueListenable: zegoController.liveStreamingManager.isLivingNotifier,
              builder: (context, isLiving, _) {
                return ValueListenableBuilder<RoomPKState>(
                    valueListenable: ZegoLiveStreamingManager().roomPKStateNoti,
                    builder: (context, RoomPKState roomPKState, child) {
                      return HostVideoLive();
                    }
                );
              }
          );
        }
      );
  }
}
