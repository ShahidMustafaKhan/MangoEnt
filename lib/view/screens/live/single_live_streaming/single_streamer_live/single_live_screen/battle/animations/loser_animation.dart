import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/animation_controller.dart';

import '../../../../../../../../view_model/battle_controller.dart';


class LoserAnimation extends StatelessWidget {
  final AnimationViewModel animationViewModel;
  final BattleViewModel battleViewModel;


  LoserAnimation(this.animationViewModel, this.battleViewModel);


  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: battleViewModel.leftScoreCard > battleViewModel.rightScoreCard ? 38.w : null,
        left: battleViewModel.leftScoreCard < battleViewModel.rightScoreCard ? 38.w : null,
        bottom: 90.h,
        child: Container(
        height: 93.w,
        width: 93.w,
        child: Lottie.asset(
          AppImagePath.loseEmojiJson,
          controller: animationViewModel.loseAnimationController,
          onLoaded: (composition) {
            animationViewModel.loseAnimationController
              .duration = composition.duration;
          },
        ),
            ));
  }
}
