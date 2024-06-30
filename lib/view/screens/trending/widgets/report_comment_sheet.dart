import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/parse/PostsModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../parse/CommentsModel.dart';

class ReportCommentSheet extends StatelessWidget {
  final CommentsModel? comment;
  final PostsModel? post;
  final bool? forPost;
  const ReportCommentSheet({this.comment, this.post, this.forPost=false});



  @override
  Widget build(BuildContext context) {
    List<String> reports = [
      forPost==false ? 'Report Comment' : 'Report Reel',
      'Nudity or pornography',
      'Hate speech or symbols',
      'Violence and threat of violence',
      'Sale or promotion of firearms',
      'Sale or promotion of drugs',
      'Harrasment or bullying',
      'Self injury',
    ];
    return SizedBox(
      height: 580.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            ...List.generate(
              reports.length,
              (index) => GestureDetector(
                onTap: () {
                  if(index!=0){

                  if(forPost==true){
                    post!.setReport={"id":Get.find<UserViewModel>().currentUser.objectId!};
                    post!.save().then((value) {
                      Get.back();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF494848),
                            elevation: 2,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppImagePath.reportConfirmation,
                                  height: 68.h, // A
                                  width: 68.w,
                                ),
                                SizedBox(height: 40.h),
                                Text(
                                  'Thanks for reporting this Reel',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      title: "Close",
                                      textColor: AppColors.black,
                                      borderRadius: 35,
                                      bgColor: AppColors.yellowBtnColor,
                                      borderColor: AppColors.yellowBtnColor,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      );

                    });
                  }
                  else{
                    comment!.setReport=Get.find<UserViewModel>().currentUser.objectId!;
                    comment!.save().then((value) {
                      Get.back();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF494848),
                            elevation: 2,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppImagePath.reportConfirmation,
                                  height: 68.h, // A
                                  width: 68.w,
                                ),
                                SizedBox(height: 40.h),
                                Text(
                                  'Thanks for reporting this Comment',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      title: "Close",
                                      textColor: AppColors.black,
                                      borderRadius: 35,
                                      bgColor: AppColors.yellowBtnColor,
                                      borderColor: AppColors.yellowBtnColor,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      );

                    });
                  }}


                },
                child: Container(
                  color: const Color(0xff363339),
                  child: Column(
                    children: [
                      const Divider(color: AppColors.grey300),
                      SizedBox(height: 12.h),
                      Text(
                        reports[index],
                        style: sfProDisplaySemiBold.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 14.h),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              title: 'Cancel',
              borderRadius: 12.r,
              textStyle: sfProDisplayBold.copyWith(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
              bgColor: AppColors.yellowBtnColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
