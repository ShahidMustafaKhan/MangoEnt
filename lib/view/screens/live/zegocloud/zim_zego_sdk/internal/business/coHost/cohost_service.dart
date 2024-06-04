import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../../../../../parse/LiveStreamingModel.dart';
import '../../../../../../../../view_model/live_controller.dart';
import '../../../zego_live_streaming_manager.dart';
import '../../../zego_sdk_manager.dart';
import '../../sdk/basic/zego_sdk_user.dart';
import '../../sdk/utils/flutter_extension.dart';
import '../business_define.dart';

class CoHostService {
  ValueNotifier<ZegoSDKUser?> hostNoti = ValueNotifier(null);

  List<StreamSubscription> subscriptions = [];
  ListNotifier<ZegoSDKUser> coHostUserListNoti = ListNotifier([]);
  LiveStreamingModel liveStreamingModel=LiveStreamingModel();

  void addListener() {
    final expressService = ZEGOSDKManager().expressService;
    subscriptions.addAll([
      expressService.streamListUpdateStreamCtrl.stream
          .listen(onStreamListUpdate),
      expressService.roomUserListUpdateStreamCtrl.stream
          .listen(onRoomUserListUpdate),
    ]);
  }

  void uninit() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
  }

  bool isHost(String userID) {
    return hostNoti.value?.userID == userID;
  }

  bool isCoHost(String userID) {
    for (final user in coHostUserListNoti.value) {
      if (user.userID == userID) {
        return true;
      }
    }
    return false;
  }

  bool isAudience(String userID) {
    if (isHost(userID) || isCoHost(userID)) {
      return false;
    }
    return true;
  }

  bool isLocalUserHost() {
    return isHost(ZEGOSDKManager().currentUser?.userID ?? '');
  }

  void clearData() {
    coHostUserListNoti.clear();
    hostNoti.value = null;
  }

  void startCoHost() {
    print('currentUser${ZEGOSDKManager().currentUser}');

    coHostUserListNoti.add(ZEGOSDKManager().currentUser!);

  }

  void endCoHost() {
    coHostUserListNoti.removeWhere((element) {
      return element.userID == ZEGOSDKManager().currentUser?.userID;
    });

  }

  void onStreamListUpdate(ZegoRoomStreamListUpdateEvent event) {
    print("hi");

    if (event.updateType == ZegoUpdateType.Add) {
      for (final element in event.streamList) {
        if (element.streamID.endsWith('_host')) {
          hostNoti.value = ZEGOSDKManager().getUser(element.user.userID);
        } else if (element.streamID.endsWith('_cohost')) {
          final cohostUser = ZEGOSDKManager().getUser(element.user.userID);
          if (cohostUser != null) {
            coHostUserListNoti.add(cohostUser);

          }
        }
      }
    } else {
      for (final element in event.streamList) {
        if (element.streamID.endsWith('_host')) {
          hostNoti.value = null;
        } else if (element.streamID.endsWith('_cohost')) {
          coHostUserListNoti.removeWhere((coHostUser) {
            return coHostUser.userID == element.user.userID;
          });
        }
      }
    }
  }

  void onRoomUserListUpdate(ZegoRoomUserListUpdateEvent event) {
    for (final user in event.userList) {
      if (event.updateType == ZegoUpdateType.Delete) {
        coHostUserListNoti
            .removeWhere((element) => element.userID == ZEGOSDKManager().currentUser?.userID);
        if (hostNoti.value?.userID == user.userID) {
          hostNoti.value = null;
        }
      }
    }
  }

  Future<void> addMultiHostUserModel( ) async {
    if( ZegoLiveStreamingManager().currentUserRoleNoti.value == ZegoLiveRole.host){

      final query = QueryBuilder(LiveStreamingModel())
        ..whereEqualTo(LiveStreamingModel.keyAuthorUid, int.parse(ZEGOSDKManager.instance.currentUser!.userID) )
        ..whereEqualTo(LiveStreamingModel.keyStreaming, true );
      final response = await query.query();

      if (response.success) {
        liveStreamingModel = response.results!.first as LiveStreamingModel;

          liveStreamingModel.setIsMultiGuest=true;


        final updateResponse = await liveStreamingModel.save();

        if (updateResponse.success) {
          // Record updated successfully
          print('Record updated successfully.');
        } else {
          // Handle the update error
          print('Error updating record: ${updateResponse.error!.message}');
        }
      } else {
        // Handle the case where no record was found for the current user.
        print('Record not found for the current user.');
      }
    }

  }
}
