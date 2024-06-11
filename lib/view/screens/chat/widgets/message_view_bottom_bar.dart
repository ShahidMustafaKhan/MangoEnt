import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_sheet.dart';
import 'package:teego/view_model/chat_controller.dart';

import '../../../../parse/MessageModel.dart';
import '../../../../utils/theme/colors_constant.dart';
import 'message_gift_sheet.dart';

class MessageViewBottomBar extends StatelessWidget {
  final Function() onTap;
  MessageViewBottomBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatViewModel chatViewModel = Get.find();
    RxString text= ''.obs;
    return Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40.h,
              width: text.isNotEmpty ? 300.w : 190.w,
              child: TextField(
                controller: chatViewModel.messageController,
                onChanged: (value){
                  text.value=value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff494848),
                  hintText: ' Aa',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixIcon: Icon(Icons.emoji_emotions),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                ),
              ),
            ),
            // SizedBox(width: 50.w,),
            // if(text.value.isEmpty)
            // Container(
            //   height: 36.h,
            //   width: 36.w,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //   ),
            //   child: Center(
            //     child: Image.asset(
            //       AppImagePath.chatMic,
            //       height: 24.h,
            //       width: 18.w,
            //     ),
            //   ),
            // ),
            if(text.value.isEmpty)
              GestureDetector(
                onTap: ()=> chatViewModel.choosePhotoFromGallery(context),
                child: Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppImagePath.chatPhoto,
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
            ),
              ),
            if(text.value.isEmpty)
              GestureDetector(
                onTap: ()=> chatViewModel.choosePhotoFromCamera(context),
                child: Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppImagePath.chatCamera,
                    height: 22.h,
                    width: 25.w,
                  ),
                ),
            ),
              ),
            GestureDetector(
              onTap: (){
                if(text.value.isNotEmpty){
                chatViewModel.saveMessage(chatViewModel.messageController.text,
                    messageType: MessageModel.messageTypeText, onTap: onTap);
                chatViewModel.messageController.text = "";
                chatViewModel.changeButtonIcon("");
                chatViewModel.update();

                }
                else{
                  openBottomSheet(MessageGiftSheet(), context);
                }
              },
              child: Container(
                height: 36.h,
                width: 36.w,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: text.value.isEmpty ? Color(0xffE5375A) :  AppColors.yellowBtnColor),
                child: Center(
                  child: text.value.isEmpty ? Image.asset(
                    AppImagePath.giftIcon,
                    height: 20.h,
                    width: 20.w,
                  ) : Icon(Icons.send, color: AppColors.white,),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
