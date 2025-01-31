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
            itemCount: liveViewModel.stickerPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  // selectedIndex.value = index;
                  //
                  // if(index==0)
                  //   liveViewModel.backgroundImage.value = '';
                  //
                  //
                  // if(index>0)
                  // liveViewModel.backgroundImage.value = stickerPathsPng[index-1];
                  //
                  //
                  // liveViewModel.liveStreamingModel.setBackgroundImage = stickerPathsPng[index-1];
                  // liveViewModel.liveStreamingModel.save();
                  // if(battleViewModel.isBattleStarted==false){
                  //   battleViewModel.battleModel.setBackgroundImage = stickerPathsPng[index-1];
                  //   battleViewModel.battleModel.save();
                  // }

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
                              liveViewModel.stickerPaths[index],
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
