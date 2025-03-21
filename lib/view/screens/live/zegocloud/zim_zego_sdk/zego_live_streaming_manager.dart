import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'internal/business/business_define.dart';
import 'internal/business/coHost/cohost_service.dart';
import 'internal/business/pk/pk_service.dart';
import 'internal/sdk/utils/flutter_extension.dart';
import 'utils/zegocloud_token.dart';
import 'zego_sdk_key_center.dart';
import 'zego_sdk_manager.dart';

class ZegoLiveStreamingManager {
  ZegoLiveStreamingManager._internal();
  factory ZegoLiveStreamingManager() => instance;
  static final ZegoLiveStreamingManager instance =
      ZegoLiveStreamingManager._internal();

  ValueNotifier<ZegoSDKUser?> get hostNoti {
    return cohostService?.hostNoti ?? ValueNotifier(null);
  }

  ValueNotifier<ZegoLiveRole> currentUserRoleNoti =
      ValueNotifier(ZegoLiveRole.audience);

  ListNotifier<ZegoSDKUser> get coHostUserListNoti {
    return cohostService?.coHostUserListNoti ?? ListNotifier([]);
  } 

  ValueNotifier<RoomPKState> get roomPKStateNoti {
    return pkService?.roomPKStateNoti ?? ValueNotifier(RoomPKState.isNoPK);
  }

  ValueNotifier<bool> get isMuteAnotherAudioNoti {
    return pkService?.isMuteAnotherAudioNoti ?? ValueNotifier(false);
  }

  ValueNotifier<bool> get onPKViewAvaliableNoti {
    return pkService?.onPKViewAvaliableNoti ?? ValueNotifier(false);
  }
  ValueNotifier<bool> get isPrimaryHost {
    return pkService?.isPrimaryHost ?? ValueNotifier(false);
  }

  ZegoSDKUser? get pkUser {
    return pkService?.pkUser;
  }

  ValueNotifier<bool> isLivingNotifier = ValueNotifier(false);


  List<StreamSubscription> subscriptions = [];

  StreamController<IncomingPKRequestEvent> get incomingPKRequestStreamCtrl {
    return pkService?.incomingPKRequestStreamCtrl ??
        StreamController<IncomingPKRequestEvent>.broadcast();
  }

  StreamController<IncomingPKRequestCancelledEvent>
      get incomingPKRequestCancelStreamCtrl {
    return pkService?.incomingPKRequestCancelStreamCtrl ??
        StreamController<IncomingPKRequestCancelledEvent>.broadcast();
  }

  StreamController<OutgoingPKRequestRejectedEvent>
      get outgoingPKRequestRejectedStreamCtrl {
    return pkService?.outgoingPKRequestRejectedStreamCtrl ??
        StreamController<OutgoingPKRequestRejectedEvent>.broadcast();
  }

  StreamController<OutgoingPKRequestAcceptEvent>
      get outgoingPKRequestAcceptStreamCtrl {
    return pkService?.outgoingPKRequestAcceptStreamCtrl ??
        StreamController<OutgoingPKRequestAcceptEvent>.broadcast();
  }

  StreamController<IncomingPKRequestTimeoutEvent>
      get incomingPKRequestTimeoutStreamCtrl {
    return pkService?.incomingPKRequestTimeoutStreamCtrl ??
        StreamController<IncomingPKRequestTimeoutEvent>.broadcast();
  }

  StreamController<OutgoingPKRequestTimeoutEvent>
      get outgoingPKRequestAnsweredTimeoutStreamCtrl {
    return pkService?.outgoingPKRequestAnsweredTimeoutStreamCtrl ??
        StreamController<OutgoingPKRequestTimeoutEvent>.broadcast();
  }

  StreamController get onPKStartStreamCtrl {
    return pkService?.onPKStartStreamCtrl ?? StreamController.broadcast();
  }

  StreamController get onPKEndStreamCtrl {
    return pkService?.onPKEndStreamCtrl ?? StreamController.broadcast();
  }

  PKService? pkService;
  CoHostService? cohostService;

  void init() {
    pkService = PKService()..addListener();
    cohostService = CoHostService()..addListener();
    final expressService = ZEGOSDKManager().expressService;
    subscriptions.addAll([
      expressService.streamListUpdateStreamCtrl.stream
          .listen(onStreamListUpdate),
    ]);
  }

  Future<ZIMMessageSentResult> muteSpeaker(String userID, bool isMute) async {
    final messageType =
    isMute ? RoomCommandType.muteSpeaker : RoomCommandType.unMuteSpeaker;
    final commandMap = {
      'room_command_type': messageType,
      'receiver_id': userID
    };
    final result = await ZEGOSDKManager()
        .zimService
        .sendRoomCommand(jsonEncode(commandMap));
    return result;
  }

  Future<ZIMMessageSentResult> kickOutRoom(String userID) async {
    final commandMap = {
      'room_command_type': RoomCommandType.kickOutRoom,
      'receiver_id': userID
    };
    final result = await ZEGOSDKManager()
        .zimService
        .sendRoomCommand(jsonEncode(commandMap));
    return result;
  }

  Future<ZIMMessageSentResult> requestCameraOff(String userID) async {
    final commandMap = {
      'room_command_type': RoomCommandType.requestCameraOff,
      'receiver_id': userID
    };
    final result = await ZEGOSDKManager()
        .zimService
        .sendRoomCommand(jsonEncode(commandMap));
    return result;
  }

  // void leaveRoom() {
  //   ZEGOSDKManager.instance.logoutRoom();
  //   clear();
  // }

  void clear() {

    // cohostService?.hostNoti = ValueNotifier(null);
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    subscriptions.clear();
  }

  void uninit() {
    pkService?.uninit();
    cohostService?.uninit();
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }

  Future<ZegoRoomLoginResult> startLive(String roomID) async {
    isLivingNotifier.value = true;
    String? token;
    if (kIsWeb) {
      // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
      // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
      token = ZegoTokenUtils.generateToken(
          SDKKeyCenter.appID,
          SDKKeyCenter.serverSecret,
          ZEGOSDKManager.instance.currentUser!.userID);
    }
    final result = await ZEGOSDKManager.instance.loginRoom(roomID, ZegoScenario.Broadcast, token: token);
    return result;
  }

  Future<void> startCoHost() async {

    ZEGOSDKManager.instance.expressService.turnCameraOn(true);
    ZEGOSDKManager.instance.expressService.turnMicrophoneOn(true);
    ZEGOSDKManager.instance.expressService.useFrontCamera(true);
    ZEGOSDKManager.instance.expressService.startPreview();
    ZEGOSDKManager.instance.expressService
        .startPublishingStream(coHostStreamID());
    currentUserRoleNoti.value =
        ZegoLiveRole.coHost;
    cohostService?.startCoHost();
  }

  Future<void> endCoHost() async {
    ZEGOSDKManager.instance.expressService.stopPreview();
    ZEGOSDKManager.instance.expressService.stopPublishingStream();
    currentUserRoleNoti.value = ZegoLiveRole.audience;
    cohostService?.endCoHost();
  }

  Future<ZIMCallInvitationSentResult> sendPKBattlesStartRequest(
      String userID) async {
    return pkService!.sendPKBattlesStartRequest(userID);
  }

  Future<ZIMCallInvitationSentResult> sendPKBattleResumeRequest(
      String userID) async {
    return pkService!.sendPKBattleResumeRequest(userID);
  }

  Future<void> sendPKBattlesStopRequest() async {
    return pkService!.sendPKBattlesStopRequest();
  }

  void cancelPKBattleRequest() {
    pkService!.cancelPKBattleRequest();
  }

  void acceptPKBattleRequest(String requestID) {
    pkService!.acceptPKBattleRequest(requestID);
  }

  void rejectPKBattleRequest(String requestID) {
    pkService!.rejectPKBattleRequest(requestID);
  }

  void muteAnotherHostAudio(bool mute) {
    pkService!.muteAnotherHostAudio(mute);
  }


  bool isLocalUserHost() {
    return cohostService?.isLocalUserHost() ?? false;
  }

  bool isHost(String userID) {
    return cohostService?.isHost(userID) ?? false;
  }

  bool isCoHost(String userID) {
    return cohostService?.isCoHost(userID) ?? false;
  }

  bool isAudience(String userID) {
    return cohostService?.isAudience(userID) ?? false;
  }

  void leaveRoom() {
    if (isLocalUserHost() && roomPKStateNoti.value == RoomPKState.isStartPK) {
      sendPKBattlesStopRequest();
    }
    isLivingNotifier.value = false;
    clearData();
    ZEGOSDKManager().logoutRoom();
  }

  void clearData() {
    cohostService?.clearData();
    pkService?.clearData();
  }

  String hostStreamID() {
    return '${ZEGOSDKManager().expressService.currentRoomID}_${ZEGOSDKManager().currentUser?.userID ?? ''}_main_host';
  }

  String coHostStreamID() {
    return '${ZEGOSDKManager().expressService.currentRoomID}_${ZEGOSDKManager().currentUser?.userID ?? ''}_cohost';
  }

  // express listener
  void onStreamListUpdate(ZegoRoomStreamListUpdateEvent event) {
    for (final stream in event.streamList) {
      if (event.updateType == ZegoUpdateType.Add)
        if (stream.streamID.endsWith('_host')) {
          isLivingNotifier.value = true;
        }
       else {
        if (stream.streamID.endsWith('_host')) {
          isLivingNotifier.value = false;
          endCoHost();
        } 
      }
    }
  }



}
