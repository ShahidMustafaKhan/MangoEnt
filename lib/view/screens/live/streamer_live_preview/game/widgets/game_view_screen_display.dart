import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';

class GameViewScreenDisplay extends StatelessWidget {
  final RxInt index;

  GameViewScreenDisplay({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LiveViewModel liveViewModel = Get.find();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildDisplayContainer(
              isSelected: index.value == 0,
              imagePath: AppImagePath.verticalDisplay,
              label: 'Vertical Display',
            ),
            SizedBox(
              width: 10.w,
            ),
            _buildDisplayContainer(
              isSelected: index.value == 1,
              imagePath: AppImagePath.horizontalDisplay,
              label: 'Horizontal Display',
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDisplayContainer({
    required bool isSelected,
    required String imagePath,
    required String label,
  }) {
    return Container(
      width: 165.w,
      height: 215.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.black.withOpacity(0.5),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(
                              color: AppColors.yellowBtnColor, width: 5)
                          : null,
                      shape: BoxShape.circle),
                  child: Image.asset(
                    imagePath,
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12.h),
                const Divider(
                  color: AppColors.grey300,
                  height: 2,
                ),
                SizedBox(height: 22.h),
                Text(
                  label,
                  style: sfProDisplayRegular.copyWith(
                    fontSize: 13,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                Icons.check_circle,
                color: AppColors.yellowBtnColor,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
