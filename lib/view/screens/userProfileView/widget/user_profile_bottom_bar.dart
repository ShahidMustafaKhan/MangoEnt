import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/userProfileView/widget/report_option_sheet.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/streamer_profile_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../utils/routes/app_routes.dart';
import '../../chat/widgets/message_gift_sheet.dart';

class UserProfileBottomBar extends StatelessWidget {
  const UserProfileBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();
    StreamerProfileController profileController = Get.find();
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (controller) {
          return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButton(
                  width: 133.w,
                  height: 44.h,
                  title: controller.followingUser(profileController.profile!) ? "✓ Following"  : "+ Follow",
                  textColor: AppColors.black,
                  borderRadius: 50.r,
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {
                    controller.followOrUnFollow(profileController.profile!.objectId!);
                  }),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                    backgroundColor: AppColors.grey500,
                    builder: (context) => Wrap(
                      children: [
                        MessageGiftSheet(),
                        // ReportOptionSheet(),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff494848),
                  ),
                  child: Center(
                    child: Image.asset(AppImagePath.star),
                  ),
                ),
              ),
              PrimaryButton(
                  width: 133.w,
                  height: 44.h,
                  textColor: AppColors.black,
                  borderRadius: 50.r,
                  bgColor: Color(0xff000000),
                  borderColor: AppColors.yellowBtnColor,
                  child: Row(
                    children: [
                      Image.asset(AppImagePath.message),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(
                            color: AppColors.yellowBtnColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                onTap: () {
                  Get.toNamed(AppRoutes.messageView, arguments: profileController.profile!);
                },),
            ],
          ),
        );
      }
    );
  }
}
