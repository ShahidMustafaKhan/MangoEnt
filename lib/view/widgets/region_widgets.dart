import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mango_ent/view_model/region_controller.dart';

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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                ),
                Text(
                  "More",
                  style: TextStyle(color: Colors.grey, fontSize: 16.sp),
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
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        )
      ],
    );
  }
}

