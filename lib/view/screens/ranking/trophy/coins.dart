import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/bottombar_widget.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/main_coins_view.dart';
import 'package:teego/view/screens/ranking/trophy/widgets/topbar_widget.dart';

import '../../../../parse/RankingModel.dart';
import '../../../../view_model/ranking_controller.dart';

class GlobalRanking extends StatelessWidget {
  const GlobalRanking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RankingViewModel rankingViewModel = Get.find();
    rankingViewModel.fetchGlobalRanking();
    return GetBuilder<RankingViewModel>(
        init: rankingViewModel,
        builder: (rankingViewModel) {
          return Column(
          children: [
            TrophyTopBar(),
              SizedBox(
              height: rankingViewModel.ranking.isNotEmpty ? 150.h : 75.h,
            ),
            MainCoinsView(),
            SizedBox(
              height: 30.h,
            ),
            if(rankingViewModel.ranking.isNotEmpty)
            Divider(color: Get.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3), height: 4),
            SizedBox(
              height: 20.h,
            ),
            TrophyBottomBar(),
          ],
        );
      }
    );
  }
}
