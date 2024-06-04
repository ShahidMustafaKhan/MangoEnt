import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/multi_guest_grid_controller.dart';
import '../../../../../../../view_model/zego_controller.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../widgets/custom_buttons.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import 'multi_user_details_widget.dart';



class ScreenShareView extends StatelessWidget {
  final ZegoSDKUser zegoSDKUser;
  ScreenShareView(this.zegoSDKUser);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    GridController gridController = Get.find();
    bool isSeat9Or12 = gridController.isExpanded.value || liveViewModel.isMultiSeat9 || liveViewModel.isMultiSeat12;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Get.isDarkMode ? Alignment.bottomLeft : Alignment.bottomCenter,
            end: Get.isDarkMode ? Alignment.topRight : Alignment.topCenter,
            stops: Get.isDarkMode ? const [0.7, 0.9] : null,
            colors: Get.isDarkMode ? AppColors.darkBGGradientColor : AppColors.lightBGGradientColor),
        border: Border(
          top: BorderSide(color: Colors.white, width: 1),
          left: BorderSide(color: Colors.white, width: 1),
          bottom: BorderSide(color: Colors.white, width: 1),
          right: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Stack(children: [
        if(!isSeat9Or12)
        Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You are displaying your\n\t\t\tscreen to everyone",
                  style: TextStyle(
                      color: AppColors.white, fontSize: 14),
                ),
                SizedBox(height: 14.h,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF494848),
                          elevation: 2,
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          title: Text(
                            'Are you sure you want to end screen share?',
                            style: TextStyle(
                                color: AppColors.white, fontSize: 14),
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    title: "No",
                                    textColor: AppColors.black,
                                    borderRadius: 35,
                                    borderColor:
                                    AppColors.yellowBtnColor,
                                    onTap: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: PrimaryButton(
                                    title: "Yes",
                                    textColor: AppColors.black,
                                    borderRadius: 35,
                                    bgColor: AppColors.yellowBtnColor,
                                    onTap: () {
                                      Get.back();
                                      zegoController.stopScreenSharing();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Text(
                      'Stop Now',
                      style: sfProDisplayMedium.copyWith(
                          color: Colors.black, fontSize: 13),
                    ),
                  ),
                ),
              ],
            )),
        if(isSeat9Or12)
          Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Stop sharing",
                    style: TextStyle(
                        color: AppColors.white, fontSize: 12),
                  ),
                  SizedBox(height: 6.h,),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xFF494848),
                            elevation: 2,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0))),
                            title: Text(
                              'Are you sure you want to end screen share?',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 14),
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      title: "No",
                                      textColor: AppColors.black,
                                      borderRadius: 35,
                                      borderColor:
                                      AppColors.yellowBtnColor,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: PrimaryButton(
                                      title: "Yes",
                                      textColor: AppColors.black,
                                      borderRadius: 35,
                                      bgColor: AppColors.yellowBtnColor,
                                      onTap: () {
                                        Get.back();
                                        zegoController.stopScreenSharing();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Text(
                        'Stop Now',
                        style: sfProDisplayMedium.copyWith(
                            color: Colors.black, fontSize: 9),
                      ),
                    ),
                  ),
                ],
              )),
      ]),
      //  CameraPreview(widget.cameraController),
    );
  }
}
