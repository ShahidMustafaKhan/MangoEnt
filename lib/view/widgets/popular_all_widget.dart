import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/utils/constants/typography.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/routes/app_routes.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: popularViewModel.popularAllModelList.isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (popularViewModel.popularAllModelList.isNotEmpty)
            GestureDetector(
              onTap: ()=> Get.toNamed(AppRoutes.store),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  AppImagePath.popularBadge,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if(popularViewModel.popularAllModelList.isEmpty)
            Container(
              height: 676.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NothingIsHere(),
                ],
              ),
            ),
          if(popularViewModel.popularAllModelList.isNotEmpty)
          Container(
            height: 570.h,
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 55.h, left: 17 , right: 17),
              child: GridView.count(
                padding: EdgeInsets.only(bottom: 65.h),
                physics: const NeverScrollableScrollPhysics(),
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
          ),

        ],
      ),
    );
  }

}
