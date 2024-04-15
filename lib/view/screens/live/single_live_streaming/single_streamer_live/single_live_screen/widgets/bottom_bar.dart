import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../../view_model/battle_controller.dart';
import '../../../../../../../view_model/zego_controller.dart';
import '../../../../../../widgets/custom_buttons.dart';
import '../../../../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';
import '../../../single_audience_live/share_friends/share_friends_sheet.dart';
import '../battle/battle_disconnect_sheet.dart';
import '../battle/battle_mode_sheet.dart';
import 'basic_feature_sheet.dart';

class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleViewModel>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: Image.asset(AppImagePath.chat, width: 22, height: 22),
            ),
            const SizedBox(width: 8),
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
                  backgroundColor: AppColors.grey900,
                  builder: (context) => BasicFeatureSheet(),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Image.asset(AppImagePath.menu, width: 25, height: 25),
              ),
            ),
            const SizedBox(width: 8),
            if(controller.isBattleView == true)
            GetBuilder<ZegoController>(
                builder: (zegoController) {
                  if(ZEGOSDKManager.instance.currentUser!=null)
                    return
                    ValueListenableBuilder<bool>(
                    valueListenable: ZEGOSDKManager.instance.currentUser!.isMicOnNotifier,
                    builder: (context, isMicOn, _) {
                      return GestureDetector(
                        onTap: () {
                          ZEGOSDKManager.instance.expressService.turnMicrophoneOn(!isMicOn);
                          isMicOn = !isMicOn;
                        },
                        child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: Image.asset( AppImagePath.micIcon , width: 25, height: 25, color: isMicOn ? AppColors.white : AppColors.yellowBtnColor,),
                      ),
                    );
                  }
                );
                  else
                    return SizedBox();
              }
            ),
            if(controller.isBattleView == false)
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
                          ShareFriendsSheet(),
                        ],
                      ),
                    );
                  },
                  child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Image.asset(AppImagePath.link, width: 25, height: 25, color: AppColors.white,),
              ),),

            const Spacer(),
            if(controller.isBattleView && controller.isBattleStarted==false && controller.isHost)
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.card,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Are you sure you want to start battle',
                            style: sfProDisplayRegular.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  title: 'No',
                                  height: 40,
                                  borderRadius: 35,
                                  textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.yellowColor),
                                  bgColor: AppColors.grey500,
                                  borderColor: AppColors.yellowColor,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: PrimaryButton(
                                  title: 'Yes',
                                  height: 40,
                                  borderRadius: 35,
                                  textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
                                  bgColor: AppColors.yellowBtnColor,
                                  onTap: () {
                                    Navigator.pop(context);
                                    controller.setBattleStarted=true;
                                    controller.startBannerLoadingAnimation();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Image.asset(AppImagePath.boxingIcon, width: 32, height: 32),
              ),
            ),
            if(controller.isBattleView && controller.isBattleStarted && controller.isHost)
              CircleAvatar(
                  radius: 18,child: Image.asset(AppImagePath.boxingDimIcon, fit: BoxFit.cover,)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (controller.isBattleView) {
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
                        BattleDisconnectSheet(),
                      ],
                    ),
                  );
                } else {
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
                      children:  [
                        BattleModeSheet(),
                      ],
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightOrange,
                      AppColors.darkOrange,
                    ],
                  ),
                ),
                child: Image.asset(AppImagePath.sword, width: 25, height: 25),
              ),
            )
          ],
        ),
      );
    });
  }
}
