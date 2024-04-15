import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';
import '../utils/Utils.dart';
import '../utils/theme/colors_constant.dart';
import '../view/screens/live/single_live_streaming/single_audience_live/widgets/invitation_dialog.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/sdk/zim/Define/zim_room_request.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zegocloud_sdk.dart';



class ZegoController extends GetxController {
  final ZegoLiveRole role;

  UserModel currentUser = Get.find<UserViewModel>().currentUser;
  final liveStreamingManager = ZegoLiveStreamingManager();
  List<StreamSubscription> subscriptions = [];
  bool showingPKDialog = false;


  bool isCurrentUserHost(){
    return liveStreamingManager.isLocalUserHost();
  }

  audienceZegoLiveConfig(){
      createEngine(currentUser.getUid.toString(), currentUser.getFullName.toString(), currentUser.getAvatar!.url.toString()).then((value){
        update();
        liveStreamingManager.currentUserRoleNoti.value = ZegoLiveRole.audience;
        ZEGOSDKManager.instance.loginRoom(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid.toString(), ZegoScenario.Broadcast).then(
              (value) {
                update();
                if (value.errorCode != 0) {
                  QuickHelp.showSnackBar(title: 'Something went wrong!');
            }
          },
        );
      });
    }

    streamerZegoLiveConfig(){
      createEngine(currentUser.getUid.toString(), currentUser.getFullName.toString(), currentUser.getAvatar!.url.toString()).then((value){
        update();
        liveStreamingManager.hostNoti.value = ZEGOSDKManager.instance.currentUser;
        ZegoLiveStreamingManager().currentUserRoleNoti.value = ZegoLiveRole.host;
        ZEGOSDKManager.instance.expressService.turnCameraOn(true);
        ZEGOSDKManager.instance.expressService.turnMicrophoneOn(true);
        ZEGOSDKManager.instance.expressService.startPreview( );
        startLive();
      });
    }


  void startLive() {
    liveStreamingManager.startLive(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid.toString()).then((value) {
      if (value.errorCode != 0) {

        QuickHelp.showSnackBar(title: 'Something went wrong!');

      } else {
        ZEGOSDKManager.instance.expressService.startPublishingStream(liveStreamingManager.hostStreamID()).then((value){
          Get.find<LiveViewModel>().startLive();
          update();
        });
      }
    }).catchError((error) {

        QuickHelp.showSnackBar(title: 'Something went wrong!');

    });
  }


  void sendPkBattleRequest(int uid, BuildContext context){
    ZegoLiveStreamingManager().sendPKBattlesStartRequest(uid.toString()).then((value) {
      if (value.info.errorInvitees.map((e) => e.userID).contains(uid.toString())) {
        QuickHelp.showAppNotificationAdvanced(title: 'start pk failed', context: context);
      }
      else{
        QuickHelp.showAppNotification(title: "The invitation has been sent successfully", context: context, isError: false);
      }
    }).catchError((error) {
      QuickHelp.showAppNotificationAdvanced(title: 'start pk failed', context: context);
    });
  }


  void subscribeZegoService(){
    liveStreamingManager.init();
    final zimService = ZEGOSDKManager().zimService;
    subscriptions.addAll([
      liveStreamingManager.incomingPKRequestStreamCtrl.stream.listen(onIncomingPKRequestReceived),
      liveStreamingManager.incomingPKRequestCancelStreamCtrl.stream.listen(onIncomingPKRequestCancelled),
      liveStreamingManager.outgoingPKRequestAcceptStreamCtrl.stream.listen(onOutgoingPKRequestAccepted),
      liveStreamingManager.outgoingPKRequestRejectedStreamCtrl.stream.listen(onOutgoingPKRequestRejected),
      liveStreamingManager.incomingPKRequestTimeoutStreamCtrl.stream.listen(onIncomingPKRequestTimeout),
      liveStreamingManager.onPKStartStreamCtrl.stream.listen(onPKStart),
      liveStreamingManager.onPKEndStreamCtrl.stream.listen(onPKEnd),
      zimService.onOutgoingRoomRequestAcceptedStreamCtrl.stream.listen(onOutgoingRoomRequestAccepted),
      zimService.onOutgoingRoomRequestRejectedStreamCtrl.stream.listen(onOutgoingRoomRequestRejected),
    ]);
  }

  void unSubscribeZegoService(){
    ZEGOSDKManager()
        .expressService
        .stopPlayingStream('${ZEGOSDKManager().expressService.currentRoomID}_mix');

    liveStreamingManager
      ..leaveRoom()
      ..uninit();
    ZEGOSDKManager.instance.expressService.stopPreview();
    for (final subscription in subscriptions) {
      subscription.cancel();
    }

  }


  void onOutgoingRoomRequestAccepted(OnOutgoingRoomRequestAcceptedEvent event) {
    // applying.value = false;
    // liveStreamingManager.startCoHost();
  }

  void onOutgoingRoomRequestRejected(OnOutgoingRoomRequestRejectedEvent event) {
    // applying.value = false;
    // QuickHelp.showAppNotificationAdvanced(title: 'Your request to co-host with the host has been refused.', context: context);
  }


  void onPKStart(dynamic event) {

    Get.find<BattleViewModel>().setBattleView=true;

    if(Get.find<BattleViewModel>().isHost){
      Get.find<BattleViewModel>().subscribeBattleModel(Get.find<UserViewModel>().currentUser.getUid!);
    }

    if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience){
      Get.find<BattleViewModel>().fetchBattleModelFromLiveObject();
    }

    Get.find<BattleViewModel>().pauseLiveStreamingForPkPlayer(true);

    Get.find<AnimationViewModel>().loadBattleAnimation();

    if (!ZegoLiveStreamingManager().isLocalUserHost()) {
      liveStreamingManager.endCoHost();
    }
    if (ZegoLiveStreamingManager().isLocalUserHost()) {
      for (final RoomRequest element in ZEGOSDKManager.instance.zimService.roomRequestMapNoti.value.values.toList()) {
        // refuseApplyCohost(element);
      }
    }
  }

  void onIncomingPKRequestReceived(IncomingPKRequestEvent event) {
    if (showingPKDialog) {
      return;
    }
    showingPKDialog = true;
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: InvitationDialog(
            onAccept: () {
              liveStreamingManager.acceptPKBattleRequest(event.requestID);
              Get.find<BattleViewModel>().fetchBattleModel(int.parse(event.invitation.inviterID!));
              Get.back(); },
            avatar: event.invitation.inviterAvatar!,),
        );
      },
    ).whenComplete(() => showingPKDialog = false);
  }

  void onOutgoingPKRequestAccepted(OutgoingPKRequestAcceptEvent event) {

    // liveStreamingManager.pkService!.isPrimaryHost.value=true;
    // ZegoLiveStreamingManager.instance.isPrimaryHost.value=true;
    // ZegoLiveStreamingManager.instance.pkService!.isPrimaryHost.value=true;
  }

  void onOutgoingPKRequestRejected(OutgoingPKRequestRejectedEvent event) {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('pk request is rejected')));
  }

  void onIncomingPKRequestCancelled(IncomingPKRequestCancelledEvent event) {
    // if (showingPKDialog) {
    //   Navigator.pop(context);
    // }
  }

  void onIncomingPKRequestTimeout(IncomingPKRequestTimeoutEvent event) {
    // if (showingPKDialog) {
    //   Navigator.pop(context);
    // }
  }


  void onPKEnd(dynamic event){
    Get.find<BattleViewModel>().endBattleView(endBattle: true);
    Get.find<BattleViewModel>().pauseLiveStreamingForPkPlayer(false);
    Get.find<AnimationViewModel>().resetAllAnimationsController();
  }


  ZegoController(this.role);

  @override
  void onInit() {
    if(role==ZegoLiveRole.host){
      streamerZegoLiveConfig();
    }
    else{
      audienceZegoLiveConfig();
    }
    subscribeZegoService();

    super.onInit();
  }

  @override
  void onClose() {
    unSubscribeZegoService();
    super.onClose();
  }

}
