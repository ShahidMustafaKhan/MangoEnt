import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../widgets/custom_buttons.dart';


class GiftCard extends StatelessWidget {
  final String giftImage;
  final String giftName;
  final String coins;
  final String score;
  final double progress;
  final VoidCallback onSend;

  const GiftCard({
    required this.giftImage,
    required this.giftName,
    required this.coins,
    required this.score,
    required this.progress,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.button,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Image.asset(giftImage, width: 75, height: 75),
          const SizedBox(height: 15),
          FittedBox(
            child: Text(
              giftName,
              style: sfProDisplayMedium.copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImagePath.coinsIcon, width: 12, height: 12),
              const SizedBox(width: 5),
              Text(
                coins,
                style: sfProDisplayMedium.copyWith(fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 20,
            width: 70,
            child: LinearPercentIndicator(
              animation: true,
              padding: const EdgeInsets.all(0),
              lineHeight: 5.0,
              width: 70,
              animationDuration: 2500,
              percent: progress,
              barRadius: const Radius.circular(10),
              progressColor: AppColors.progressLinearGreenColor1,
              backgroundColor: AppColors.progressBgColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            score,
            style: sfProDisplayMedium.copyWith(fontSize: 12),
          ),
          PrimaryButton(
            title: 'Send',
            textStyle: sfProDisplayRegular.copyWith(fontSize: 14, color: AppColors.black),
            height: 30,
            width: 50,
            borderRadius: 30,
            bgColor: AppColors.yellowColor,
            onTap: onSend,
          ),
        ],
      ),
    );
  }
}
