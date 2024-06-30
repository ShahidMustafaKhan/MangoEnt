import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/dashboard/profile/widget/about_widget.dart';
import 'package:teego/view/screens/dashboard/profile/widget/post_widget.dart';
import 'package:teego/view/screens/dashboard/profile/widget/profile_tabs.dart';
import 'package:teego/view/screens/dashboard/profile/widget/profile_top_bar.dart';
import 'package:teego/view/screens/dashboard/profile/widget/video_widget.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../../../../view_model/streamer_profile_controller.dart';
import '../../../widgets/base_scaffold.dart';
import '../../userProfileView/widget/user_profile_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final StreamerProfileController controller =
  Get.put(
      StreamerProfileController(Get.arguments['otherProfile'],
          Get.arguments['otherProfile']==false ?  Get.find<UserViewModel>().currentUser : Get.arguments['mUser'] ));
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      safeArea: true,
      body:GetBuilder<StreamerProfileController>(
          init: controller,
          builder: (controller) {
            return Column(
            children: [
              ProfileTopBar(),
              SizedBox(height: 40.h),
              ProfileTabs(),
              Obx(() {
                switch (controller.selectedIndex.value) {
                  case 0:
                    return VideoWidget();
                  case 1:
                    return AboutWidget();
                  default:
                    return Container();
                }
              }),
              if(controller.otherProfile==true)
              UserProfileBottomBar(),
              SizedBox(
                height: 10.h,
              ),
            ],
          );
        }
      ),
    );
  }
}
