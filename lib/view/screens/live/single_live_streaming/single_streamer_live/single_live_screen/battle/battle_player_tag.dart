import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../view_model/battle_controller.dart';
import '../../../../../../../view_model/live_controller.dart';


class PlayerTag extends StatelessWidget {
  final BattleViewModel battleViewModel;

  PlayerTag({required this.battleViewModel});


  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    return Positioned(
      right: 0,
      bottom: 38.h,
      child: GetBuilder<UserViewModel>(
          init: userViewModel,
          builder: (controller) {
            if(battleViewModel.battleModel.getPlayerB!=null)
            return Container(
            padding: const EdgeInsets.only(left: 15, right: 4, top: 4, bottom: 4),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.black.withOpacity(0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${battleViewModel.isCurrentUserPlayerB==false  ? battleViewModel.playerBName : battleViewModel.hostName }🔥🔥', style: sfProDisplayRegular.copyWith(fontSize: 12.sp),),
                SizedBox(width: 10.w),
                if(userViewModel.followingUser(battleViewModel.isHost==false ? battleViewModel.battleModel.getPlayerB! : battleViewModel.battleModel.getHost! ))
                GestureDetector(
                  onTap: (){
                    userViewModel.followOrUnFollow((battleViewModel.isHost==false ? battleViewModel.battleModel.getPlayerB!.objectId! : battleViewModel.battleModel.getHost!.objectId!));
                  },
                  child: Container(
                    width: 24.r,
                    height: 24.r,
                    child: Image.asset(AppImagePath.filterStar),
                  ),
                ),
                if(!userViewModel.followingUser(battleViewModel.isHost==false ? battleViewModel.battleModel.getPlayerB! : battleViewModel.battleModel.getHost! ))
                  GestureDetector(
                    onTap: (){
                      userViewModel.followOrUnFollow((battleViewModel.isHost==false ? battleViewModel.battleModel.getPlayerB!.objectId! : battleViewModel.battleModel.getHost!.objectId!));
                    },
                    child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: AppColors.yellowColor,
                    child: const Icon(Icons.add, color: AppColors.white),
                ),
                  ),
              ],
            ),
          );
            return SizedBox();
        }
      ),
    );
  }
}
