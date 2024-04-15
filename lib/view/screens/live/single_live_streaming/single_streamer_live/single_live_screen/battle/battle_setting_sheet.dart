import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import 'package:teego/view/widgets/custom_buttons.dart';

import 'battle_invite_sheet.dart';
import 'battle_time_sheet.dart';

class BattleSettingSheet extends StatefulWidget {

  @override
  State<BattleSettingSheet> createState() => _BattleSettingSheetState();
}

class _BattleSettingSheetState extends State<BattleSettingSheet> {
  bool _isSingleRound = true;
  RxInt time=3.obs;

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
          const SizedBox(height: 30),
          Text(
            'Settings',
            style: sfProDisplayBold.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Time',
                style: sfProDisplayRegular.copyWith(fontSize: 16),
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
                    builder: (context) => BattleTimeSheet(time: time,),
                  );
                },
                child: Row(
                  children: [
                    Obx(() {
                        return Text(
                          '$time min',
                          style: sfProDisplayRegular.copyWith(fontSize: 16, color: AppColors.yellowColor),
                        );
                      }
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.grey300, thickness: 1.2),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Battles mode',
                style: sfProDisplayRegular.copyWith(fontSize: 16),
              ),
              const Spacer(),
              PrimaryButton(
                title: 'Single Round',
                width: 100,
                height: 40,
                borderRadius: 35,
                textStyle: sfProDisplayRegular.copyWith(
                  fontSize: 13,
                  color: _isSingleRound ? AppColors.black : AppColors.white,
                ),
                bgColor: _isSingleRound ? AppColors.yellowBtnColor : AppColors.card,
                borderColor: AppColors.yellowColor,
                onTap: () {
                  setState(() {
                    _isSingleRound = true;
                  });
                },
              ),
              const SizedBox(width: 12),
              PrimaryButton(
                title: 'Best of three',
                width: 100,
                height: 40,
                borderRadius: 35,
                textStyle: sfProDisplayRegular.copyWith(
                  fontSize: 13,
                  color: _isSingleRound ? AppColors.white : AppColors.black,
                ),
                borderColor: AppColors.yellowColor,
                bgColor: _isSingleRound ? AppColors.card : AppColors.yellowBtnColor,
                onTap: () {
                  setState(() {
                    _isSingleRound = false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.grey300, thickness: 1.2),
          const SizedBox(height: 32),
          PrimaryButton(
            title: 'Start',
            borderRadius: 35,
            textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {
              Get.back();
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
                builder: (context) => BattleInviteSheet(time: time.value, top: 1 , round: _isSingleRound ? 1 : 3, ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
