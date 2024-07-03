import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../view_model/animation_controller.dart';
import '../../../../../../../view_model/battle_controller.dart';
import 'animations/animation.dart';
import 'animations/avatar_versus_widget.dart';
import 'animations/draw_animation.dart';
import 'animations/versus_animation.dart';
import 'animations/loser_animation.dart';
import 'animations/winner_animation.dart';




class BattleAnimations extends StatelessWidget {
  final BattleViewModel controller;

  BattleAnimations(this.controller);

  @override
  Widget build(BuildContext context) {
    final AnimationViewModel animationViewModel = Get.find();
    return GetBuilder<AnimationViewModel>(
        init: animationViewModel,
        builder: (animation) {
          return Container(
            width: Get.width,
            child: Stack(
              clipBehavior: Clip.none,
            children: [
              if(controller.showVersusAnimation==true)
                oneonone(img1url: controller.isCurrentUserPlayerB == true ? controller.playerBAvatar : controller.battleModel.getHost!.getAvatar!.url!,
                  img2url:controller.isCurrentUserPlayerB == false ? controller.playerBAvatar : controller.battleModel.getHost!.getAvatar!.url!,),
              if(controller.showResult==true && controller.rightScoreCard!=controller.leftScoreCard)
                LoserAnimation(animationViewModel, controller),
              if(controller.showResult==true && controller.rightScoreCard!=controller.leftScoreCard)
                WinnerAnimation(animationViewModel, controller),
              if(controller.showResult==true && controller.rightScoreCard==controller.leftScoreCard)
                DrawAnimation(animationViewModel),

            ],
        ),
          );
      }
    );
  }
}
