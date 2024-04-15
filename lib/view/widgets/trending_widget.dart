import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mango_ent/utils/constants/app_constants.dart';
import 'package:mango_ent/view_model/trending_controller.dart';

class TrendingWidget extends StatelessWidget {
  TrendingWidget({Key? key}) : super(key: key);

  final TrendingViewModel trendingViewModel = Get.put(TrendingViewModel());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingViewModel>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trending",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.w,
                  shrinkWrap: true,
                  children: List.generate(controller.trendingModelList.length, (index) {
                    return buildCard(
                      cFlag: controller.trendingModelList[index].flag,
                      cName: controller.trendingModelList[index].country,
                      imagePath: controller.trendingModelList[index].image,
                      count: controller.trendingModelList[index].achievementCount,
                      name: controller.trendingModelList[index].name,
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCard({
    required String cFlag,
    required String cName,
    required String imagePath,
    required int count,
    required String name,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            margin: EdgeInsets.all(4.w),
            width: 84.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.black, Colors.black.withOpacity(0.4)]),
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(cFlag, height: 15.h, width: 15.w,),
                Text(
                  cName,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.w), bottomRight: Radius.circular(8.w))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19.w), color: Colors.black.withOpacity(0.5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppImagePath.diamond),
                            SizedBox(width: 6.w),
                            FittedBox(
                                child: Text(
                                  count.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                                ))
                          ],
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 2.w, color: CupertinoColors.systemYellow),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
