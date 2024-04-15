import 'package:flutter/material.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../view_model/battle_controller.dart';



class WinCount extends StatelessWidget {
  final bool left;
  final int winCount;
  WinCount(this.left, this.winCount);

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
                text: 'win'.toUpperCase(),
                style: sfProDisplayBlack.copyWith(
                    fontSize: 15, fontStyle: FontStyle.italic, color: AppColors.yellowColor),
              ),
              if(winCount>0)
              TextSpan(
                text: '  X$winCount',
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
