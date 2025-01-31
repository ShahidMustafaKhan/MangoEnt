
import 'package:country_provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/view_model/ranking_controller.dart';

import '../../../../../model/country_model.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class TrophyTopBar extends StatelessWidget {
  TrophyTopBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    RankingViewModel rankingViewModel = Get.find();
    return Column(
      children: [
        SizedBox(height: 20.h),
        Center(
          child: Container(
            width: 165.w,
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: Get.isDarkMode ? Color(0xff212121): AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                rankingViewModel.timeframeOptions.length,
                (index) => GestureDetector(
                  onTap: () {
                    rankingViewModel.timeframe.value = index;
                    rankingViewModel.setRanking();
                  },
                  child: Obx(() => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          height: 32.h,
                          width: 68.w,
                          decoration: BoxDecoration(
                            color: rankingViewModel.timeframe.value == index
                                ? AppColors.yellowBtnColor
                                : Get.isDarkMode ? Color(0xff212121) : AppColors.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: Get.isDarkMode ? Color(0xff323236) : Colors.transparent),
                          ),
                          child: Center(
                            child: Text(
                              rankingViewModel.timeframeOptions[index],
                              style: TextStyle(
                                color: rankingViewModel.timeframe.value == index
                                    ? Colors.black
                                    : Get.isDarkMode ? Colors.white : AppColors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          width: 132.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: !Get.isDarkMode ? Color(0xffF3F5F7):Color(0xff212121),
            borderRadius: BorderRadius.circular(50.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child:  DropdownButtonHideUnderline(
            child: DropdownButton<CountryModel>(
              value: rankingViewModel.selectedCountry,
              icon: Icon(Icons.keyboard_arrow_down, color: Get.isDarkMode ? Colors.white: AppColors.black,),
              dropdownColor: Get.isDarkMode ? Color(0xff212121): Color(0xffF3F5F7),
              items: rankingViewModel.countries.map((CountryModel country) {
                return DropdownMenuItem<CountryModel>(
                  value: country,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        country.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      if (country == rankingViewModel.countries[0])
                        Image.asset(
                          AppImagePath.trophyGlobalIcon,
                          height: 16.h,
                          width: 22.w,
                        )
                      else
                        SvgPicture.asset(
                          country.flag,
                          height: 16.h,
                          width: 22.w,
                        ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (CountryModel? newCountry) {
                rankingViewModel.selectedCountry = newCountry!;
                rankingViewModel.setRanking();
                rankingViewModel.update();
              },
            ),
          ),

        ),

      ],
    );
  }
}
