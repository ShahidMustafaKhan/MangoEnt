import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../view_model/battle_controller.dart';


class BattleTimer extends StatelessWidget {
  final BattleViewModel battleViewModel;

  BattleTimer({required this.battleViewModel});


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        width: Get.size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 6.5.w, 16.w, 6.5.w),
              decoration: BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  )
              ),
              child: Obx(() {
                  return Container(
                    height: 10.5.h,
                    child: Row(
                      children: [
                        if(battleViewModel.getLapse==false)
                        SvgPicture.asset("assets/svg/vs.svg", width: 11.w, height: 10.5.w),
                        if(battleViewModel.getLapse==true)
                          Text("Victory Lap", style: sfProDisplayBold.copyWith(color: AppColors.yellowBtnColor, fontSize: 9.sp),),
                        SizedBox(width: battleViewModel.getLapse==false ? 8.w : 5.w,),
                        Text(battleViewModel.getFormattedTimer(int.parse(battleViewModel.clockTime.value)), style: sfProDisplayRegular.copyWith(color: AppColors.white, fontSize: 10.sp),),
                      ],
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
