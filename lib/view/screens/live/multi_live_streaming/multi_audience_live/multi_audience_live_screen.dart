import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../parse/LiveStreamingModel.dart';
import '../../../../../view_model/gift_contoller.dart';
import '../../../../../view_model/live_messages_controller.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../single_live_streaming/single_audience_live/widgets/gift_animation_view.dart';
import '../../widgets/background_image.dart';
import '../../widgets/for_you_widget.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../multi_live_widgets.dart';


class AudienceMultiLive extends StatelessWidget {
  AudienceMultiLive();
  bool hideNav=false;

  @override
  Widget build(BuildContext context) {
    final LiveViewModel liveViewModel = Get.put(LiveViewModel(ZegoLiveRole.audience, Get.arguments));
    final GiftViewModel giftViewModel = Get.put(GiftViewModel());
    ZegoController zegoController = Get.put(ZegoController(ZegoLiveRole.audience, LiveStreamingModel.keyTypeMultiGuestLive));
    final LiveMessagesViewModel liveMessagesViewModel = Get.put(LiveMessagesViewModel(liveViewModel));

    if(hideNav==false){
      hideNav=true;
      Future.delayed(Duration(milliseconds: 400), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
      });
    }
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      await Future.delayed(const Duration(seconds: 5));
      SystemChrome.restoreSystemUIOverlays();
    });

    return BaseScaffold(
      safeArea: true,
      body: GetBuilder<GiftViewModel>(init: giftViewModel, builder: (giftViewModel) {
        return Container(
          child: Stack(
            children: [
              BackgroundImage(),
              MultiLiveWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: GiftAnimationView(giftViewModel: giftViewModel,)),
            ],
          ),
        );
      }
      ),
      endDrawer: ForYou(),
    );
  }
}
