import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/live/widgets/whisper/whisper_chat.dart';
import '../../../../../helpers/quick_actions.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../parse/WhisperListModel.dart';
import '../../../../../utils/constants/status.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/userViewModel.dart';
import '../../../../../view_model/whisper_list_controller.dart';
import '../../../../widgets/custom_buttons.dart';

class WhisperSheet extends StatefulWidget {
  const WhisperSheet();

  @override
  State<WhisperSheet> createState() => _WhisperSheetState();
}

class _WhisperSheetState extends State<WhisperSheet> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WhisperListViewModel whisperListViewModel = Get.find();
    whisperListViewModel.loadMessagesList();

    return GetBuilder<WhisperListViewModel>(
        init: whisperListViewModel,
        builder: (controller) {
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      whisperListViewModel.messagesResults.length,
                      (index) {
                        WhisperListModel chatMessage = whisperListViewModel.messagesResults[index];

                        UserModel chatUser = chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId! ? chatMessage.getReceiver! : chatMessage.getAuthor!;
                        bool isMe = chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId! ? true : false;
                        return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: AppColors.grey300,
                              backgroundImage: NetworkImage(chatUser.getAvatar!.url!),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(chatUser.getFullName ?? ''),
                                    SizedBox(width: 5.w,),
                                    if (!chatMessage.isRead! && !isMe)
                                      Container(
                                        width: 14.w,
                                        height: 14.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            chatMessage.getCounter.toString(),
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      chatMessage.getText!,
                                      style: sfProDisplayRegular.copyWith(
                                          fontSize: 12,
                                          color: AppColors.white.withOpacity(0.7)),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            PrimaryButton(
                              width: 65.w,
                              height: 32.h,
                              title: 'Chat',
                              borderRadius: 35,
                              textStyle: sfProDisplayMedium.copyWith(
                                  fontSize: 16, color: AppColors.black),
                              bgColor: AppColors.yellowBtnColor,
                              onTap: () {
                                Get.back();
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
                                      WhisperChat(chatUser),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );}
                    ),
                  ],
                ),
              ),
            ),
            if(controller.messagesResults.isEmpty && controller.status!=Status.Loading)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: QuickActions.noContentFound("message_screen.no_message_title".tr(),
                        "".tr(), "assets/svg/ic_tab_chat_default.svg"),
                  ),
                  SizedBox(height: 140.h,)
                ],
              ),
          ],
        );
      }
    );
  }
}


