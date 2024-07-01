import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../model/trending_card_model.dart';
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
    trendingViewModel.subscribeLiveStreamingModel();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    trendingViewModel.unSubscribeLiveStreamingModel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingViewModel>(
      builder: (controller) {
        List<TrendingModel> modelList=[];
        if(controller.chosenCountry.value.isEmpty)
          modelList = controller.trendingModelList;
        else
          modelList = controller.countryTrendingModelList;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: modelList.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if(modelList.isNotEmpty)
              Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: GridView.count(
                padding: EdgeInsets.only(bottom: 65.h),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
                shrinkWrap: true,
                children: List.generate(modelList.length,
                    (index) {
                    return BuildCard(
                    cFlag: modelList[index].flag,
                    cName: modelList[index].countryCode,
                    imagePath: modelList[index].image,
                    count:
                        modelList[index].achievementCount,
                    name: modelList[index].name,
                    avatar: modelList[index].avatar,
                    liveModel: modelList[index].liveModel
                  );
                }),
              ),
            ),
            if(modelList.isEmpty)
              SizedBox(height: controller.chosenCountry.value.isEmpty ? 62.h : 90.h,),
            if(modelList.isEmpty)
              controller.chosenCountry.value.isEmpty ? NothingIsHere(height: 165, width: 155,) : NothingIsHere()
          ],
        );
      },
    );
  }

}
