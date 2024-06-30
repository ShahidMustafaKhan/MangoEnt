import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/trending/trending_toggle_button_list.dart';
import 'package:teego/view/screens/trending/widgets/following.dart';
import 'package:teego/view/screens/trending/widgets/for_you.dart';
import 'package:teego/view/screens/trending/widgets/post.dart';
import '../../../parse/UserModel.dart';
import '../../../view_model/trending_tab_bar_controller.dart';

class TrendingView extends StatelessWidget {
  final TrendingTabBarViewModel trendingTabBarViewModel =
      Get.put(TrendingTabBarViewModel());
  final UserModel? currentUser;

  TrendingView({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              if (trendingTabBarViewModel.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                switch (trendingTabBarViewModel.selectedId.value) {
                  case 0:
                    return PostView();
                  case 1:
                    return FollowingView();
                  case 2:
                    return ForYouView();

                  default:
                    return PostView();
                }
              }
            }),
          ),
          Column(
            children: [
              Obx(() {
                return SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TrendingToggleButtonList(
                    selected: trendingTabBarViewModel.selectedId.value,
                    callback: (index) {
                      trendingTabBarViewModel.selectedId.value = index;
                    },
                    categories: trendingTabBarViewModel.categories,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
