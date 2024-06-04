import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import '../../../../../view_model/live_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';

class MultiGuestGridSettings extends StatelessWidget {
  final ZegoSDKUser? user;
  MultiGuestGridSettings(this.user);

  final GridController _controller = Get.find<GridController>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: user!.isCamerOnNotifier,
        builder: (context, cameraOn, _) {
          return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
             Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                SizedBox(width: 5.w),
                                Text(
                                  'Setting',
                                  style: sfProDisplayMedium.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _controller.isExpanded.value,
                            child: GestureDetector(
                              onTap: (){
                                Get.back();
                                _controller.isExpanded.value=false;
                                Get.find<LiveViewModel>().setExpandedFeature(false, null);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImagePath.multiGuestExpandIcon,
                                    color: AppColors.yellowBtnColor,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'Expand',
                                    style: sfProDisplayMedium.copyWith(
                                        fontSize: 14, color: AppColors.yellowBtnColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const Divider(color: AppColors.grey300, thickness: 1.2),
                    ],
                  ),

              SizedBox(height: 30.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 270.h,
                  width: 200.w,
                  child: Stack(children: [
                    if(cameraOn==true)
                      ValueListenableBuilder<Widget?>(
                          valueListenable: user!.videoViewNotifier,
                          builder: (context, video, _) {
                            if(video != null)
                            return video;
                            return Container(
                              color: Colors.black.withOpacity(2),
                            );
                          }),

                    if(cameraOn==false)
                    Image.network(
                      user!.avatarUrlNotifier.value!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if(cameraOn==false)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 20.0),
                        child: Container(
                          color: Colors.black.withOpacity(0),
                        ),
                      ),
                    ),
                    if(cameraOn==false)
                    Align(
                        child: Container(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(user!.avatarUrlNotifier.value!),

                          ),
                        )),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: (){
                            user!.isCameraFront.value= !user!.isCameraFront.value;
                            ZEGOSDKManager.instance.expressService.useFrontCamera(user!.isCameraFront.value);
                          },
                          child: Container(
                              height: 28.h,
                              width: 28.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.grey300),
                              child: Image.asset(AppImagePath.screenShareIcon)),
                        )),
                    Positioned(
                        top: 10,
                        left: 50,
                        child: GestureDetector(
                          onTap: (){
                            ZEGOSDKManager.instance.expressService.turnCameraOn(!cameraOn);
                          },
                          child: Container(
                          height: 28.h,
                          width: 28.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.grey300),
                          child: Center(
                            child: Image.asset(
                              AppImagePath.cameraOff,
                              height: 14.h,
                              width: 14.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                            ),
                        )),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: ValueListenableBuilder<bool>(
                            valueListenable: user!.isMicOnNotifier,
                            builder: (context, micOn, _) {
                                return InkWell(
                                  onTap: (){
                                    ZEGOSDKManager.instance.expressService.turnMicrophoneOn(!micOn);
                                  },
                                  child: Container(
                                    height: 28.h,
                                    width: 28.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: AppColors.grey300),
                                    child: Center(
                                      child: Image.asset(
                                        AppImagePath.micIcon,
                                        height: 14.h,
                                        width: 14.w,
                                        color: micOn ? AppColors.white : AppColors.yellowColor,
                                      ),
                                    ),
                                  ),
                                );
                          }
                        ))
                  ]),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
             if(cameraOn == false)
              Center(
                child: Text(
                  "You'll connect using audio only",
                  style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                ),
              ),
              if(cameraOn == true)
                Center(
                  child: Text(
                    "You'll connect using audio and camera",
                    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                  ),
                ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 48.h,
                  width: 343.w,
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.yellowBtnColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: sfProDisplayMedium.copyWith(
                          color: Colors.black, fontSize: 13),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              )
            ],
          ),
        );
      }
    );
  }
}
