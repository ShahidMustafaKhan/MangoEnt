import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../view_model/streamer_profile_controller.dart';

class ProfileTabs extends StatelessWidget {
  ProfileTabs({Key? key}) : super(key: key);

  final StreamerProfileController controller = Get.find<StreamerProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              buildTabItem(0, "Video"),
              SizedBox(width: 20.w),
              buildTabItem(1, "About"),
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
          SizedBox(height: 5.h),
          Container(
            height: 2.h,
            width: 10.w,
            color: controller.selectedIndex.value == index
                ? Colors.yellow
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
