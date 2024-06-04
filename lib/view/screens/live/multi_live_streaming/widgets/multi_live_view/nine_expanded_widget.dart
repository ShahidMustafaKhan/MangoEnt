import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/zego_multi_live_view.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../active_multi_guest_options.dart';
import '../gift_received_widget.dart';
import '../multi_guest_grid_settings.dart'; // Assuming you are using screenutil for responsive sizing

class NineExpandedMultiGuestView extends StatelessWidget {
  final GridController gridController = Get.find();

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return ValueListenableBuilder<ZegoSDKUser?>(
        valueListenable: zegoController.liveStreamingManager.hostNoti,
        builder: (context, host, _) {
          return ValueListenableBuilder<List<ZegoSDKUser>>(
            valueListenable: zegoController.liveStreamingManager
                .coHostUserListNoti,
            builder: (context, coHostList, _) {

              return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(coHostList.length>=gridController.seat!)
                          Expanded(child: ZegoMultiLiveView(userInfo: coHostList[gridController.seat! - 1 ], seat: gridController.seat!)),
                          if(coHostList.length<gridController.seat!)
                            Expanded(
                              child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.black.withOpacity(0.2),
                                      border: Border(
                                      top: BorderSide(color: AppColors.grey300, width: 1),
                                      bottom: BorderSide(color: AppColors.grey300, width: 1),
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
                          Expanded(child: getUser(1, coHostList , host),),
                          Expanded(child: getUser(3, coHostList , host),),
                          Expanded(child: getUser(5, coHostList , host),),
                          Expanded(child: getUser(7, coHostList , host),),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: getUser(2, coHostList , host),),
                          Expanded(child: getUser(4, coHostList , host),),
                          Expanded(child: getUser(6, coHostList , host),),
                          Expanded(child: getUser(8, coHostList , host),),
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
