import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../../view_model/gift_contoller.dart';
import '../../../../../../../view_model/battle_controller.dart';
import '../../../../../view_model/live_messages_controller.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../../../widgets/base_scaffold.dart';
import '../../single_live_streaming/single_audience_live/widgets/gift_animation_view.dart';
import '../../widgets/for_you_widget.dart';
import '../audio_live_widgets.dart';


class StreamerAudioLive extends StatelessWidget  {
  StreamerAudioLive();
  @override
  Widget build(BuildContext context) {
    final GiftViewModel giftViewModel = Get.put(GiftViewModel());
    ZegoController zegoController = Get.put(ZegoController(ZegoLiveRole.host, LiveStreamingModel.keyTypeAudioLive));
    final LiveMessagesViewModel liveMessagesViewModel = Get.put(LiveMessagesViewModel(Get.find<LiveViewModel>()));

    return WillPopScope(
      onWillPop: () => Get.find<LiveViewModel>().closeAlert(context),
      child: BaseScaffold(
        safeArea: true,
        body: GetBuilder<GiftViewModel>(builder: (giftViewModel) {
            return Container(
              child: Stack(
                children: [
                  AudioLiveWidget(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: GiftAnimationView(giftViewModel: giftViewModel,)),
                ],
              ),
            );
          }
        ),
        endDrawer: ForYou(),
      ),
    );
  }
}
