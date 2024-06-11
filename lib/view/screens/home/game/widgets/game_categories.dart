import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class GameCategories extends StatelessWidget {
  const GameCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          // Define images and texts based on index
          String imagePath = '';
          String categoryText = '';
          switch (index) {
            case 0:
              imagePath = AppImagePath.just_chatting;
              categoryText = 'Just Chatting';
              break;
            case 1:
              imagePath = AppImagePath.world_of_war;
              categoryText = 'World of war';
              break;
            case 2:
              imagePath = AppImagePath.baldurs;
              categoryText = 'Baldurs Gate 3';
              break;
            case 3:
              imagePath = AppImagePath.just_chatting;
              categoryText = 'Just Chatting';
              break;
            case 4:
              imagePath = AppImagePath.baldurs;
              categoryText = 'World of war';
              break;
          }

          return Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Column(
              children: [
                Container(
                  width: 122.w,
                  height: 164.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(right: 40.w),
                  child: Row(
                    children: [
                      SizedBox(width: 5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryText,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '180,8k',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
