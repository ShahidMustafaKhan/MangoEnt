import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/battle_animations.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/battle_controller.dart';
import '../../../../zegocloud/zim_zego_sdk/components/live_streaming/zego_pk_view.dart';
import 'animations/avatar_versus_widget.dart';
import 'battle_progress_bar.dart';
import 'battle_widgets.dart';



class BattleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final BattleViewModel battleViewModel = Get.find();
    final AnimationViewModel animationViewModel = Get.find();
    return GetBuilder<BattleViewModel>(
        init: battleViewModel,
        builder: (controller) {
        return SizedBox(
          child: Column(
          children: [
            if(controller.showProgressBar==true)
            ProgressBar(battleViewModel: controller),
            SizedBox(
              height:350.h,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: [
                  ZegoPKBattleView(),
                  BattleWidgets(controller),
                  BattleAnimations(controller),

                ],
              ),
            ),

          ],
              ),
        );
      }
    );
  }



}
