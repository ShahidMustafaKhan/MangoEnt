import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/ranking_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';



class TrophyBottomBar extends StatelessWidget {
  const TrophyBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RankingViewModel rankingViewModel = Get.find();
    UserViewModel userViewModel = Get.find();
    if(rankingViewModel.ranking.length > 3)
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<UserViewModel>(
            init: userViewModel,
            builder: (userViewModel) {
              return Padding(
              padding: EdgeInsets.only(left: 20.w,right: 20.w, bottom: 45.h),
              child: Column(
                children: List.generate(
                  rankingViewModel.ranking.length-3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        Text(
                          (index + 4).toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.grey300,
                          backgroundImage: NetworkImage(rankingViewModel.ranking[index+3].getGifter!.getAvatar!.url!),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(rankingViewModel.ranking[index+3].getGifter!.getFullName!),
                                SizedBox(width: 12.w),
                                Container(
                                  width: 39.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19.r),
                                      color: Color(0xff9c4ae6)),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5.w),
                                      Image.asset(AppImagePath.gemstones),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "LV.${rankingViewModel.ranking[index+3].getGifter!.getLevel}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 8.sp),
                                      ),
                                      SizedBox(width: 5.w),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Image.asset(
                                  AppImagePath.coinsIcon,
                                  height: 12.44.h,
                                  width: 8.15.w,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  QuickActions.formatValue(rankingViewModel.ranking[index+3].getGifter!.getCoins),
                                  style: sfProDisplayRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.yellowBtnColor),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            userViewModel.followOrUnFollow(rankingViewModel.ranking[index+3].getGifter!.objectId!);
                          },
                          child: Container(
                            width: 62.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                                color: AppColors.yellowBtnColor,
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Center(
                              child: Icon(
                                userViewModel.followingUser(rankingViewModel.ranking[index+3].getGifter!) ? Icons.check : Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
    return SizedBox();
  }
}
