import 'package:flutter/material.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../view_model/battle_controller.dart';



class DrawCount extends StatelessWidget {
  final bool left;
  final BattleViewModel battleViewModel;
  DrawCount(this.left, this.battleViewModel);

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
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'draw'.toUpperCase(),
                style: sfProDisplayBlack.copyWith(
                    fontSize: 15, fontStyle: FontStyle.italic, color: AppColors.yellowColor),
              ),
              if(battleViewModel.drawCount>0)
              TextSpan(
                text: '  X${battleViewModel.drawCount}',
                style: sfProDisplayRegular.copyWith(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
