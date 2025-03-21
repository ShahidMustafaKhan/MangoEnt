import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveMessagesModel.dart';
import 'package:teego/utils/constants/typography.dart';

import '../../../../../../../view_model/live_controller.dart';
import '../../../../../../../view_model/live_messages_controller.dart';

class ChatCard extends StatelessWidget {
  final LiveMessagesModel liveMessagesModel;
  final int index;
  final bool lastMessage;
  const ChatCard({required this.liveMessagesModel, required this.index, this.lastMessage = false});

  @override
  Widget build(BuildContext context) {
    if(liveMessagesModel.getMessageType == LiveMessagesModel.messageTypeSystem)
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                height: 25.h,
                decoration: BoxDecoration(
                  color: Color(0XFF3B0073),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    ClipRRect (
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      child: Image.network(
                        liveMessagesModel.getAuthorAvatarUrl!,
                        width: 16.h,
                        height: 16.h,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      liveMessagesModel.getMessage ?? '',
                      style: sfProDisplayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
    if(liveMessagesModel.getMessageType == LiveMessagesModel.messageTypeComment)
      return Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Color(0XFF000000).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        ClipRRect (
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          child: Image.network(
                            liveMessagesModel.getAuthorAvatarUrl!,
                            width: 16.h,
                            height: 16.h,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                         "${liveMessagesModel.getSenderName ?? ''}  ",
                          style: sfProDisplayRegular.copyWith(
                            color: Color(0xffF5AF03),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${Get.find<LiveViewModel>().filterMessage(liveMessagesModel.getMessage ?? '')}",
                          style: sfProDisplayMedium.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      );

    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Color(0XFF000000).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      ClipRRect (
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        child: Image.network(
                          liveMessagesModel.getAuthorAvatarUrl!,
                          width: 16.h,
                          height: 16.h,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${liveMessagesModel.getSenderName ?? ''}  ",
                        style: sfProDisplayRegular.copyWith(
                          color: Color(0xffF5AF03),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${Get.find<LiveViewModel>().filterMessage(liveMessagesModel.getMessage ?? '')}",
                        style: sfProDisplayMedium.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );

  }
}
