// import 'package:flutter/material.dart';
//
// import '../../internal/business/business_define.dart';
// import '../../internal/sdk/zim/Define/zim_room_request.dart';
// import '../../zego_live_streaming_manager.dart';
// import '../../zego_sdk_manager.dart';
//
// extension ZegoLiveStreamingPKBattleManagerEventConv  {
//   void onIncomingPKRequestReceived(IncomingPKRequestEvent event) {
//     showPKDialog(event.requestID, event.invitation);
//   }
//
//   void onOutgoingPKRequestAccepted(OutgoingPKRequestAcceptEvent event) {
//
//     liveStreamingManager.pkService!.isPrimaryHost.value=true;
//     ZegoLiveStreamingManager.instance.isPrimaryHost.value=true;
//     ZegoLiveStreamingManager.instance.pkService!.isPrimaryHost.value=true;
//   }
//
//   void onOutgoingPKRequestRejected(OutgoingPKRequestRejectedEvent event) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('pk request is rejected')));
//   }
//
//   void onIncomingPKRequestCancelled(IncomingPKRequestCancelledEvent event) {
//     if (showingPKDialog) {
//       Navigator.pop(context);
//     }
//   }
//
//   void onIncomingPKRequestTimeout(IncomingPKRequestTimeoutEvent event) {
//     if (showingPKDialog) {
//       Navigator.pop(context);
//     }
//   }
//
//   void onOutgoingPKRequestTimeout(OutgoingPKRequestTimeoutEvent event) {}
//
//
//
//   void onPKEnd(dynamic event) {
//
//   }
// }
