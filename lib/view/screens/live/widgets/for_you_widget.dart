import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view_model/live_messages_controller.dart';
import 'package:teego/view_model/popular_controller.dart';

import '../../../../parse/LiveStreamingModel.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/routes/app_routes.dart';
import '../../../../view_model/live_controller.dart';


class ForYou extends StatelessWidget {
  ForYou();

  @override
  Widget build(BuildContext context) {
    PopularViewModel popularViewModel = Get.find();
    RxBool isEmpty = false.obs;
    isEmpty.value = checkStreamingTypeMismatch(popularViewModel);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Drawer(
          width: 170,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 135,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.orangeContainer,
                        AppColors.progressLinearOrangeColor1,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('For You', style: sfProDisplayBold.copyWith(fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(AppImagePath.lightningIcon, width: 36, height: 36),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                  ...List.generate(
                  popularViewModel.popularAllModelList.length,
                      (index) {
                    if(popularViewModel.popularAllModelList[index].liveModel.getStreamingType == Get.find<LiveViewModel>().liveStreamingModel.getStreamingType)
                          return GestureDetector(
                        onTap: (){
                          Get.back();
                          Get.find<LiveViewModel>().unSubscribeLiveStreamingModel();
                          Get.find<LiveMessagesViewModel>().unSubscribeLiveMessageModels();
                          if(Get.find<LiveViewModel>().role==ZegoLiveRole.host)
                            Get.find<LiveViewModel>().endLiveStreamingAndJoinOtherSession(context, popularViewModel.popularAllModelList[index].liveModel);
                          else
                          Get.find<LiveViewModel>().joinOtherStreamerLiveSession(popularViewModel.popularAllModelList[index].liveModel);
                        },
                        child: Container(
                          height: 125,
                          width: 125,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            image:  DecorationImage(
                              image: NetworkImage(popularViewModel.popularAllModelList[index].image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: AppColors.black.withOpacity(0.4),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        '${popularViewModel.popularAllModelList[index].name.split(' ')[0]}',
                                        style: sfProDisplaySemiBold.copyWith(fontSize: 12),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImagePath.fireIcon,
                                            width: 10,
                                            height: 10,
                                            color: AppColors.white.withOpacity(0.7),
                                          ),
                                          Text(
                                            '${popularViewModel.popularAllModelList[index].liveModel.getViewersId!.length ?? 0}',
                                            style: sfProDisplayRegular.copyWith(
                                              fontSize: 10,
                                              color: AppColors.white.withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    return SizedBox();
                  }
                ),
                if(popularViewModel.popularAllModelList.isEmpty || isEmpty.value)
                Column(
                  children: [
                    SizedBox(height: 250.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                        Text("Nothing is here", style: sfProDisplayMedium.copyWith(
                          fontSize: 14.sp,
                        ),),
                      ],
                    ),
                  ],
                ),
               

              ],
            ),
          ),
        ),

        Positioned(
          top: 0,
          bottom: 0,
          left: -18,
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
            },
            child: const CircleAvatar(
              radius: 15,
              child: Icon(Icons.close, size: 18),
            ),
          ),
        ),
      ],
    );
  }
  bool checkStreamingTypeMismatch(PopularViewModel popularViewModel) {
    int counter = 0;
    int listLength = popularViewModel.popularAllModelList.length;

    for (int i = 0; i < listLength; i++) {
      if (popularViewModel.popularAllModelList[i].liveModel.getStreamingType != Get.find<LiveViewModel>().liveStreamingModel.getStreamingType) {
        counter++;
      }
    }

    return counter == listLength;
  }
}
