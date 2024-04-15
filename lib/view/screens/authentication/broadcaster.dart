import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/dashboard_screen.dart';
import 'package:teego/view/widgets/appButton.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view/widgets/broadcasters.dart';

class TrendingBroadcastersScreen extends StatefulWidget {
  const TrendingBroadcastersScreen({Key? key}) : super(key: key);

  @override
  State<TrendingBroadcastersScreen> createState() => _TrendingBroadcastersScreenState();
}

class _TrendingBroadcastersScreenState extends State<TrendingBroadcastersScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 18.h,),
                Row(
                children: [
                  SizedBox(width: 16.5.w),
                  Text(
                    'Trending Broadcasters',
                    style: sfProDisplayMedium.copyWith(fontSize: 16),
                  ),
                  const Expanded(child: SizedBox()),
                  Text('Skip', style: sfProDisplayMedium.copyWith(fontSize: 12)),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.double_arrow,
                    color: AppColors.yellow,
                    size: ScreenUtil().setHeight(15),
                  ),
                  SizedBox(width: 15.5.w),
                ],),
                SizedBox(height: ScreenUtil().setHeight(24)),
                SizedBox(
                  height: ScreenUtil().setHeight(650),
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return BroadCasters(
                        index: index,
                      );
                    },
                  ),
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20), bottom: ScreenUtil().setWidth(20)),
                child: AppButton(
                    context,
                    "Done",
                        () => Get.toNamed(AppRoutes.dashboardScreen),
              ),
            ))
          ],
        ));
  }
}
