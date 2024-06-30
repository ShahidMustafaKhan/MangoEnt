import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:teego/utils/Utils.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view/screens/chat/widgets/message_view_bottom_bar.dart';
import 'package:teego/view/screens/chat/widgets/message_view_topbar.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../helpers/quick_actions.dart';
import '../../../helpers/quick_help.dart';
import '../../../parse/MessageListModel.dart';
import '../../../parse/MessageModel.dart';
import '../../../ui/container_with_corner.dart';
import '../../../ui/text_with_tap.dart';
import '../../../view_model/chat_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode1 = FocusNode();


  @override
  void initState() {
    super.initState();

    _focusNode1.addListener(_scrollToBottom);
    super.initState();
  }

  void _scrollToBottom() {
    if (_focusNode1.hasFocus) {
      Future.delayed(Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }


  // void _scrollToLastIndex() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: Duration(microseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  //
  // }

  void _scrollToLastIndex2() {
    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(microseconds: 2000),
        curve: Curves.easeOut,
      );
    });

  }


  @override
  void dispose() {
    _focusNode1.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ChatViewModel chatViewModel= Get.put(ChatViewModel(Get.arguments));
    return BaseScaffold(
      body: GetBuilder<ChatViewModel>(
          init: chatViewModel,
          builder: (controller) {
            return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                MessageViewTopBar(),
                Expanded(
                  child: FutureBuilder<List<dynamic>?>(
                      future: chatViewModel.loadMessages(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // _scrollToLastIndex2();
                          chatViewModel.results = snapshot.data as List<dynamic>;
                          var reversedList = chatViewModel.results.reversed.toList();
                          return StickyGroupedListView<dynamic, DateTime>(
                            shrinkWrap: true,
                            elements: reversedList,
                            reverse: true,
                            order: StickyGroupedListOrder.DESC,
                            padding: EdgeInsets.only(bottom: 7.h),
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
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15, top: 15),
                                child: TextWithTap(
                                  QuickHelp.getMessageTime(element.createdAt != null
                                      ? element.createdAt!
                                      : DateTime.now()),
                                  textAlign: TextAlign.center,
                                  color: Color(0xFFB5B9C5),
                                  fontSize: 12,
                                ),
                              );
                            },
                            itemBuilder: (context, dynamic chatMessage) {
                              bool isMe =
                              chatMessage.getAuthorId! == Get.find<UserViewModel>().currentUser.objectId!
                                  ? true
                                  : false;
                              if (!isMe && !chatMessage.isRead!) {
                                chatViewModel.updateMessageStatus(chatMessage);
                              }

                              if (chatMessage.getMessageList != null &&
                                  chatMessage.getMessageList!.getAuthorId ==
                                      chatViewModel.mUser!.objectId) {
                                MessageListModel chatList =
                                chatMessage.getMessageList as MessageListModel;

                                if (!chatList.isRead! &&
                                    chatList.objectId ==
                                        chatMessage.getMessageListId) {
                                  chatViewModel.updateMessageList(chatMessage.getMessageList!);
                                }
                              }


                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
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
                                        child: ClipOval(
                                          child: Image.network(
                                            chatMessage.getAuthor!.getAvatar!.url!,
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                    ],
                                    if(chatMessage.getMessageType ==
                                        MessageModel.messageTypeText)
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
                                            topLeft: Radius.circular(
                                                !isMe ? 4.r : 18.r),
                                            bottomLeft: Radius.circular(
                                                !isMe ? 18.r : 4.r),
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
                                        MessageModel.messageTypeGif)
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
                                    if (chatMessage.getMessageType ==
                                        MessageModel.messageTypePicture)
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          pictureMessage(chatMessage
                                              .getPictureMessage),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              TextWithTap(
                                                chatMessage.createdAt !=
                                                    null
                                                    ? QuickHelp
                                                    .getMessageTime(
                                                    chatMessage
                                                        .createdAt!,
                                                    time: true)
                                                    : "sending_".tr(),
                                                fontSize: 12,
                                                marginRight: 10,
                                                marginLeft: 10,
                                              ),

                                            ],
                                          )
                                        ],
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
                MessageViewBottomBar(),
                SizedBox(height: 10.h),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget pictureMessage(ParseFileBase picture) {
    return Column(
      children: [
        ContainerCorner(
          color: Colors.transparent,
          borderRadius: 20,
          onTap: () => openPicture(picture),
          child: Column(
            children: [
              ContainerCorner(
                color: Colors.transparent,
                marginTop: 5,
                marginLeft: 5,
                marginRight: 5,
                height: 200,
                width: 200,
                marginBottom: 5,
                child: QuickActions.photosWidget(
                    picture.saved ? picture.url : "",
                    borderRadius: 20,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openPicture(ParseFileBase picture) async {
    showModalBottomSheet(
        context: (context),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        builder: (context) {
          return _showMessagePictureBottomSheet(picture);
        });
  }

  _showMessagePictureBottomSheet(ParseFileBase picture) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: DraggableScrollableSheet(
            initialChildSize: 1.0,
            minChildSize: 0.1,
            maxChildSize: 1.0,
            builder: (_, controller) {
              return StatefulBuilder(builder: (context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: ContainerCorner(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height - 200,
                    child: QuickActions.photosWidget(picture.url,
                        borderRadius: 5, fit: BoxFit.contain),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
