import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/Utils.dart';
import '../../../../../../../view_model/live_messages_controller.dart';
import '../../../../../../../view_model/battle_controller.dart';
import 'chat_card.dart';

class ChatFeature extends StatelessWidget {
  ChatFeature();
  Widget build(BuildContext context) {
    final LiveMessagesViewModel liveMessagesViewModel = Get.find();
    return GetBuilder<LiveMessagesViewModel>(init: liveMessagesViewModel ,builder: (liveMessagesViewModel) {
          return Container(
                  height: 185.h,
                  child: ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: liveMessagesViewModel.liveMessagesModelList.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: ChatCard(liveMessagesModel: liveMessagesViewModel.liveMessagesModelList[index],index: index, lastMessage: liveMessagesViewModel.liveMessagesModelList.length-1 == index,),
                      );
                    }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 9.h); },
                  ),
                );
              }
        );
  }

  //  Widget disclaimerMessage(){
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(0.w, 0, 0, 0),
  //     constraints: BoxConstraints (
  //       maxWidth: 308.w,
  //     ),
  //     child: Text(
  //       'We moderate Live Broadcasts. Smoking, Vulgarity, \nPorn, indecent exposure or Any copyright infringement \nis NOT Allowed and will be banned. Live broadcasts are \nmonitored 24 hours a day.\nWarning. Third party Top-UP or Recharge is subject\nto account closure, suspension, or permanent ban.',
  //       style: SafeGoogleFont (
  //         'DM Sans',
  //         fontSize: 12.sp,
  //         fontWeight: FontWeight.w400,
  //         color: const Color(0xffffffff),
  //       ),
  //     ),
  //   );
  // }
}
