import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../view_model/user_profile_controller.dart';

class UserProfileTabs extends StatelessWidget {
  UserProfileTabs({Key? key}) : super(key: key);

  final UserProfileController controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              buildTabItem(0, "Post"),
              SizedBox(width: 15.w),
              buildTabItem(1, "Video"),
              SizedBox(width: 15.w),
              buildTabItem(2, "About"),
            ],
          ),
        ));
  }

  Widget buildTabItem(int index, String text) {
    return GestureDetector(
      onTap: () => controller.updateIndex(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: controller.selectedIndex.value == index
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 2.h,
            width: 20.w,
            color: controller.selectedIndex.value == index
                ? Colors.yellow
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
