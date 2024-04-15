import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../widgets/custom_buttons.dart';
import 'battle_setting_sheet.dart';


class BattleModeSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
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
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.grey300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImagePath.worldWide, width: 32, height: 32),
                  const SizedBox(width: 8),
                  Text(
                    'Select Mode',
                    style: sfProDisplayBold.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: BattleWidget(
                    title: '1 vs 1',
                    icon: AppImagePath.battle1x1,
                  ),
                ),
                SizedBox(width: 13),
                Expanded(
                  child: BattleWidget(
                    title: '1 vs 2',
                    icon: AppImagePath.battle1x2,
                  ),
                ),
                SizedBox(width: 13),
                Expanded(
                  child: BattleWidget(
                    title: '1 vs 3',
                    icon: AppImagePath.battle1x3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              children: const [
                BattleWidget(
                  title: 'Team Battle',
                  icon: AppImagePath.battleTeamMate,
                ),
                SizedBox(width: 13),
                BattleWidget(
                  title: '4 vs 4',
                  icon: AppImagePath.battle4x4,
                ),
              ],
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: 'Next',
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
                  builder: (context) => Wrap(
                    children: [
                      BattleSettingSheet(),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BattleWidget extends StatelessWidget {
  final String title;
  final String icon;

  const BattleWidget({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.button,
        border: Border.all(color: AppColors.borderColor.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(icon, width: 84, height: 64),
          Text(
            title,
            style: sfProDisplayBold.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}