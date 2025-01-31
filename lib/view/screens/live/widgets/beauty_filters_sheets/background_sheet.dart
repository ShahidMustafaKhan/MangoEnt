import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/permission/choose_photo_permission.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../../utils/constants/app_constants.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    RxInt selectedIndex = 30.obs;


    return GetBuilder<LiveViewModel>(
        init: liveViewModel,
        builder: (liveViewModel) {
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
                itemCount: liveViewModel.stickerPaths.length==2 ? 2 : 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      selectedIndex.value = index;

                      if(index==0){
                        liveViewModel.backgroundImage = null;
                        liveViewModel.liveStreamingModel.setBackgroundImage = null;
                        liveViewModel.liveStreamingModel.save();
                        liveViewModel.update();
                      }
                      else if(index==1)
                        PermissionHandler.checkPermission(false, context, backgroundImage: true).then((value) {
                          liveViewModel.backgroundImage = liveViewModel.liveStreamingModel.getBackgroundImage;
                          liveViewModel.update();
                        });

                      else if(index==2){
                        liveViewModel.backgroundImage = liveViewModel.savedBackgroundImage;
                        liveViewModel.liveStreamingModel.setBackgroundImage = liveViewModel.savedBackgroundImage;
                        liveViewModel.liveStreamingModel.save();
                        liveViewModel.update();

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
                              if(index==0 || index == 1)
                              Center(
                                child: Image.asset(
                                  liveViewModel.stickerPaths[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if(index>=2)
                                Positioned.fill(
                                  child: Center(
                                    child: Image.network(
                                      liveViewModel.stickerPaths[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              if (index >= 2)
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
    );
  }
}
