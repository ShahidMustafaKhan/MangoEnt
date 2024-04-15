import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/Utils.dart';
import '../../../../../../../view_model/live_messages_controller.dart';
import '../../../../../../../view_model/battle_controller.dart';
import 'chat_card.dart';

class ChatFeature extends StatelessWidget {
  ChatFeature();

  final LiveMessagesViewModel liveMessagesViewModel = Get.put(LiveMessagesViewModel());


  Widget build(BuildContext context) {
    return GetBuilder<BattleViewModel>(builder: (controller) {
        return Obx((){
            return liveMessagesViewModel.showDisclaimerMessage.value && controller.isBattleView==false ?
            disclaimerMessage():
            Container(
              height: 185.h,
              child: ListView.builder(
                reverse: true,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: liveMessagesViewModel.liveMessagesModelList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 20, right: 10.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ChatCard(liveMessagesModel: liveMessagesViewModel.liveMessagesModelList[0]),
                    ),
                  );
                },
              ),
            );
          }
        );
      }
    );
  }

   Widget disclaimerMessage(){
    return Container(
      margin: EdgeInsets.fromLTRB(0.w, 0, 0, 0),
      constraints: BoxConstraints (
        maxWidth: 308.w,
      ),
      child: Text(
        'We moderate Live Broadcasts. Smoking, Vulgarity, \nPorn, indecent exposure or Any copyright infringement \nis NOT Allowed and will be banned. Live broadcasts are \nmonitored 24 hours a day.\nWarning. Third party Top-UP or Recharge is subject\nto account closure, suspension, or permanent ban.',
        style: SafeGoogleFont (
          'DM Sans',
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffffffff),
        ),
      ),
    );
  }
}
