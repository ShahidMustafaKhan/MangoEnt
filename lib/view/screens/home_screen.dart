import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mango_ent/view/utils/app_constants.dart';
import 'package:mango_ent/view/widgets/app_bar.dart';
import 'package:mango_ent/view/widgets/bottom_nav_shape.dart';
import 'package:mango_ent/view/widgets/region_widgets.dart';
import 'package:mango_ent/view/widgets/trending_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppBarWidget(),
                    SizedBox(height: 10.h,),
                    RegionWidget(),
                    Expanded(child: TrendingWidget()),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                size: Size(double.infinity, 82.h),
                foregroundPainter: RPSCustomPainter(),
              )),
              Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(AppImagePath.homeIcon, height: 24.h, width: 24.w,),
                        SvgPicture.asset(AppImagePath.fireIcon, height: 24.h, width: 24.w,),
                        SizedBox(width: 30.w),
                        SvgPicture.asset(AppImagePath.chatIcon, height: 24.h, width: 24.w,),
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5.w, color: Colors.orange.shade300,),
                            image: const DecorationImage(image: AssetImage(AppImagePath.cardImage2))
                          ),
                        )
                      ],
                    ),
                  ),),
              Positioned(
                bottom: 35.h,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30.w,
                      backgroundColor: Colors.orange.shade300,
                      child: SvgPicture.asset(AppImagePath.cameraIcon, height: 21.w,),),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
