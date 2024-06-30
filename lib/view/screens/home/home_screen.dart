import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/home/popular.dart';

import '../../../parse/UserModel.dart';
import '../../../view_model/tab_bar_controller.dart';
import '../../widgets/toggle_button_list.dart';
import 'battle.dart';
import 'explore.dart';
import 'game.dart';


class HomeView extends StatelessWidget {
  final TabBarViewModel tabBarViewModel = Get.put(TabBarViewModel());
  final UserModel? currentUser;

  HomeView({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ToggleButtonList(
              selected: tabBarViewModel.selectedId.value ,
              callback: (index) {
                tabBarViewModel.selectedId.value = index;
              },
              categories: tabBarViewModel.categories,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (tabBarViewModel.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (tabBarViewModel.selectedId.value == 0) {
                  return Popular(currentUser: currentUser,);
                } else if (tabBarViewModel.selectedId.value == 1) {
                  return const Game();
                } else if (tabBarViewModel.selectedId.value == 2) {
                  return Explore(currentUser: currentUser,);
                } else if (tabBarViewModel.selectedId.value == 3) {
                  return Battle();
                } else {
                  return Popular(currentUser: currentUser,);
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
