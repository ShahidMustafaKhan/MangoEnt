import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/utils/constants/typography.dart';

import '../../utils/constants/app_constants.dart';
import '../../view_model/popular_controller.dart';
import 'build_card.dart';
import 'nothing_widget.dart';

class PopularAllWidget extends StatefulWidget {
  const PopularAllWidget({Key? key}) : super(key: key);

  @override
  State<PopularAllWidget> createState() => _PopularAllWidgetState();
}

class _PopularAllWidgetState extends State<PopularAllWidget> {
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
      mainAxisAlignment: popularViewModel.popularAllModelList.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (popularViewModel.popularAllModelList.isNotEmpty)
          Image.asset(
            AppImagePath.popularBadge,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
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
            children: List.generate(popularViewModel.popularAllModelList.length,
                    (index) {
                  return BuildCard(
                    cFlag: popularViewModel.popularAllModelList[index].flag,
                    cName: popularViewModel.popularAllModelList[index].country,
                    imagePath: popularViewModel.popularAllModelList[index].image,
                    liveModel: popularViewModel.popularAllModelList[index].liveModel,
                    count:
                    popularViewModel.popularAllModelList[index].achievementCount,
                    name: popularViewModel.popularAllModelList[index].name,
                    avatar: popularViewModel.popularAllModelList[index].avatar
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
