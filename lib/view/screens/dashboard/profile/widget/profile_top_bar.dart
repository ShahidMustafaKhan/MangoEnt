import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/permission/choose_photo_permission.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/screens/userProfileView/widget/share_modal_sheet.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../helpers/quick_help.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/streamer_profile_controller.dart';
import '../../../userProfileView/widget/report_option_sheet.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StreamerProfileController controller = Get.find();
    UserViewModel userViewModel = Get.find();
    String cover ;
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (userViewModel) {
          // if(controller.otherProfile==true)
          //   cover = controller.profile!.getCover != null ? controller.profile!.getCover!.url! : "https://i.pinimg.com/736x/72/5c/d9/725cd95818f384e81833a4923f1d1493.jpg";
          // else
          //   cover = userViewModel.currentUser.getCover != null ? userViewModel.currentUser!.getCover!.url! : "https://i.pinimg.com/736x/72/5c/d9/725cd95818f384e81833a4923f1d1493.jpg";
          return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    // if(controller.otherProfile==false)
                    // PermissionHandler.checkPermission(false, context);

                  },
                  child: Container(
                    width: double.infinity,
                    height: 240.h,
                    color: Colors.red,
                    child: Image.network(
                      controller.profile!.getAvatar!.url!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: GestureDetector(
                    onTap: ()=> Get.back(),
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey500,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                if(controller.otherProfile==false)
                Positioned(
                  top: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfileScreen);
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey500,
                      ),
                      child: Center(
                        child: Image.asset(AppImagePath.edit_profile),
                      ),
                    ),
                  ),
                ),
                if(controller.otherProfile==true)
                Positioned(
                  top: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      openBottomSheet(ReportOptionSheet(), context);
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey500,
                      ),
                      child: Center(child: Icon(Icons.more_vert)),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 60,
                  child: GestureDetector(
                    onTap: ()=> openBottomSheet(ShareModalSheet(), context),
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey500,
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImagePath.share,
                          height: 24.h,
                          width: 24.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        controller.profile!.getFullName ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Visibility(
                          visible: controller.profile!.isVerified,
                          child: Image.asset(AppImagePath.yellow_tick)),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "id: ${controller.profile!.getUid}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.copy,
                        size: 15,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if(controller.profile!.getHideMyBirthday! == false)
                      Container(
                        width: 36.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                          color: AppColors.progressPinkColor2,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              AppImagePath.share,
                              height: 6.h,
                              width: 6.w,
                            ),
                            Text(
                              QuickHelp.getAgeFromDate(controller.profile!.getBirthday!).toString(),
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 36.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Lv.",
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              controller.profile!.getLevel.toString(),
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      if(controller.profile!.getHideMyLocation! == false)
                        SvgPicture.asset(
                        QuickActions.getCountryFlag(controller.profile!),
                        height: 17.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${controller.profile!.getFollowing!.length}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 35.h,
                          width: 1,
                          color: AppColors.yellowBtnColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "${controller.profile!.getFollowers!.length}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 35.h,
                          width: 1,
                          color: AppColors.yellowBtnColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              "Likes",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
