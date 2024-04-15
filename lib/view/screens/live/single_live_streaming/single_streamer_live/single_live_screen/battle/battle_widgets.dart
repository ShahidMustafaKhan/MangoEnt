import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/host_gifters_avatar.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/lose_count.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/mic_icon.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/playerb_gifters_avatar.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/right_result_count.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/win_count.dart';

import '../../../../../../../view_model/battle_controller.dart';
import 'battle_player_tag.dart';
import 'battle_timer_widget.dart';
import 'left_result_count.dart';



class BattleWidgets extends StatelessWidget {
  final BattleViewModel controller;

  BattleWidgets(this.controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlayerTag(battleViewModel: controller,),
        if((controller.rightWinCount==0 && controller.leftWinCount==0 && controller.drawCount==0)==false)
        LeftResultCount(controller),
        if(controller.showClock==true)
        BattleTimer(battleViewModel: controller,),
        if((controller.rightWinCount==0 && controller.leftWinCount==0 && controller.drawCount==0)==false)
        RightResultCount(controller),
        HostGifters(),
        PlayerBGifters(),
        MicIcon()
      ],
    );
  }
}
