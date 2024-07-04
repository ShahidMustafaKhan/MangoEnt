import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/typography.dart';
import '../../view_model/region_controller.dart';
import '../../view_model/trending_controller.dart';
import 'more_regions.dart';

class RegionWidget extends StatelessWidget {
  RegionWidget({Key? key}) : super(key: key);

  final RegionViewModel regionViewModel = Get.put(RegionViewModel());
  final TrendingViewModel trendingViewModel = Get.put(TrendingViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionViewModel>(
      builder: (controller) {
        final isLightTheme = Theme.of(context).brightness == Brightness.light;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Countries & Regions",
                    style: sfProDisplayMedium.copyWith(
                        color: isLightTheme ? Colors.black : Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MoreRegionWidget());
                  },
                  child: Text(
                    "More",
                    style: sfProDisplayRegular.copyWith(
                        fontSize: 16.sp,
                        color: isLightTheme ? Colors.black : Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  // color: Colors.white,
                  color: isLightTheme ? Colors.black54 : Colors.grey,

                  size: 17.w,
                )
              ],
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 17.h),
              children:
              List.generate(controller.countryModelList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    trendingViewModel.chosenCountryFlag.value =
                        controller.countryModelList[index].flag;
                    trendingViewModel.chosenCountry.value =
                        controller.countryModelList[index].name;
                    trendingViewModel.updateListForChosenCountry(
                        controller.countryModelList[index].name);
                  },
                  child: buildCountries(
                    cFlag: controller.countryModelList[index].flag,
                    cName: controller.countryModelList[index].name,
                    context: context,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget buildCountries(
      {required String cFlag,
        required String cName,
        required BuildContext context}) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          cFlag,
          height: 32.h,
          width: 44.w,
        ),
        Text(cName,
            style: sfProDisplayRegular.copyWith(
                color: isLightTheme ? Colors.black : Colors.white,
                fontSize: 12.sp))
      ],
    );
  }
}
