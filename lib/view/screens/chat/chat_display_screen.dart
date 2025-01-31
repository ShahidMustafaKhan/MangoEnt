import 'package:easy_localization/easy_localization.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/chat/widgets/unread_message.dart';
import 'package:teego/view_model/chat_list_controller.dart';
import '../../../helpers/quick_actions.dart';
import '../../../helpers/quick_help.dart';
import '../../../parse/MessageListModel.dart';
import '../../../parse/UserModel.dart';
import '../../../utils/constants/status.dart';
import '../../../view_model/userViewModel.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {

  int? longPressedIndex;
  ChatListViewModel chatListViewModel = Get.find();


  @override
  Widget build(BuildContext context) {
    chatListViewModel.loadMessagesList();
    return GetBuilder<ChatListViewModel>(
        init: chatListViewModel,
        builder: (controller) {
          return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Inbox",
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
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
                          backgroundColor: AppColors.grey500,
                          isScrollControlled: true,
                          builder: (context) => Wrap(
                            children: [
                              UnreadMessageWidget(),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(AppImagePath.chatScreenIcon))
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            if(chatListViewModel.status==Status.Loading)
              ListView.builder(
                padding: EdgeInsets.only(left: 5.w),
                  itemCount: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, index){

                    final delay = (index * 300);

                    return GestureDetector(
                      onTap:  (){},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            FadeShimmer.round(
                              size: 60,
                              fadeTheme: FadeTheme.dark,
                              millisecondsDelay: delay,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeShimmer(
                                  height: 8,
                                  width: Get.width /2,
                                  radius: 4,
                                  millisecondsDelay: delay,
                                  fadeTheme:
                                   FadeTheme.dark ,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                FadeShimmer(
                                  height: 8,
                                  millisecondsDelay: delay,
                                  width:  Get.width /1.5,
                                  radius: 4,
                                  fadeTheme:
                                 FadeTheme.dark ,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );

                  }),

            if(chatListViewModel.messagesResults.isNotEmpty && chatListViewModel.status!=Status.Loading)
            Container(
              height: 650.h,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 35.h),
                // itemCount: chatListViewModel.messagesResults.length,
                itemCount: chatListViewModel.messagesResults.length,
                itemBuilder: (context, index) {
                  MessageListModel chatMessage = chatListViewModel.messagesResults[index];

                  UserModel chatUser = chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId! ? chatMessage.getReceiver! : chatMessage.getAuthor!;
                  bool isMe = chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId! ? true : false;
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        longPressedIndex = index;
                      });
                    },
                    onTap: () {
                      setState(() {
                        longPressedIndex = null;
                      });

                      Get.toNamed(AppRoutes.messageView, arguments: chatUser)!.then((value) => setState((){}));
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              QuickActions.avatarWidget(
                                chatUser,
                                width: 57.w,
                                height: 57.w,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          chatUser.getFullName!,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          QuickHelp.getMessageListTime(chatMessage.updatedAt!),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            chatMessage.getText!,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        if (!chatMessage.isRead! && !isMe)
                                          Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                chatMessage.getCounter.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
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
                        if (longPressedIndex == index)
                          Positioned(
                              right: 10.w,
                              child: GestureDetector(
                                onTap: () async {
                                    ParseResponse response = await chatMessage.delete();
                                    if(response.success){
                                      // chatListViewModel.messagesResults.removeAt(index);
                                      longPressedIndex = null;
                                      setState(() { });
                                    }
                                },
                                child: Container(
                                  width: 148.w,
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff252626),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        ),
                                        Image.asset(AppImagePath.deleteCrossIcon)
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                      ],
                    ),
                  );
                },
              ),
            ),
            if(chatListViewModel.messagesResults.isEmpty && chatListViewModel.status!=Status.Loading)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: QuickActions.noContentFound("message_screen.no_message_title".tr(),
                          "message_screen.no_message_explain".tr(), "assets/svg/ic_tab_chat_default.svg"),
                    ),
                    SizedBox(height: 140.h,)
                  ],
                ),
              ),



          ],
        );
      }
    );
  }
}
