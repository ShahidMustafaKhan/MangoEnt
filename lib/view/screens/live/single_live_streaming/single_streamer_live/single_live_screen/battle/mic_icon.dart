import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../../view_model/live_controller.dart';
import '../../../../zegocloud/zim_zego_sdk/zego_live_streaming_manager.dart';
import '../../../../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';



class MicIcon extends StatefulWidget {
  MicIcon();

  @override
  State<MicIcon> createState() => _MicIconState();
}

class _MicIconState extends State<MicIcon> {

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return Positioned(
      bottom: 5,
      right: 50,
      left: 0,
      child: GetBuilder<ZegoController>(
          init: zegoController,
          builder: (controller) {
            if(Get.find<LiveViewModel>().role==ZegoLiveRole.audience ? ZegoLiveStreamingManager().hostNoti.value!=null : ZEGOSDKManager.instance.currentUser!=null)
            return ValueListenableBuilder<bool>(
              valueListenable: Get.find<LiveViewModel>().role==ZegoLiveRole.audience ? ZegoLiveStreamingManager().hostNoti.value!.isMicOnNotifier : ZEGOSDKManager.instance.currentUser!.isMicOnNotifier,
              builder: (context, isMicOn, _) {
                return Visibility(
                  visible: isMicOn==false,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Image.asset(
                    AppImagePath.micIcon,
                    width: 20,
                    height: 20,
                    color: AppColors.yellowBtnColor,
                  ),
                ),
              );
            }
          );
            else
              return SizedBox();
        }
      ),
    );
  }
}
