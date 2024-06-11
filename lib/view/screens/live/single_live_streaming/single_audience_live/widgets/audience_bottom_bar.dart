import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_sheet.dart';
import 'package:teego/view_model/battle_controller.dart';


import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../share_friends/share_friends_sheet.dart';
import 'audience_list_sheet.dart';
import '../../../widgets/basic_audience_feature_sheet.dart';

class AudienceBottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BattleViewModel battleViewModel = Get.find();
    RxBool joined = false.obs;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: Image.asset(AppImagePath.subscriber, width: 25, height: 25),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: Image.asset(AppImagePath.chat, width: 22, height: 22),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                backgroundColor: AppColors.grey500,
                builder: (context) => BasicAudienceFeatureSheet(),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: Image.asset(AppImagePath.menu, width: 25, height: 25),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              joined.value=!joined.value;
            },
            child: Obx(() {
                return CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Image.asset(AppImagePath.link, width: 25, height: 25, color: joined.value==false ? AppColors.white : AppColors.yellowBtnColor,),
                );
              }
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
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
                    AudienceGiftSheet(battleViewModel: battleViewModel,),
                  ],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.progressPinkColor,
                    AppColors.progressPinkColor2,
                  ],
                ),
              ),
              child: Image.asset(AppImagePath.giftIcon, width: 25, height: 25),
            ),
          )
        ],
      ),
    );
  }
}