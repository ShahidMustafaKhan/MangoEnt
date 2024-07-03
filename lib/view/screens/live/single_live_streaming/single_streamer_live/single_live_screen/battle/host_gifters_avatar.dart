import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/battle_controller.dart';



class HostGifters extends StatelessWidget {
  HostGifters();

  @override
  Widget build(BuildContext context) {
    BattleViewModel battleViewModel = Get.find();
    return Positioned(
      left: battleViewModel.isCurrentUserPlayerB==false ?  0 : null,
      right: battleViewModel.isCurrentUserPlayerB==true ?  0 : null,
      bottom: 0,
      child: GetBuilder<BattleViewModel>(
          init: battleViewModel,
          builder: (controller) {
            return Padding(
            padding: EdgeInsets.only(left: battleViewModel.isCurrentUserPlayerB==false ? 10 : 0,
                right: battleViewModel.isCurrentUserPlayerB==true ? 10 : 0, bottom: 10),
            child: Row(
              children: [
                ...List.generate(battleViewModel.hostGiftersAvatar.length, (index) {
                  int reversedIndex = 2 - index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 26.w,
                          height: 26.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(battleViewModel.hostGiftersAvatar[index]),
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.yellowColor, width: 1),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              inherit: true,
                              fontSize: 10.sp,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  // bottomLeft
                                  offset: const Offset(-1, -1),
                                  color: AppColors.darkOrange,
                                ),
                                Shadow(
                                  // bottomRight
                                  offset: const Offset(1, -1),
                                  color: AppColors.darkOrange,
                                ),
                                Shadow(
                                  // topRight
                                  offset: const Offset(1, 1),
                                  color: AppColors.darkOrange,
                                ),
                                Shadow(
                                  // topLeft
                                  offset: const Offset(-1, 1),
                                  color: AppColors.darkOrange,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        }
      ),
    );
  }
}
