import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/zego_multi_live_view.dart';
import 'package:teego/view_model/zego_controller.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';

class ThreeMultiGuestView extends StatelessWidget {
  ThreeMultiGuestView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 25),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<ZegoSDKUser?>(
                          valueListenable: zegoController.liveStreamingManager.hostNoti,
                          builder: (context, host, _) {
                            if(host!=null)
                            return Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: ZegoMultiLiveView(userInfo: host, seat: 0),
                          );
                            else
                              return Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: AppColors.black.withOpacity(0.3),
                              child: Center(child: Text('Host')));
                        }
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<ZegoSDKUser>>(
                          valueListenable: zegoController.liveStreamingManager.coHostUserListNoti,
                          builder: (context, coHostList, _) {
                            int length = coHostList.length;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child:  ZegoMultiLiveView(userInfo: length>=1 ? coHostList[0] : null, seat: 1,))),
                                Divider(color: AppColors.grey300, height: 1),
                                Expanded(
                                  child: ZegoMultiLiveView(userInfo: length>=2 ? coHostList[1] : null , seat: 2),
                                ),
                              ],
                            );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
