import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/single_live_streamer_items.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../../view_model/gift_contoller.dart';
import '../../../../../../view_model/battle_controller.dart';
import '../../../../../../view_model/live_messages_controller.dart';
import '../../../../../widgets/base_scaffold.dart';
import '../../../widgets/for_you_widget.dart';
import '../../../zegocloud/widgets/zegocloud_preview.dart';
import '../../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../single_audience_live/widgets/gift_animation_view.dart';


class SingleLiveScreen extends StatefulWidget  {
  SingleLiveScreen();

  @override
  State<SingleLiveScreen> createState() => _SingleLiveScreenState();
}

class _SingleLiveScreenState extends State<SingleLiveScreen> with WidgetsBindingObserver {
  final BattleViewModel battleViewModel = Get.put(BattleViewModel());
  final GiftViewModel giftViewModel = Get.put(GiftViewModel());
  final LiveMessagesViewModel liveMessagesViewModel = Get.put(LiveMessagesViewModel(Get.find<LiveViewModel>()));

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.find<LiveViewModel>().closeAlert(context),
      child: BaseScaffold(
        safeArea: true,
        body: GetBuilder<BattleViewModel>(builder: (streamerViewModel)  {
            return GetBuilder<GiftViewModel>(builder: (giftViewModel) {
              return Container(
                  child: Stack(
                    children: [
                      if(streamerViewModel.isBattleView==false)
                        ZegoCloudPreview(role:ZegoLiveRole.host),
                        SingleStreamerLiveItemWidget(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: GiftAnimationView(giftViewModel: giftViewModel,)
                      ),
                    ],
                  ),
                );
              }
            );
          }
        ),
        endDrawer: ForYou(),
      ),
    );
  }
}
