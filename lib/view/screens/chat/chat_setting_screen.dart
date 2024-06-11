import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../helpers/quick_actions.dart';
import '../../../helpers/quick_help.dart';
import '../../../view_model/chat_controller.dart';

class ChatSettingScreen extends StatefulWidget {
  const ChatSettingScreen({Key? key}) : super(key: key);

  @override
  State<ChatSettingScreen> createState() => _ChatSettingScreenState();
}

class _ChatSettingScreenState extends State<ChatSettingScreen> {
  bool isMuteNotification = false;
  bool isPinToTop = false;

  @override
  Widget build(BuildContext context) {
    ChatViewModel chatViewModel= Get.find();

    return BaseScaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
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
                  width: 120.w,
                ),
                Text(
                  "Chat Setting",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
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
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "id: ${chatViewModel.mUser!.getUid}",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mute Notification",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    ToggleButton(
                      isActive: isMuteNotification,
                      onChanged: (value) {
                        setState(() {
                          isMuteNotification = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  color: AppColors.grey300,
                  height: 1,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pin to Top",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    ToggleButton(
                      isActive: isPinToTop,
                      onChanged: (value) {
                        setState(() {
                          isPinToTop = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: (){
                    QuickActions.showAlertDialog(context, 'Are you sure you want to delete chat history?', (){
                        Get.back();
                        QuickHelp.showAppNotificationAdvanced(title: 'Chat history deleted!', context: context, isError: true);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        "Delete chat history",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  color: AppColors.grey300,
                  height: 2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: (){
                    QuickActions.showAlertDialog(context, 'Are you sure you want to add user to block list?', (){
                      Get.find<UserViewModel>().currentUser.setBlockedUser= chatViewModel.mUser!;
                      Get.find<UserViewModel>().currentUser.save().then((value){
                        Get.back();
                        QuickHelp.showAppNotificationAdvanced(title: 'User Added to Block List!', context: context, isError: false);
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        "Add to Block List",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  color: AppColors.grey300,
                  height: 2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.chatReportScreen);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Report",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  color: AppColors.grey300,
                  height: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ToggleButton({
    Key? key,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: Container(
        width: 51.w,
        height: 31.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: isActive ? Colors.yellow : Colors.grey,
        ),
        child: Stack(
          children: [
            Align(
              alignment:
                  isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 28.w,
                height: 28.h,
                margin: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffFFFFFF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
