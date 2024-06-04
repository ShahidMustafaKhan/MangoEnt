import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/zego_multi_live_view.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import 'nine_expanded_widget.dart'; // Assuming you are using screenutil for responsive sizing

class NineMultiGuestView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    final GridController _controller = Get.find();
    return Expanded(
      child: Obx(() {
        if (!_controller.isExpanded.value)
          return Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ValueListenableBuilder<ZegoSDKUser?>(
                valueListenable: zegoController.liveStreamingManager.hostNoti,
                builder: (context, host, _) {
                  return ValueListenableBuilder<List<ZegoSDKUser>>(
                      valueListenable: zegoController.liveStreamingManager
                          .coHostUserListNoti,
                      builder: (context, coHostList, _) {
                        int length = coHostList.length;
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return ZegoMultiLiveView(
                              userInfo: index == 0 ? host : length >= index
                                  ? coHostList[index - 1]
                                  : null, seat: index,);
                          },
                        );
                      }
                  );
                }
            ),
          );
        else
          return NineExpandedMultiGuestView();
      }));
  }
}
