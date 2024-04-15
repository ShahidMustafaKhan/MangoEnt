import 'package:flutter/material.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../view_model/battle_controller.dart';



class LoseCount extends StatelessWidget {
  final bool left;
  LoseCount(this.left);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: left ? 5 : null,
      right: left ? null : 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.black.withOpacity(0.6),
        ),
        child: Text(
          'LOSE',
          style: sfProDisplayBlack.copyWith(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: AppColors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
