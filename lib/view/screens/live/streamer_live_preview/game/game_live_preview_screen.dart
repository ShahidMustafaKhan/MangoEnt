import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/streamer_live_preview/game/widgets/game_view_bottom_card.dart';
import 'package:teego/view/screens/live/streamer_live_preview/game/widgets/game_view_category.dart';
import 'package:teego/view/screens/live/streamer_live_preview/game/widgets/game_view_screen_display.dart';
import 'package:teego/view/screens/live/streamer_live_preview/game/widgets/game_view_top_bar.dart';
import '../../../../../view_model/live_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../widgets/live_bottom_card.dart';

class GameLivePreviewScreen extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {

    LiveViewModel liveViewModel =
        Get.put(LiveViewModel(ZegoLiveRole.host, null));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const SizedBox(height: 45),
          GameViewTopBar(index: selectedIndex),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GameViewCategory(),
          ),
          const SizedBox(height: 96),
          GameViewScreenDisplay(index: selectedIndex),
          Spacer(),
          LiveBottomCard(liveViewModel),
          const SizedBox(height: 16),
        ],
      ),
    );


  }
}
