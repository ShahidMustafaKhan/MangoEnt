import 'package:flutter/material.dart';

import '../../../../../../../helpers/quick_help.dart';
import '../../internal/sdk/zim/Define/zim_room_request.dart';
import '../../zego_sdk_manager.dart';

class ApplyCoHostListView {
  Future<void> showBasicModalBottomSheet(context) async {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable:
                  ZEGOSDKManager.instance.zimService.roomRequestMapNoti,
              builder: (context, Map<String, dynamic> requestMap, _) {
                print('request map $requestMap');
                print('request map $requestMap');
                final requestList = requestMap.values.toList();
                print('request list $requestList');
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final roomRequest = requestList[index];
                    print(roomRequest);
                    print((roomRequest as RoomRequest).senderID);
                    return Column(
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text((roomRequest as RoomRequest).senderID),
                                ],
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          ZEGOSDKManager.instance.zimService
                                              .acceptRoomRequest(
                                                  roomRequest.requestID ?? '')
                                              .then((value) {})
                                              .catchError((error) {
                                            QuickHelp.showAppNotificationAdvanced(title: 'Agree cohost failed', context: context);

                                          });
                                        },
                                        child: const Text(
                                          'agree',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          ZEGOSDKManager.instance.zimService
                                              .rejectRoomRequest(
                                                  roomRequest.requestID ?? '');
                                        },
                                        child: const Text(
                                          'disAgree',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 0.5,
                        ),
                      ],
                    );
                  },
                  itemCount: requestMap.values.toList().length,
                );
              });
        });
  }
}
