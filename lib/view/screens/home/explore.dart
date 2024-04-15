import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/widgets/region_widgets.dart';
import 'package:teego/view/widgets/trending_widget.dart';

import '../../../parse/UserModel.dart';
import '../../../view_model/trending_controller.dart';

class Explore extends StatelessWidget {
  final UserModel? currentUser;

  Explore({Key? key, this.currentUser}) : super(key: key);

  final TrendingViewModel trendingViewModel = Get.put(TrendingViewModel());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.h,
            ),
            RegionWidget(),

            Text(
              "Trending",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),

            TrendingWidget(),
          ],
        ),
      ),
    );
  }
}
