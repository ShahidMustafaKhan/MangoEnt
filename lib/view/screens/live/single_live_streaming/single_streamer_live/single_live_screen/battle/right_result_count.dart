import 'package:flutter/material.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/lose_count.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/battle/win_count.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'draw_count.dart';



class RightResultCount extends StatelessWidget {
  final BattleViewModel battleViewModel;
  RightResultCount(this.battleViewModel);

  @override
  Widget build(BuildContext context) {
    if(battleViewModel.leftWinCount != 0 && battleViewModel.rightWinCount ==0)
      return LoseCount(false);
    else if (battleViewModel.rightWinCount > 0)
      return WinCount(false, battleViewModel.rightWinCount );
    else if (battleViewModel.leftWinCount==0 && battleViewModel.rightWinCount==0 && battleViewModel.drawCount != 0)
      return DrawCount(false, battleViewModel);
    else
      return SizedBox();
  }
}
