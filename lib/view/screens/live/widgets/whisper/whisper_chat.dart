import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:teego/view/screens/live/widgets/whisper/whisper_sheet.dart';
import 'package:teego/view_model/whisper_list_controller.dart';

import '../../../../../helpers/quick_actions.dart';
import '../../../../../helpers/quick_help.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../parse/WhisperListModel.dart';
import '../../../../../parse/WhisperModel.dart';
import '../../../../../ui/text_with_tap.dart';
import '../../../../../utils/Utils.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import '../../../../../view_model/userViewModel.dart';
import '../../../../../view_model/whisper_controller.dart';
import '../../../chat/widgets/message_gift_sheet.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';

class WhisperChat extends StatefulWidget {
  final UserModel? mUser;
  WhisperChat(this.mUser);

  @override
  State<WhisperChat> createState() => _WhisperChatState();
}

class _WhisperChatState extends State<WhisperChat> {
  late WhisperViewModel whisperViewModel;
  WhisperListViewModel whisperListViewModel = Get.find();


  @override
  void initState() {
    whisperViewModel= Get.put(WhisperViewModel(widget.mUser));
    if(Get.find<LiveViewModel>().role == ZegoLiveRole.audience)
    whisperListViewModel.loadMessagesList();
    super.initState();
  }

  @override
  void dispose() {
    if (whisperViewModel.subscription != null) {
      whisperViewModel.liveQuery.client.unSubscribe(whisperViewModel.subscription!);
    }
    if(Get.find<LiveViewModel>().role == ZegoLiveRole.audience)
      whisperListViewModel.disposeLiveQuery();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhisperListViewModel>(
        builder: (controller) {
          return GetBuilder<WhisperViewModel>(
              builder: (whisperViewModel) {
                return Container(
              height: 520.h,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap:(){
                                  Get.back();
                                },
                                child: Icon(Icons.arrow_back_ios, size: 20.w,)),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 36.h,
                              width: 36.w,
                              decoration:
                              BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                              child: ClipOval(
                                child: Image.network(
                                  widget.mUser!.getAvatar!.url!,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              widget.mUser!.getFullName ?? '',
                              style:
                              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(
                          color: AppColors.grey300,
                          height: 5,
                        ),
                        Expanded(
                          child: FutureBuilder<List<dynamic>?>(
                              future: whisperViewModel.loadMessages(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  // _scrollToLastIndex2();
                                  whisperViewModel.results = snapshot.data as List<dynamic>;
                                  var reversedList = whisperViewModel.results.reversed.toList();
                                  return StickyGroupedListView<dynamic, DateTime>(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 10),
                                    elements: reversedList,
                                    reverse: true,
                                    order: StickyGroupedListOrder.DESC,
                                    // Check first
                                    groupBy: (dynamic message) {
                                      if (message.createdAt != null) {
                                        return DateTime(message.createdAt!.year,
                                            message.createdAt!.month, message.createdAt!.day);
                                      } else {
                                        return DateTime(DateTime.now().year,
                                            DateTime.now().month, DateTime.now().day);
                                      }
                                    },
                                    floatingHeader: true,
                                    groupComparator: (DateTime value1, DateTime value2) {
                                      return value1.compareTo(value2);
                                    },
                                    itemComparator: (dynamic element1, dynamic element2) {
                                      if (element1.createdAt != null &&
                                          element2.createdAt != null) {
                                        return element1.createdAt!
                                            .compareTo(element2.createdAt!);
                                      } else if (element1.createdAt == null &&
                                          element2.createdAt != null) {
                                        return DateTime.now().compareTo(element2.createdAt!);
                                      } else if (element1.createdAt != null &&
                                          element2.createdAt == null) {
                                        return element1.createdAt!.compareTo(DateTime.now());
                                      } else {
                                        return DateTime.now().compareTo(DateTime.now());
                                      }
                                    },
                                    groupSeparatorBuilder: (dynamic element) {
                                      return element.createdAt != null ? Padding(
                                        padding: EdgeInsets.only(bottom: 0, top: 3),
                                        child: TextWithTap(
                                          QuickHelp.getMessageTime(element.createdAt != null
                                              ? element.createdAt!
                                              : DateTime.now()),
                                          textAlign: TextAlign.center,
                                          color: Color(0xFFB5B9C5),
                                          fontSize: 12,
                                        ),
                                      ) : SizedBox();
                                    },
                                    itemBuilder: (context, dynamic chatMessage) {
                                      bool isMe =
                                      chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId!
                                          ? true
                                          : false;
                                      if (!isMe && !chatMessage.isRead!) {
                                        whisperViewModel.updateMessageStatus(chatMessage);
                                      }

                                      if (chatMessage.getMessageList != null &&
                                          chatMessage.getMessageList!.getAuthorId ==
                                              whisperViewModel.mUser!.objectId) {
                                        WhisperListModel chatList =
                                        chatMessage.getMessageList as WhisperListModel;

                                        if (!chatList.isRead! &&
                                            chatList.objectId ==
                                                chatMessage.getMessageListId) {
                                          whisperViewModel.updateMessageList(chatMessage.getMessageList!);
                                        }
                                      }


                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Row(
                                          mainAxisAlignment: !isMe
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.end,
                                          children: [
                                            if (!isMe) ...[
                                              Container(
                                                height: 28.h,
                                                width: 28.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: widget.mUser!.getAvatar!=null ? ClipOval(
                                                  child: Image.network(
                                                    widget.mUser!.getAvatar!.url!,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ) : SizedBox(),
                                              ),
                                              SizedBox(width: 10.w),
                                            ],
                                            if(chatMessage.getMessageType ==
                                                WhisperModel.messageTypeText)
                                            Flexible(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 12.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: !isMe
                                                      ? Color(0xff494848)
                                                      : Color(0xffffffff).withOpacity(0.05),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(!isMe ? 4.r : 18.r),
                                                    bottomLeft:
                                                    Radius.circular(!isMe ? 18.r : 4.r),
                                                    topRight: Radius.circular(18.r),
                                                    bottomRight: Radius.circular(18.r),
                                                  ),
                                                ),
                                                child: Text(
                                                  chatMessage.getDuration!,

                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if(chatMessage.getMessageType ==
                                                WhisperModel.messageTypeGif)
                                              Container(
                                                // width: 120.w,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 1.34.h,
                                                  horizontal: 8.w,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 4.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: !isMe
                                                      ? Color(0xff494848)
                                                      : Color(0xffffffff).withOpacity(0.05),
                                                  borderRadius: BorderRadius.all(Radius.circular(64.r)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Image.asset(chatMessage.getGifUrl, height: 45.32.w,width: 45.32.w,),
                                                    SizedBox(width: 4,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Sent Gift",
                                                          style: SafeGoogleFont(
                                                            "Inter",
                                                            color: Color(0xffF5AF03),
                                                            fontSize: 13.42.sp,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "x${chatMessage.getGifAmount}",
                                                          style: SafeGoogleFont(
                                                            "Inter",
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (isMe) ...[
                                              SizedBox(width: 10.w),
                                              Container(
                                                height: 16.h,
                                                width: 16.w,
                                                // decoration: BoxDecoration(
                                                //     shape: BoxShape.circle,
                                                //     color: Color(0xff1E2121),
                                                //     border: Border.all(
                                                //       color: Colors.white,
                                                //     )),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    chatMessage.isRead!
                                                        ? "assets/svg/seen.svg"
                                                        : chatMessage.createdAt != null ? "assets/svg/send.svg" :  "assets/svg/waiting.svg",


                                                  ),
                                                ),
                                              ),
                                            ],


                                            // if (!isUserMessage) ...[
                                            //   SizedBox(width: 10.w),
                                            //   Container(
                                            //     height: 28.h,
                                            //     width: 28.w,
                                            //     decoration: BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //     ),
                                            //     child: Image.asset(
                                            //       AppImagePath.profilePic,
                                            //       height: double.infinity,
                                            //       width: double.infinity,
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   ),
                                            // ],
                                          ],
                                        ),
                                      );
                                    },
                                  );}
                                else if (snapshot.hasError) {
                                  return Center(
                                    child: QuickActions.noContentFound(
                                        "message_screen.no_chat_title".tr(),
                                        "message_screen.no_chat_explain".tr(),
                                        "assets/svg/ic_tab_chat_default.svg"),
                                  );
                                } else {
                                  return Center(
                                    child: QuickHelp.showLoadingAnimation(),
                                  );
                                }
                              }
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                whisperViewModel.saveMessage(whisperViewModel.messageController.text,
                                    messageType: WhisperModel.messageTypeText, onTap: (){});
                                whisperViewModel.messageController.text = "";
                                whisperViewModel.update();
                              },
                              child: Container(
                                height: 36.h,
                                width: 36.w,
                                // decoration: BoxDecoration(
                                //     shape: BoxShape.circle, color: Color(0xffE5375A)),
                                // child: Center(
                                //   child: Image.asset(
                                //     AppImagePath.giftIcon,
                                //     height: 20.h,
                                //     width: 20.w,
                                //   ),
                                // ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 40.h,
                              width: 286.w,
                              // child: TextField(
                              //   controller: whisperViewModel.messageController,
                              //   onSubmitted: (value){
                              //     whisperViewModel.saveMessage(whisperViewModel.messageController.text,
                              //         messageType: WhisperModel.messageTypeText, onTap: (){});
                              //     whisperViewModel.messageController.text = "";
                              //     whisperViewModel.update();
                              //   },
                              //   decoration: InputDecoration(
                              //     filled: true,
                              //     fillColor: Color(0xff494848),
                              //     hintText: ' Aa',
                              //     hintStyle: TextStyle(color: Colors.black),
                              //     suffixIcon: Icon(Icons.emoji_emotions),
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(90.0),
                              //       borderSide: BorderSide.none,
                              //     ),
                              //     contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, MediaQuery.of(context).viewInsets.bottom+15),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                             openBottomSheet(MessageGiftSheet(whisper: true,), context);
                            },
                            child: Container(
                              height: 36.h,
                              width: 36.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Color(0xffE5375A)),
                              child: Center(
                                child: Image.asset(
                                  AppImagePath.giftIcon,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            height: 40.h,
                            width: 286.w,
                            child: TextField(
                              controller: whisperViewModel.messageController,
                              onSubmitted: (value){
                                whisperViewModel.saveMessage(whisperViewModel.messageController.text,
                                    messageType: WhisperModel.messageTypeText, onTap: (){});
                                whisperViewModel.messageController.text = "";
                                whisperViewModel.update();
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
                                contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        );
            }
          );
      }
    );
  }
}