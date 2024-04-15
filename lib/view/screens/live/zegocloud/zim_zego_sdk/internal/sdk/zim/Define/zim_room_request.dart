
import 'dart:math';
import 'dart:convert' as convert;

import '../../../../zego_sdk_manager.dart';
import 'zim_define.dart';

class RoomRequest {

  String? requestID;
  String? senderName;
  late RoomRequestAction actionType;
  late String senderID;
  late String receiverID;
  String extendedData = '';

  RoomRequest(this.actionType, this.senderID, this.receiverID, this.senderName);

  String toJsonString() {
    final jsonMap = <String, dynamic>{};
    jsonMap['action_type'] = actionType.index;
    jsonMap['sender_id'] = senderID;
    jsonMap['receiver_id'] = receiverID;
    requestID ??= generateProtocolID();
    jsonMap['request_id'] = requestID;
    jsonMap['extended_data'] = extendedData;
    jsonMap['sender_name'] = senderName;

    return convert.jsonEncode(jsonMap);
  }

  String generateProtocolID() {
    final localUserID = ZIMService.instance.currentZimUserInfo?.userID ?? '';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomStr = (Random().nextInt(900000) + 100000).toString();
    return '${localUserID}_${timestamp}_$randomStr';
  }


}
