import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../parse/LiveStreamingModel.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';
import '../../view_model/trending_controller.dart';
import 'build_card.dart';
import 'nothing_widget.dart';

class TrendingWidget extends StatefulWidget {
  TrendingWidget({Key? key}) : super(key: key);

  @override
  State<TrendingWidget> createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  final TrendingViewModel trendingViewModel = Get.find();

  @override
  void initState() {
    trendingViewModel.loadLive();
    // trendingViewModel.startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // trendingViewModel.cancelTimer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingViewModel>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: controller.trendingModelList.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if(controller.trendingModelList.isNotEmpty)
              Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: GridView.count(
                padding: EdgeInsets.only(bottom: 65.h),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
                shrinkWrap: true,
                children: List.generate(controller.trendingModelList.length,
                    (index) {
                  return BuildCard(
                    cFlag: controller.trendingModelList[index].flag,
                    cName: controller.trendingModelList[index].country,
                    imagePath: controller.trendingModelList[index].image,
                    count:
                        controller.trendingModelList[index].achievementCount,
                    name: controller.trendingModelList[index].name,
                    avatar: controller.trendingModelList[index].avatar,
                    liveModel: controller.trendingModelList[index].liveModel
                  );
                }),
              ),
            ),
            if(controller.trendingModelList.isEmpty)
              SizedBox(height: 62.h,),
            if(controller.trendingModelList.isEmpty)
              NothingIsHere(height: 165, width: 155,)
          ],
        );
      },
    );
  }

}
