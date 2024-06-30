import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';



class GuestDetailWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    ZegoController zegoController = Get.find();
    UserViewModel userViewModel = Get.find();
    return ValueListenableBuilder<List<ZegoSDKUser>>(
        valueListenable: zegoController.liveStreamingManager.coHostUserListNoti,
        builder: (context, coHostList, _) {
          ZegoSDKUser guest = coHostList[0];
          return FutureBuilder<void>(
            future: liveViewModel.addMultiHostUserModel(coHostList),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              } else if (snapshot.hasError) {
                return SizedBox();
              } else {
                return Stack(
                  children: [
                    Positioned(
                      right: 8,
                      top: 8.h,
                      child: GetBuilder<UserViewModel>(
                          init: userViewModel,
                          builder: (controller) {
                            return Container(
                              padding: const EdgeInsets.only(left: 15, right: 4, top: 4, bottom: 4),
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.black.withOpacity(0.7),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${guest.userName}🔥🔥', style: sfProDisplayRegular.copyWith(fontSize: 12.sp),),
                                  SizedBox(width: 10.w),
                                  if(userViewModel.followingUser(liveViewModel.multiGuestCoHostList[0] ))
                                    GestureDetector(
                                      onTap: (){
                                        userViewModel.followOrUnFollow(liveViewModel.multiGuestCoHostList[0].objectId!);
                                      },
                                      child: Container(
                                        width: 24.r,
                                        height: 24.r,
                                        child: Image.asset(AppImagePath.filterStar),
                                      ),
                                    ),
                                  if(!userViewModel.followingUser(liveViewModel.multiGuestCoHostList[0]))
                                  GestureDetector(
                                    onTap: (){
                                      userViewModel.followOrUnFollow(liveViewModel.multiGuestCoHostList[0].objectId!);
                                    },
                                    child: CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: AppColors.yellowColor,
                                      child: const Icon(Icons.add, color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }
                      ),
                    ),
                    Positioned(
                      top: 62.h,
                      right: 20,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: guest.isMicOnNotifier,
                          builder: (context, isMicOn, _) {
                            return Visibility(
                              visible: isMicOn==false,
                              child: Container(

                                child: Image.asset(
                                  AppImagePath.muteIcon,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                      ),),

                  ],
                );
              }
            },
          );
            }
          );

  }
}
