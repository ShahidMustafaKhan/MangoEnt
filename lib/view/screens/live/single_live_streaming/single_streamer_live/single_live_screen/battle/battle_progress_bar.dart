import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/animation_controller.dart';

import '../../../../../../../view_model/battle_controller.dart';


class ProgressBar extends StatelessWidget {
  final BattleViewModel battleViewModel;

  ProgressBar({required this.battleViewModel});
  

  @override
  Widget build(BuildContext context) {
    AnimationViewModel animationViewModel = Get.find();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.darkPurple
      ),
      height: 18.h,
      child: Stack(
        children: [
          LinearPercentIndicator(
            animation: true,
            animateFromLastPercent : true,
            padding: const EdgeInsets.all(0),
            lineHeight: 18.h,
            width: MediaQuery.of(context).size.width,
            animationDuration: 2500,
            clipLinearGradient: true,
            backgroundColor: Colors.transparent,
            percent: battleViewModel.calculatePkProgressScore(),
            linearGradient: LinearGradient(
              begin: Alignment(-0.019, 1.607),
              end: Alignment(-0.037, -3.611),
              colors: <Color>[Color(0xFFFB461B), Color(0xFFFEB749)],
              stops: <double>[0, 1],
            ),
            widgetIndicator: SizedBox(
              width: 5.w,
              child: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: SVGAImage(animationViewModel.indexAnimationController,fit: BoxFit.cover,),
              ),
            ),
          ),
          Positioned(
            left:16.w,
            top:2.5.h,
            child: Text(battleViewModel.leftScoreCard.toString(),
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),),
          ),
          Positioned(
            right:16.w,
            top:2.5.h,
            child: Text(battleViewModel.rightScoreCard.toString(),
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),),
          ),
        ],

      ),
    );
  }
}
