import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/battle_controller.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../widgets/custom_buttons.dart';
import '../../../../zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';




class BattleDisconnectSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.close, color: Colors.transparent),
              Text(
                'Battles',
                style: quinlliykRegular.copyWith(fontSize: 24),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.grey300, thickness: 1.2),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Get.find<BattleViewModel>().battleModel.getHost!.getAvatar!.url!),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2.5),
                ),
              ),
              const SizedBox(width: 30),
              Image.asset(AppImagePath.boxingIcon, height: 50, width: 52),
              const SizedBox(width: 30),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Get.find<BattleViewModel>().playerBAvatar),
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          PrimaryButton(
            title: 'Disconnect',
            borderRadius: 35,
            textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {
              Navigator.pop(context);
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
                          'Are you sure you want to leave battle',
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
                                  ZegoLiveStreamingManager().sendPKBattlesStopRequest();
                                  Get.find<BattleViewModel>().setBattleView = false;
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
