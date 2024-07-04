import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height:
                    trendingViewModel.chosenCountry.value.isEmpty ? 16.h : 20.h,
              ),
              if (trendingViewModel.chosenCountry.value.isEmpty) RegionWidget(),
              GestureDetector(
                onTap: () {
                  trendingViewModel.chosenCountry.value = '';
                  trendingViewModel.chosenCountryFlag.value = '';
                },
                child: Row(
                  children: [
                    Text(
                      trendingViewModel.chosenCountry.value.isEmpty
                          ? "Trending"
                          : trendingViewModel.chosenCountry.value,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    SizedBox(width: 12.w),
                    if (trendingViewModel.chosenCountryFlag.value.isNotEmpty)
                      SvgPicture.asset(
                        trendingViewModel.chosenCountryFlag.value,
                        height: 19.h,
                        width: 26.13.w,
                      ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    trendingViewModel.chosenCountry.value.isNotEmpty ? 20.h : 0,
              ),
              TrendingWidget(),
            ],
          ),
        );
      }),
    );
  }
}
