import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/home/popular.dart';


import '../../../../parse/UserModel.dart';
import '../../../../view_model/ranking_controller.dart';
import '../../../../view_model/tab_bar_controller.dart';

import '../../../widgets/toggle_button_list.dart';
import '../../../widgets/trophy_toggle_button_list.dart';
import '../../ranking/trophy/coins.dart';

import '../battle.dart';
import '../explore.dart';
import '../game/game.dart';


class HomeView extends StatelessWidget {
  final TabBarViewModel tabBarViewModel = Get.put(TabBarViewModel());
  final RankingViewModel rankingViewModel =
  Get.find();

  final UserModel? currentUser;

  HomeView({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (rankingViewModel.showTrophyScreen.value == true) {
              return SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TrophyToggleButtonList(
                  selected: rankingViewModel.selectedId.value,
                  callback: (index) {
                    rankingViewModel.selectedId.value = index;
                    rankingViewModel.setRanking();
                  },
                  categories: rankingViewModel.categories,
                ),
              );
            } else {
              return SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ToggleButtonList(
                  selected: tabBarViewModel.selectedId.value,
                  callback: (index) {
                    tabBarViewModel.selectedId.value = index;
                    rankingViewModel.showTrophyScreen.value = false;
                  },
                  categories: tabBarViewModel.categories,
                ),
              );
            }
          }),
          Expanded(
            child: Obx(() {
                  if (rankingViewModel.showTrophyScreen.value) {
                    return GlobalRanking();
                  }
                  else {
                    switch (tabBarViewModel.selectedId.value) {
                      case 0:
                        return Popular(currentUser: currentUser);
                      case 1:
                        return const Game();
                      case 2:
                        return Explore(currentUser: currentUser);
                      case 3:
                        return Battle();
                      default:
                        return Popular(currentUser: currentUser);
                    }
                  }
            }),
          ),
        ],
      ),
    );
  }
}
