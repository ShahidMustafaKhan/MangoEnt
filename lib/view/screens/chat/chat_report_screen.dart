import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/chat_controller.dart';

class ChatReportScreen extends StatefulWidget {
  const ChatReportScreen({Key? key}) : super(key: key);

  @override
  State<ChatReportScreen> createState() => _ChatReportScreenState();
}

class _ChatReportScreenState extends State<ChatReportScreen> {
  List<bool> _selectedStates = List.generate(11, (index) => false);

  ChatViewModel chatViewModel = Get.find();

  TextEditingController reasonEditingController = TextEditingController();

  void _toggleSelection(int index) {
    setState(() {
      _selectedStates[index] = !_selectedStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      chatViewModel.uploadPhoto=null;
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 120.w),
                  Text(
                    "Report",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Color(0xff494848),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppImagePath.profilePic,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10.w),
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
                  SizedBox(height: 30.h),
                  Column(
                    children: [
                      _buildReportRow(0, 1),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildReportRow(2, 3),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildReportRow(4, 5),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildReportRow(6, 7),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildReportRow(8, 9),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildSingleReportOption(10),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  GetBuilder<ChatViewModel>(
                      init: chatViewModel,
                      builder: (controller) {
                        return Row(
                        children: [
                          GestureDetector(
                            onTap : ()=> chatViewModel.choosePhotoFromGallery(context, upload: true),
                            child: Container(
                              height: 58.h,
                              width: 58.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.yellow,
                                  )),
                              child: Center(
                                child: chatViewModel.uploadPhoto == null
                                      ? Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ) : chatViewModel.uploadPhoto is File ? Image.file(File(chatViewModel.uploadPhoto), fit: BoxFit.fill) : Image.memory(chatViewModel.uploadPhoto, fit: BoxFit.fill,),
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "upload photo or video",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          )
                        ],
                      );
                    }
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 343.w,
                    child: TextField(
                      controller: reasonEditingController,
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "Please briefly describe your reason",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Color(0xffB9B8BB),
                        contentPadding:
                            EdgeInsets.only(left: 20.h, top: 10.h, bottom: 80),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.top,
                      minLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Upload a screenshot to help us review your report",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  PrimaryButton(
                    onTap: () {
                      if(reasonEditingController.text.isNotEmpty){
                        chatViewModel.uploadPhoto=null;
                        QuickHelp.showAppNotification(title: 'Report Submitted successfully!', context: context, isError: false);
                        Get.back();
                        Get.back();
                      }
                      else{
                        QuickHelp.showAppNotificationAdvanced(title: 'Please briefly describe your reason!', context: context);
                      }
                    },
                    title: "Send",
                    textColor: Colors.black,
                    bgColor: AppColors.yellowBtnColor,
                    borderRadius: 35,
                    width: 342.w,
                    height: 48,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportRow(int index1, int index2) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          _buildReportOption(index1),
          SizedBox(width: 10.w),
          _buildReportOption(index2),
        ],
      ),
    );
  }

  Widget _buildSingleReportOption(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          _buildReportOption(index),
        ],
      ),
    );
  }

  Widget _buildReportOption(int index) {
    List<String> reportOptions = [
      "Pornography",
      "Language harassment",
      "Advertising harassment",
      "Insulting",
      "Inappropriate nick name",
      "Political violation",
      "Under-age",
      "Other violations",
      "Racial discrimination",
      "Suicide or Self-harm",
      "Inappropriate username/cover/introduction",
    ];

    return GestureDetector(
      onTap: () => _toggleSelection(index),
      child: Container(
        width: _getContainerWidth(index).w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: _selectedStates[index] ? Colors.yellow : Color(0xff212121),
          border: Border.all(color: AppColors.grey300),
        ),
        child: Center(
          child: Text(
            reportOptions[index],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: _selectedStates[index] ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  double _getContainerWidth(int index) {
    List<double> widths = [101, 157, 166, 75, 168, 124, 90, 118, 147, 147, 278];
    return widths[index];
  }
}
