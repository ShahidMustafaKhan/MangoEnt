import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/six_expanded_multi_guest.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import '../../../../../../view_model/zego_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../zego_multi_live_view.dart';

class SixMultiGuestView extends StatelessWidget {
  const SixMultiGuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    GridController _controller = Get.find();
    return Expanded(
      child: Obx(() {
        if (!_controller.isExpanded.value)
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<List<ZegoSDKUser>>(
                valueListenable: zegoController.liveStreamingManager
                    .coHostUserListNoti,
                builder: (context, coHostList, _) {
                  int length = coHostList.length;
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<ZegoSDKUser?>(
                                  valueListenable: zegoController
                                      .liveStreamingManager.hostNoti,
                                  builder: (context, host, _) {
                                    if (host != null)
                                      return Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: ZegoMultiLiveView(
                                            userInfo: host, seat: 0),
                                      );
                                    else
                                      return Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: AppColors.black.withOpacity(
                                              0.3),
                                          child: Center(child: Text('Host')));
                                  }
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(child: ZegoMultiLiveView(
                                    userInfo: length >= 3
                                        ? coHostList[2]
                                        : null, seat: 3,)),
                                  Expanded(child: ZegoMultiLiveView(
                                    userInfo: length >= 4
                                        ? coHostList[3]
                                        : null, seat: 4,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: ZegoMultiLiveView(
                              userInfo: length >= 1 ? coHostList[0] : null,
                              seat: 1,)),
                            Divider(
                              color: AppColors.grey300,
                              height: 2.0,
                            ),
                            Expanded(child: ZegoMultiLiveView(
                              userInfo: length >= 2 ? coHostList[1] : null,
                              seat: 2,)),
                            Divider(color: AppColors.grey300, height: 2),
                            Expanded(child: ZegoMultiLiveView(
                              userInfo: length >= 5 ? coHostList[4] : null,
                              seat: 5,)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),
          );
        else
          return SixExpandedMultiGuestView();
      }
    ));
  }
}
