import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/multi_guest_grid_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/zego_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../zego_multi_live_view.dart';

class SixExpandedMultiGuestView extends StatelessWidget {
  SixExpandedMultiGuestView({Key? key}) : super(key: key);

  final GridController gridController = Get.find();

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    GridController gridController = Get.find();
    return ValueListenableBuilder<ZegoSDKUser?>(
        valueListenable: zegoController.liveStreamingManager.hostNoti,
        builder: (context, host, _) {
          return ValueListenableBuilder<List<ZegoSDKUser>>(
            valueListenable: zegoController.liveStreamingManager
                .coHostUserListNoti,
            builder: (context, coHostList, _) {
               int length = coHostList.length;

              return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                    children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              if(gridController.seat!= null && coHostList.length>=gridController.seat!)
                                Expanded(
                                flex: 2,
                                child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: ZegoMultiLiveView(userInfo: gridController.seat==0 ? host : coHostList[gridController.seat! - 1 ], seat: gridController.seat!,)
                                  //  CameraPreview(widget.cameraController),
                                ),
                              ),
                              if(gridController.seat == null || coHostList.length<gridController.seat!)
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.black.withOpacity(0.2),
                                        border: Border(
                                          right: BorderSide(color: AppColors.grey300, width: 1),
                                        )
                                    ),
                                    child: Center(child: Text('The co-host has left the session.', style: sfProDisplayRegular.copyWith(
                                      fontSize: 14.sp,
                                    ),)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: getUser(1, coHostList , host),
                              ),
                              Divider(
                                color: AppColors.grey300,
                                height: 2.0,
                              ),
                              Expanded(
                                child: getUser(2, coHostList , host),
                              ),
                              Divider(
                                color: AppColors.grey300,
                                height: 2.0,
                              ),
                              Expanded(
                                child: getUser(3, coHostList , host),
                              ),
                              Divider(color: AppColors.grey300, height: 2),
                              Expanded(
                                child: getUser(4, coHostList , host),
                              ),
                              Divider(color: AppColors.grey300, height: 2),
                              Expanded(
                                child: getUser(4, coHostList , host),
                              ),


                            ],
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

  Widget getUser(int index, List<ZegoSDKUser> coHostList, ZegoSDKUser? host){
    if(gridController.seat==index){
      return ZegoMultiLiveView(userInfo: host, seat: 0,);
    }
    else
      return ZegoMultiLiveView(userInfo: coHostList.length >= index ? coHostList[index - 1 ] : null, seat: index,);
  }
}
