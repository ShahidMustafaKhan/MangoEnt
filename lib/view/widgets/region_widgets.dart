import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/typography.dart';
import '../../view_model/region_controller.dart';
import 'more_regions.dart';


class RegionWidget extends StatelessWidget {
  RegionWidget({Key? key}) : super(key: key);

  final RegionViewModel regionViewModel = Get.put(RegionViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionViewModel>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Countries & Regions",
                    style: sfProDisplayMedium.copyWith(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MoreRegionWidget());
                  },
                  child: Text(
                    "More",
                    style: sfProDisplayRegular.copyWith(color: Colors.grey, fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 17.w
                  ,
                )
              ],
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 17.h),
              children: List.generate(controller.countryModelList.length, (index) {
                return buildCountries(
                  cFlag: controller.countryModelList[index].flag,
                  cName: controller.countryModelList[index].name,
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget buildCountries({required String cFlag, required String cName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(cFlag, height: 32.h, width: 44.w,),
        Text(
          cName,
          style: sfProDisplayRegular.copyWith(color: Colors.white, fontSize: 12.sp)
        )
      ],
    );
  }
}

