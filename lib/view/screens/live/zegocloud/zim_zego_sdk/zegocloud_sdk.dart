

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

//
// void onFrontCameraStateChanged( TagController tagController, isUseFrontCamera) {
//
//   tagController.isUseFrontCamera.value = !tagController.isUseFrontCamera.value;
//
//   ZegoExpressEngine.instance.useFrontCamera(tagController.isUseFrontCamera.value);
// }
//
// int getRoomId() {
//   Random rand = Random();
//     final id = rand.nextInt(100000000);
//     return id;
// }
//
// ///generate user id
// int getStreamId() {
//   Random rand = Random();
//   return rand.nextInt(100000000);
// }
//
// void onCameraStateChanged(TagController tagController) {
//
//   tagController.isEnableCamera.value = !tagController.isEnableCamera.value;
//
//   ZegoExpressEngine.instance.enableCamera(tagController.isEnableCamera.value);
// }
//
//
// void onMicStateChanged(TagController tagController) {
//
//   tagController.isUseMic.value = !tagController.isUseMic.value;
//   ZegoExpressEngine.instance.muteMicrophone(tagController.isUseMic.value);
// }
//
// void onSnapshotButtonClicked(BuildContext context,TagController tagController, double fem) {
//   ZegoExpressEngine.instance.takePublishStreamSnapshot().then((result) {
//     String path = tagController.appDocumentsPath.value != ''
//         ? tagController.appDocumentsPath.value +
//         '/' +
//         'tmp_snapshot_${DateTime.now().microsecondsSinceEpoch}.png'
//         : '';
//     ZegoUtils.showImage(context, result.image, fem, path: path);
//   });
// }
//
// void onSnapshotButtonClickedPlayStream(BuildContext context,TagController tagController, double fem) {
//   ZegoExpressEngine.instance.takePlayStreamSnapshot(ZegoLiveStreamingManager.instance.hostNoti.value!.streamID.toString()).then((result) {
//     String path = tagController.appDocumentsPath.value != ''
//         ? tagController.appDocumentsPath.value +
//         '/' +
//         'tmp_snapshot_${DateTime.now().microsecondsSinceEpoch}.png'
//         : '';
//     ZegoUtils.showImage(context, result.image, fem, path: path);
//   });
// }
//
// Future<void> onFlashButtonClicked(TagController tagController, {CameraController? cameraController}) async {
//   tagController.isFlashOn.value=!tagController.isFlashOn.value;
//   if(tagController.isFlashOn.value){
//     await cameraController!.setFlashMode(FlashMode.off);
//   }
//   else{
//     await cameraController!.setFlashMode(FlashMode.torch);
//
//   }
//
// }
//



// Step2 LoginRoom
// Future<void> loginRoom(String roomID, String userName, String userID) async {
//
//
//   ZegoUser user =
//   ZegoUser(userID, userName);
//
//   // Step2 LoginRoom
//   ZegoRoomConfig config = ZegoRoomConfig.defaultConfig();
//
//   var result = await ZegoExpressEngine.instance
//       .loginRoom(roomID, user, config: config);
//   if (result.errorCode == 0) {
//     print('User successfully loggedIn room');
//   } else {
//     print('User failed to loggedIn room');
//   }
// }