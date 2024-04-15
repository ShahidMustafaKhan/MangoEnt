import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../view_model/gift_contoller.dart';
import '../../../../../view_model/battle_controller.dart';
import '../../widgets/for_you_widget.dart';
import '../../zegocloud/widgets/zegocloud_preview.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../single_streamer_live/single_live_screen/single_live_streamer_items.dart';


class SingleLiveAudienceScreen extends StatelessWidget {
  SingleLiveAudienceScreen();

  bool hideNav=false;

  @override
  Widget build(BuildContext context) {
    final LiveViewModel liveViewModel = Get.put(LiveViewModel(ZegoLiveRole.audience, Get.arguments));
    final BattleViewModel battleViewModel = Get.put(BattleViewModel());
    final GiftViewModel giftViewModel = Get.put(GiftViewModel());
    if(hideNav==false){
      hideNav=true;
      Future.delayed(Duration(milliseconds: 400), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
      });
    }

    return BaseScaffold(
      safeArea: true,
      body: GetBuilder<GiftViewModel>(init: giftViewModel, builder: (giftViewModel) {
        return Container(
          child: Stack(
            children: [
              if(battleViewModel.isBattleView==false)
                ZegoCloudPreview(role:ZegoLiveRole.audience),
              SingleStreamerLiveItemWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 350.h,
                    width: double.infinity,
                    child: SVGAImage(giftViewModel.animationController!, fit: BoxFit.cover,)),
              ),
            ],
          ),
        );
      }
      ),
      endDrawer: ForYou(),
    );
  }
}
