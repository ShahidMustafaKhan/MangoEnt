import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../data/configuration/app_configuration.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/theme/colors_constant.dart';
import '../screens/dashboard_screen.dart';


class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool bottomNavigationBar;
  final bool safeArea;
  final Widget? endDrawer;
  const BaseScaffold(
      {Key? key,
      required this.body,
      this.padding = EdgeInsets.zero,
      this.appBar,
      this.bottomNavigationBar = false,
      this.safeArea = false,
      this.endDrawer,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(safeArea==false)
    AppConfigurations.setSystemPreference(isBottomNav: bottomNavigationBar);

    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Get.isDarkMode ? Alignment.bottomLeft : Alignment.bottomCenter,
                end: Get.isDarkMode ? Alignment.topRight : Alignment.topCenter,
                stops: Get.isDarkMode ? const [0.7, 0.9] : null,
                colors: Get.isDarkMode ? AppColors.darkBGGradientColor : AppColors.lightBGGradientColor)),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar,
          body: SafeArea(
            top: safeArea ? false : true,
            bottom: safeArea ? false : false,
            left: safeArea ? false : true,
            right: safeArea ? false : true,
            child: Stack(
              children: [
                Padding(
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: body)
                    ],
                  ),
                ),
                if(bottomNavigationBar)
                ...[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: Size(double.infinity, 82.h),
                      foregroundPainter: BNBCustomPainter(),
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
                  ),),]
              ],
            ),
          ),
          endDrawer: endDrawer,
        ),
      ),
    );
  }
}
