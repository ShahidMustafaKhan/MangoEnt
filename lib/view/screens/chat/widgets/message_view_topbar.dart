import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../helpers/quick_actions.dart';
import '../../../../view_model/chat_controller.dart';

class MessageViewTopBar extends StatelessWidget {
  const MessageViewTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatViewModel chatViewModel= Get.find();
    UserViewModel userViewModel= Get.find();
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (controller) {
          return Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            QuickActions.avatarWidget(
              chatViewModel.mUser!,
              width: 36.w,
              height: 36.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatViewModel.mUser!.getFullName ?? '',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  "id: ${chatViewModel.mUser!.getUid!.toString()}",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Spacer(),
            if(userViewModel.followingUser(chatViewModel.mUser!))
              GestureDetector(
              onTap: () {
                userViewModel.followOrUnFollow(chatViewModel.mUser!.objectId!);
                // Get.toNamed(AppRoutes.chatSettingScreen);
              },
              child: Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Color(0xffE43659),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppImagePath.star,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
            if(!userViewModel.followingUser(chatViewModel.mUser!))
              GestureDetector(
                onTap: () {
                  userViewModel.followOrUnFollow(chatViewModel.mUser!.objectId!);
                },
                child: Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppColors.yellowBtnColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            GestureDetector(onTap:()=> Get.toNamed(AppRoutes.chatSettingScreen), child: Icon(Icons.more_vert)),
          ],
        );
      }
    );
  }
}
