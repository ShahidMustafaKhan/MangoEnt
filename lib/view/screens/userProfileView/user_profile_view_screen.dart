import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/userProfileView/widget/about_widget.dart';
import 'package:teego/view/screens/userProfileView/widget/post_widget.dart';
import 'package:teego/view/screens/userProfileView/widget/user_profile_bottom_bar.dart';
import 'package:teego/view/screens/userProfileView/widget/user_profile_tabs.dart';
import 'package:teego/view/screens/userProfileView/widget/user_profile_top_bar.dart';
import 'package:teego/view/screens/userProfileView/widget/video_widget.dart';
import '../../../view_model/user_profile_controller.dart';
import '../../widgets/base_scaffold.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({Key? key}) : super(key: key);

  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      safeArea: true,
      body: Column(
        children: [
          UserProfileTopBar(),
          SizedBox(height: 20.h),
          UserProfileTabs(),
          Expanded(
            child: Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return PostWidget();
                case 1:
                  return VideoWidget();
                case 2:
                  return AboutWidget();
                default:
                  return Container();
              }
            }),
          ),
          UserProfileBottomBar(),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
