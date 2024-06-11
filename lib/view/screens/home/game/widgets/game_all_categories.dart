import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';


class GameAllCategories extends StatelessWidget {
  const GameAllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Icon(Icons.arrow_back_ios_new_outlined),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ...List.generate(
              10,
              (index) {
                if (index.isOdd) {
                  return _buildCategoryRow(
                    AppImagePath.category2,
                    ['Action', 'Horror', 'FPS'],
                  );
                } else {
                  return _buildCategoryRow(
                    AppImagePath.category1,
                    ['Action', 'Horror'],
                  );
                }
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String imagePath, List<String> categories) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 80.h,
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Alisha'),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(
                    '72,13k Views ',
                    style: sfProDisplayRegular.copyWith(
                        fontSize: 12, color: AppColors.white.withOpacity(0.7)),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: categories.map((category) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: 48.w,
                    height: 19.h,
                    decoration: BoxDecoration(
                      color: Color(0xff494848),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(AppImagePath.heart_image),
          ),
        ],
      ),
    );
  }
}
