import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../utils/constants/app_constants.dart';

class BackgroundSingleLiveWidget extends StatelessWidget {
  const BackgroundSingleLiveWidget();

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    BattleViewModel battleViewModel = Get.find();
    RxInt selectedIndex = 30.obs;

    final List<String> stickerPaths = [
      AppImagePath.sticker1,
      // AppImagePath.background1,
      AppImagePath.background2,
      AppImagePath.background3,
      AppImagePath.background4,
      AppImagePath.background5,
      AppImagePath.background6,
      AppImagePath.background7,
      AppImagePath.background8,
      AppImagePath.background9,
      AppImagePath.background10,
      AppImagePath.background11,
      AppImagePath.background12,
      AppImagePath.background13,
      AppImagePath.background14,
      AppImagePath.background2,
    ];

    final List<String> stickerPathsPng = [
      "assets/png/background/bg1.png",
      "assets/png/background/bg2.png",
      "assets/png/background/bg3.png",
      "assets/png/background/bg4.png",
      "assets/png/background/bg5.png",
      "assets/png/background/bg6.png",
      "assets/png/background/bg7.png",
      "assets/png/background/bg8.png",
      "assets/png/background/bg9.png",
      "assets/png/background/bg10.png",
      "assets/png/background/bg11.png",
      "assets/png/background/bg3.png",
      "assets/png/background/bg4.png",
      "assets/png/background/bg1.png",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.w,
              childAspectRatio: 1.0,
            ),
            itemCount: stickerPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  selectedIndex.value = index;

                  if(index==0)
                    liveViewModel.backgroundImage.value = '';


                  if(index>0)
                  liveViewModel.backgroundImage.value = stickerPathsPng[index-1];


                  liveViewModel.liveStreamingModel.setBackgroundImage = stickerPathsPng[index-1];
                  liveViewModel.liveStreamingModel.save();
                  if(battleViewModel.isBattleStarted==false){
                    battleViewModel.battleModel.setBackgroundImage = stickerPathsPng[index-1];
                    battleViewModel.battleModel.save();
                  }

                },
                child: Obx(() {
                    return Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xff323232),
                        border: Border.all(
                          width: 2,
                          color: index == selectedIndex.value ? AppColors.yellowColor : Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              stickerPaths[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (index >= 4 && index <= 14)
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                width: 8.77.w,
                                height: 9.5.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.46.r),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppImagePath.arrowDown,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
