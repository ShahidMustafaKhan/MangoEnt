

import 'package:flutter/foundation.dart';


import 'live_audio_room_manager.dart';
import '../zim_zego_sdk/pages/call/call_controller.dart';
import 'zego_call_manager.dart';
import 'zego_sdk_key_center.dart';
import 'zego_sdk_manager.dart';

Future<void> createEngine(String userID, String userName, String avatarUrl) async {
  await ZEGOSDKManager.instance.init(SDKKeyCenter.appID, kIsWeb ? null : SDKKeyCenter.appSign).then((value) {

  }).onError((error, stackTrace) {
    print("createEngine$error");

  });
  ZegoCallManager().addListener();
  ZegoCallController().initService();
  await ZEGOSDKManager.instance
      .connectUser(userID, userName);
  ZegoLiveAudioRoomManager.instance
      .updateUserAvatarUrl(avatarUrl);
  // ZEGOSDKManager.instance.zimService.updateUserAvatarUrl(avatarUrl);
}

