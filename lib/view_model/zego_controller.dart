import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';
import '../utils/Utils.dart';
import '../utils/theme/colors_constant.dart';
import '../view/screens/live/single_live_streaming/single_audience_live/widgets/invitation_dialog.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/audioRoom/layout_config.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/sdk/zim/Define/zim_room_request.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/live_audio_room_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zegocloud_sdk.dart';



class ZegoController extends GetxController {
  final ZegoLiveRole role;
  final String streamingType;

  UserModel currentUser = Get.find<UserViewModel>().currentUser;
  final liveStreamingManager = ZegoLiveStreamingManager();
  List<StreamSubscription> subscriptions = [];
  bool showingPKDialog = false;
  ZegoScreenCaptureSource? screenSharingSource;
  Widget? hostScreenView;
  int? hostScreenViewID;
  final liveAudioRoomManager = ZegoLiveAudioRoomManager.instance;
  ValueNotifier<bool> isApplyStateNoti = ValueNotifier(false);
  String? currentRequestID;




  bool isCameraEnabled = true;
  bool isSharingScreen = false;


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


    //----------------- Audio Live Section------------------
    streamerAudioLiveConfig(){
      createEngine(currentUser.getUid.toString(), currentUser.getFullName.toString(), currentUser.getAvatar!.url.toString()).then((value) {
        ZegoLiveAudioRoomManager.instance.initWithConfig(
            ZegoLiveAudioRoomLayoutConfig(), ZegoLiveRole.host);
        ZEGOSDKManager.instance.loginRoom(
            Get
                .find<LiveViewModel>()
                .liveStreamingModel
                .getAuthor!
                .getUid
                .toString(), ZegoScenario.HighQualityChatroom, token: '')
            .then((value) {
          if (value.errorCode == 0) {
            ZEGOSDKManager().expressService.turnMicrophoneOn(true);
            hostTakeSeat();
            Get.find<LiveViewModel>().startLive();

          }
          else {
            QuickHelp.showAppNotificationAdvanced(
                title: "Something went wrong!", context: Get.context!);
          }
        });
      });
    }


    audienceAudioLiveConfig() {
      ZegoLiveAudioRoomManager.instance.initWithConfig(
          ZegoLiveAudioRoomLayoutConfig(), ZegoLiveRole.audience);
      createEngine(currentUser.getUid.toString(), currentUser.getFullName.toString(), currentUser.getAvatar!.url.toString()).then((value) {
        update();
          ZEGOSDKManager.instance.loginRoom(
              Get.find<LiveViewModel>().liveStreamingModel.getAuthor!.getUid.toString(), ZegoScenario.HighQualityChatroom, token: '')
              .then((value) {
            if (value.errorCode == 0) {
              hostTakeSeat();
            } else {
              QuickHelp.showAppNotificationAdvanced(
                  title: 'Something went wrong!', context: Get.context!);
            }
          });

      }).onError((error, stackTrace) {
        QuickHelp.showAppNotificationAdvanced(
            title: 'Something went wrong!', context: Get.context!);
      });
    }

  Future<void> hostTakeSeat() async {
    if (role == ZegoLiveRole.host) {
      //take seat
      await liveAudioRoomManager.setSelfHost();
      final result = await liveAudioRoomManager.takeSeat(0);
      if (result != null &&
          !result.errorKeys
              .contains(ZEGOSDKManager.instance.currentUser?.userID)) {
        openMicAndStartPublishStream();
      }
    }
  }

  void openMicAndStartPublishStream() {
    ZEGOSDKManager.instance.expressService.turnCameraOn(false);
    ZEGOSDKManager.instance.expressService.turnMicrophoneOn(true);
    ZEGOSDKManager.instance.expressService
        .startPublishingStream(generateStreamID());
  }

  String generateStreamID() {
    final userID = ZEGOSDKManager.instance.currentUser?.userID ?? '';
    final roomID = ZEGOSDKManager.instance.expressService.currentRoomID;
    final streamID =
        '${roomID}_${userID}_${liveAudioRoomManager.roleNoti.value ==
        ZegoLiveRole.host ? 'host' : 'coHost'}';
    return streamID;
  }

  set setLockSeat(bool value){
    liveAudioRoomManager.isLockSeat = ValueNotifier(value);
  }

  ZegoLiveAudioRoomSeat getRoomSeatWithIndex(int seatIndex) {
    for (final element in ZegoLiveAudioRoomManager.instance.seatList) {
      if (element.seatIndex == seatIndex) {
        return element;
      }
    }
    return ZegoLiveAudioRoomSeat(0, 0, 0);
  }


  subscribeZegoAudioService(){
    final zimService = ZEGOSDKManager.instance.zimService;
    subscriptions.addAll([
      zimService.onInComingRoomRequestStreamCtrl.stream
          .listen(onInComingAudioRoomRequest),
      zimService.onOutgoingRoomRequestAcceptedStreamCtrl.stream
          .listen(onOutgoingRoomAudioRequestAccepted),
      zimService.onOutgoingRoomRequestRejectedStreamCtrl.stream
          .listen(onOutgoingRoomAudioRequestRejected),
      zimService.onRoomCommandReceivedEventStreamCtrl.stream
          .listen(onAudioRoomCommandReceived)
    ]);
  }

  void onInComingAudioRoomRequest(OnInComingRoomRequestReceivedEvent event) {
  }

  void onOutgoingRoomAudioRequestAccepted(OnOutgoingRoomRequestAcceptedEvent event) {
    for (final seat in ZegoLiveAudioRoomManager.instance.seatList) {
      if (seat.currentUser.value == null) {
        ZegoLiveAudioRoomManager.instance
            .takeSeat(seat.seatIndex)
            .then((value) {
          isApplyStateNoti.value = false;
          openMicAndStartPublishStream();
        });
        break;
      }
    }
  }

  void onAudioRoomCommandReceived(OnRoomCommandReceivedEvent event) {
    Map<String, dynamic> messageMap = jsonDecode(event.command);
    if (messageMap.keys.contains('room_command_type')) {
      final type = messageMap['room_command_type'];
      final receiverID = messageMap['receiver_id'];
      if (receiverID == ZEGOSDKManager().currentUser?.userID) {
        if (type == RoomCommandType.muteSpeaker) {
          QuickHelp.showAppNotificationAdvanced(title: 'You have been muted by the host.', context: Get.context!);
          ZEGOSDKManager().expressService.turnMicrophoneOn(false);
        } else if (type == RoomCommandType.unMuteSpeaker) {
          QuickHelp.showAppNotificationAdvanced(title: 'The host has enabled your microphone.', context: Get.context!);
          ZEGOSDKManager().expressService.turnMicrophoneOn(true);
        } else if (type == RoomCommandType.kickOutRoom) {
          liveAudioRoomManager.leaveRoom();
          Navigator.pop(Get.context!);
          QuickHelp.showAppNotificationAdvanced(title: 'You have been kick out of the room by the host', context: Get.context!);
        }
      }
    }
  }

  void onOutgoingRoomAudioRequestRejected(OnOutgoingRoomRequestRejectedEvent event) {
    isApplyStateNoti.value = false;
    currentRequestID = null;
  }

  //----------------- Audio Live Section------------------



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
      zimService.onOutgoingRoomRequestAcceptedStreamCtrl.stream.listen(onOutgoingRoomRequestAccepted),
      zimService.onOutgoingRoomRequestRejectedStreamCtrl.stream.listen(onOutgoingRoomRequestRejected),
      if(streamingType != LiveStreamingModel.keyTypeMultiGuestLive)
      liveStreamingManager.onPKStartStreamCtrl.stream.listen(onPKStart),
      if(streamingType != LiveStreamingModel.keyTypeMultiGuestLive)
        liveStreamingManager.onPKEndStreamCtrl.stream.listen(onPKEnd)
    ]);
  }

  void unSubscribeZegoService(){
    if(streamingType==LiveStreamingModel.keyTypeSingleLive) {
      ZEGOSDKManager()
          .expressService
          .stopPlayingStream(
          '${ZEGOSDKManager().expressService.currentRoomID}_mix');

      liveStreamingManager
        ..leaveRoom()
        ..uninit();
      ZEGOSDKManager.instance.expressService.stopPreview();
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    }
    else if (streamingType==LiveStreamingModel.keyTypeAudioLive)
      unSubscribeAudioZegoService();
  }

  void unSubscribeAudioZegoService(){
    liveAudioRoomManager.leaveRoom();

    for (final subscription in subscriptions) {
      subscription.cancel();
    }

  }


  void onOutgoingRoomRequestAccepted(OnOutgoingRoomRequestAcceptedEvent event) {
    isApplyStateNoti.value = false;
    liveStreamingManager.startCoHost();
  }

  void onOutgoingRoomRequestRejected(OnOutgoingRoomRequestRejectedEvent event) {
     isApplyStateNoti.value = false;
     QuickHelp.showAppNotificationAdvanced(title: 'Your request to co-host with the host has been refused.', context: Get.context!);
  }


  void onPKStart(dynamic event) {

    Get.find<BattleViewModel>().onPkStart();

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
              Get.find<BattleViewModel>().fetchBattleModelForPlayerSideLogic(int.parse(event.invitation.inviterID!));
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
    Get.find<BattleViewModel>().onPkEnd();
  }


  Future<void> startScreenSharing() async {
    screenSharingSource ??= (await ZegoExpressEngine.instance.createScreenCaptureSource())!;
    await ZegoExpressEngine.instance.setVideoConfig(
      ZegoVideoConfig.preset(ZegoVideoConfigPreset.Preset720P)..fps = 10,
      channel: ZegoPublishChannel.Aux,
    );
    await ZegoExpressEngine.instance.setVideoSource(ZegoVideoSourceType.ScreenCapture, channel: ZegoPublishChannel.Aux);
    await screenSharingSource!.startCapture();
    // String streamID = '${widget.roomID}_${widget.localUserID}_screen';
    // await ZegoExpressEngine.instance.startPublishingStream(streamID, channel: ZegoPublishChannel.Aux);
    // await ZegoExpressEngine.instance.stopPublishingStream(channel: ZegoPublishChannel.Aux);
    // await ZegoExpressEngine.instance.startPublishingStream(streamID, channel: ZegoPublishChannel.Aux);
    isSharingScreen = true;
    update();

    bool needPreview = false;
    // ignore: dead_code
    if (needPreview && (hostScreenViewID == null)) {
      await ZegoExpressEngine.instance.createCanvasView((viewID) async {
        hostScreenViewID = viewID;
        ZegoCanvas previewCanvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFit);
        ZegoExpressEngine.instance.startPreview(canvas: previewCanvas, channel: ZegoPublishChannel.Aux);
      }).then((canvasViewWidget) {
        // use this canvasViewWidget to preview the screensharing
     hostScreenView = canvasViewWidget;
      });
    }
  }


  ZegoController(this.role, this.streamingType);

  @override
  void onInit() {
    if(role==ZegoLiveRole.host){
      if(streamingType==LiveStreamingModel.keyTypeSingleLive || streamingType==LiveStreamingModel.keyTypeMultiGuestLive)
      streamerZegoLiveConfig();
      else if(streamingType==LiveStreamingModel.keyTypeAudioLive)
       streamerAudioLiveConfig();
    }
    else{
      if(streamingType==LiveStreamingModel.keyTypeSingleLive || streamingType==LiveStreamingModel.keyTypeMultiGuestLive)
        audienceZegoLiveConfig();
      else if(streamingType==LiveStreamingModel.keyTypeAudioLive)
        audienceAudioLiveConfig();

    }

    if(streamingType==LiveStreamingModel.keyTypeSingleLive || streamingType==LiveStreamingModel.keyTypeMultiGuestLive)
    subscribeZegoService();
    else if (streamingType==LiveStreamingModel.keyTypeAudioLive)
      subscribeZegoAudioService();


    super.onInit();
  }

  @override
  void onClose() {
    unSubscribeZegoService();
    super.onClose();
  }

}
