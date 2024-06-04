import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../view/screens/live/multi_live_streaming/widgets/multi_guest_grid_settings.dart';
import '../view/screens/live/single_live_streaming/single_audience_live/widgets/invitation_dialog.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/audioRoom/layout_config.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/internal/sdk/zim/Define/zim_room_request.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/live_audio_room_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../view/screens/live/zegocloud/zim_zego_sdk/zegocloud_sdk.dart';
import '../view/widgets/custom_buttons.dart';



class ZegoController extends GetxController {
  final ZegoLiveRole role;
  final String streamingType;

  UserModel currentUser = Get.find<UserViewModel>().currentUser;
  final liveStreamingManager = ZegoLiveStreamingManager();
  final expressService = ZEGOSDKManager().expressService;
  List<StreamSubscription> subscriptions = [];
  bool showingPKDialog = false;
  ZegoScreenCaptureSource? screenSharingSource;
  final liveAudioRoomManager = ZegoLiveAudioRoomManager.instance;
  ValueNotifier<bool> isApplyStateNoti = ValueNotifier(false);
  String? currentRequestID;
  RoomRequest? myRoomRequest;


  bool isCameraEnabled = true;


  bool isCurrentUserHost(){
    return liveStreamingManager.isLocalUserHost();
  }

  audienceZegoLiveConfig(){
      createEngine(currentUser.getUid.toString(), currentUser.getFullName.toString(), currentUser.getAvatar!.url.toString()).then((value){
        update();
        liveStreamingManager.currentUserRoleNoti.value = ZegoLiveRole.audience;
        expressService.useFrontCamera(true);
        if(expressService.currentUser!=null)
        expressService.currentUser!.isCameraFront.value=true;
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
        expressService.useFrontCamera(true);
        if(expressService.currentUser!=null)
          expressService.currentUser!.isCameraFront.value=true;
        ZEGOSDKManager.instance.currentUser?.coinsNotifier.value = Get.find<UserViewModel>().currentUser.getDiamondsTotal ?? 0;
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
          QuickHelp.showSnackBar(title: '  You have been muted by the host.  ');
          ZEGOSDKManager().expressService.turnMicrophoneOn(false);
        } else if (type == RoomCommandType.unMuteSpeaker) {
          ZEGOSDKManager().expressService.turnMicrophoneOn(true);
        } else if (type == RoomCommandType.kickOutRoom) {
          if(streamingType == LiveStreamingModel.keyTypeMultiGuestLive)
            liveStreamingManager.endCoHost();
          if(streamingType == LiveStreamingModel.keyTypeAudioLive){
          liveAudioRoomManager.leaveRoom();
          Navigator.pop(Get.context!);}
          QuickHelp.showSnackBar(title: '  The host has removed you from co-hosting.  ');
        }
        else if (type == RoomCommandType.requestCameraOff) {
          if(streamingType == LiveStreamingModel.keyTypeMultiGuestLive)
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color(0xFF494848),
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  title: Text(
                    'Host want you to enable your camera',
                    style: TextStyle(
                        color: AppColors.white, fontSize: 14),
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: "No",
                            textColor: AppColors.black,
                            borderRadius: 35,
                            borderColor:
                            AppColors.yellowBtnColor,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: PrimaryButton(
                            title: "Yes",
                            textColor: AppColors.black,
                            borderRadius: 35,
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
                                      MultiGuestGridSettings(ZEGOSDKManager.instance.expressService.currentUser),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
        }
      }
    }
  }

  void onOutgoingRoomAudioRequestRejected(OnOutgoingRoomRequestRejectedEvent event) {
    isApplyStateNoti.value = false;
    currentRequestID = null;
  }

  //----------------- Audio Live Section------------------


  //------------Multi Live Section started------------------------
  Future<void> applyCoHost() async {
    final signaling = jsonEncode({
      'room_request_type': RoomRequestType.audienceApplyToBecomeCoHost,
    });
    ZEGOSDKManager.instance.zimService
        .sendRoomRequest(ZegoLiveStreamingManager.instance.hostNoti.value?.userID ?? '', signaling)
        .then((value) {
      isApplyStateNoti.value = true;
      myRoomRequest = ZEGOSDKManager.instance.zimService
          .roomRequestMapNoti.value[value.requestID];

    }).catchError((error) {
      QuickHelp.showAppNotificationAdvanced(title: 'apply to co-host failed!', context: Get.context!);

    });
  }

  Future<void> cancelCoHostApplication(RoomRequest? myRoomRequest, ValueNotifier<bool> applying)async {
    ZEGOSDKManager.instance.zimService
        .cancelRoomRequest(myRoomRequest?.requestID ?? '')
        .then((value) {
      applying.value = false;
    }).catchError((error) {
      QuickHelp.showAppNotificationAdvanced(title: 'Cancel the application failed!', context: Get.context!);

    });

  }

  Future<void> endCoHost() async {
    ZegoLiveStreamingManager.instance.endCoHost();

  }

  //------------Multi Live Section ended--------------------------


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
    final expressService = ZEGOSDKManager().expressService;

    subscriptions.addAll([
      liveStreamingManager.incomingPKRequestStreamCtrl.stream.listen(onIncomingPKRequestReceived),
      liveStreamingManager.incomingPKRequestCancelStreamCtrl.stream.listen(onIncomingPKRequestCancelled),
      liveStreamingManager.outgoingPKRequestAcceptStreamCtrl.stream.listen(onOutgoingPKRequestAccepted),
      liveStreamingManager.outgoingPKRequestRejectedStreamCtrl.stream.listen(onOutgoingPKRequestRejected),
      liveStreamingManager.incomingPKRequestTimeoutStreamCtrl.stream.listen(onIncomingPKRequestTimeout),
      zimService.onOutgoingRoomRequestAcceptedStreamCtrl.stream.listen(onOutgoingRoomRequestAccepted),
      zimService.onOutgoingRoomRequestRejectedStreamCtrl.stream.listen(onOutgoingRoomRequestRejected),
      zimService.onRoomCommandReceivedEventStreamCtrl.stream.listen(onAudioRoomCommandReceived),
      if(streamingType != LiveStreamingModel.keyTypeMultiGuestLive)
      liveStreamingManager.onPKStartStreamCtrl.stream.listen(onPKStart),
      if(streamingType != LiveStreamingModel.keyTypeMultiGuestLive)
        liveStreamingManager.onPKEndStreamCtrl.stream.listen(onPKEnd)
    ]);
  }

  void unSubscribeZegoService(){
    if(streamingType==LiveStreamingModel.keyTypeSingleLive || streamingType==LiveStreamingModel.keyTypeMultiGuestLive) {
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
    screenSharingSource!.startCapture().then((value) async {
      String streamID = '${ZEGOSDKManager().expressService.currentRoomID}_${ZEGOSDKManager().currentUser?.userID ?? ''}_screen';
      await ZegoExpressEngine.instance.startPublishingStream(streamID, channel: ZegoPublishChannel.Aux);
      expressService.isSharingScreen.value = true;
      update();

    });
  }

  Future<void> stopScreenSharing() async {
    await screenSharingSource?.stopCapture();
    await ZegoExpressEngine.instance.stopPreview(channel: ZegoPublishChannel.Aux);
    if(role == ZegoLiveRole.host){
    await ZegoExpressEngine.instance.stopPublishingStream(channel: ZegoPublishChannel.Aux);
    await ZegoExpressEngine.instance.setVideoSource(ZegoVideoSourceType.None, channel: ZegoPublishChannel.Aux);}

    expressService.isSharingScreen.value = false;
    if ( expressService.hostScreenViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(expressService.hostScreenViewID!);
      expressService.hostScreenViewID = null;
      expressService.hostScreenView.value = null;
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
    stopScreenSharing();
    super.onClose();
  }

}
