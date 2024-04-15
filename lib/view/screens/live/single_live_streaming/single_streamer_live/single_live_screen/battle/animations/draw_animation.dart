import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/view_model/animation_controller.dart';

import '../../../../../../../../utils/constants/app_constants.dart';


class DrawAnimation extends StatelessWidget {
  final AnimationViewModel animationViewModel;

  DrawAnimation(this.animationViewModel);


  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: 200.w,
        width: 200.w,
        child: Lottie.asset(
          AppImagePath.drawEmojiJson,
          controller: animationViewModel.drawAnimationController,
          onLoaded: (composition) {
            animationViewModel.drawAnimationController
                .duration = composition.duration;
          },
        ),
      ),
    );
  }
}
