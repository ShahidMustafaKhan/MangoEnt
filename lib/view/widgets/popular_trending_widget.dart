import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/trending_controller.dart';

import '../../utils/constants/typography.dart';
import '../../view_model/popular_controller.dart';
import '../../view_model/popular_controller.dart';
import 'build_card.dart';
import 'nothing_widget.dart';

class PopularTrendingWidget extends StatefulWidget {
  const PopularTrendingWidget({Key? key}) : super(key: key);

  @override
  State<PopularTrendingWidget> createState() => _PopularTrendingWidgetState();
}

class _PopularTrendingWidgetState extends State<PopularTrendingWidget> {
  final PopularViewModel popularViewModel = Get.find();

  @override
  void initState() {
    popularViewModel.loadLive();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: popularViewModel.popularAllModelList.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        if(popularViewModel.popularAllModelList.isNotEmpty)
          Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: GridView.count(
            padding: EdgeInsets.only(bottom: 65.h),
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.w,
            shrinkWrap: true,
            children: List.generate(popularViewModel.popularTrendingModelList.length,
                    (index) {
                  return BuildCard(
                    cFlag: popularViewModel.popularTrendingModelList[index].flag,
                    cName: popularViewModel.popularTrendingModelList[index].country,
                    imagePath: popularViewModel.popularTrendingModelList[index].image,
                    liveModel: popularViewModel.popularTrendingModelList[index].liveModel,
                    count:
                    popularViewModel.popularTrendingModelList[index].achievementCount,
                    name: popularViewModel.popularTrendingModelList[index].name,
                    avatar: popularViewModel.popularTrendingModelList[index].avatar
                  );
                }),
          ),
        ),

        if(popularViewModel.popularAllModelList.isEmpty)
          NothingIsHere()
      ],
    );
  }

}
