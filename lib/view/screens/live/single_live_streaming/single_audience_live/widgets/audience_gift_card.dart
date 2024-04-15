import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';


class StreamerGiftCard extends StatelessWidget {
  final String giftImage;
  final String giftName;
  final String coins;
  final String score;
  final double progress;
  final Color? bgColor;
  final VoidCallback onSelect;

  const StreamerGiftCard({
    required this.giftImage,
    required this.giftName,
    required this.coins,
    required this.score,
    required this.progress,
    this.bgColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.button,
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
          ],
        ),
      ),
    );
  }
}
