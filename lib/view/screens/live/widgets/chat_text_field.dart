
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../parse/LiveMessagesModel.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../../../../view_model/live_messages_controller.dart';
import '../../../../view_model/userViewModel.dart';
import '../../../widgets/custom_buttons.dart';

class ChatTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    LiveMessagesViewModel liveMessagesViewModel = Get.find();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 65.h,
        color: Color(0xff252626),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller : liveViewModel.chatEditingController,
                onFieldSubmitted : (value){
                  liveViewModel.chatField.value=false;
                  if(value.isNotEmpty){
                    liveMessagesViewModel.sendMessage(LiveMessagesModel.messageTypeComment, liveViewModel.chatEditingController.text,
                        senderName: Get.find<UserViewModel>().currentUser.getFullName!, uid: Get.find<UserViewModel>().currentUser.getUid!, senderAvatarUrl: Get.find<UserViewModel>().currentUser.getAvatar!.url!);
                    liveViewModel.chatEditingController.text='';
                  }
                },
                onTapOutside : (value){
                  if(liveViewModel.chatEditingController.text.isEmpty){
                    liveViewModel.chatField.value=false;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff494848),
                  hintText: 'Aa',
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: Icon(Icons.emoji_emotions),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            PrimaryButton(
              onTap: () {
                if(liveViewModel.chatEditingController.text.isNotEmpty){
                  liveViewModel.chatField.value=false;
                  liveMessagesViewModel.sendMessage(LiveMessagesModel.messageTypeComment, liveViewModel.chatEditingController.text,
                      senderName: Get.find<UserViewModel>().currentUser.getFullName!, uid: Get.find<UserViewModel>().currentUser.getUid!, senderAvatarUrl: Get.find<UserViewModel>().currentUser.getAvatar!.url!);
                  liveViewModel.chatEditingController.text='';}

              },
              width: 56.w,
              height: 35.h,
              borderRadius: 30.r,
              bgColor: AppColors.yellowBtnColor,
              title: "Send",
              textStyle : sfProDisplayRegular.copyWith(fontSize: 14.sp, color: Colors.black),
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}