import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Center(
      child: Container(
          height: 300.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // boxShadow: [
            //   BoxShadow(
            //     color: AppColors.bgShadeColor.withOpacity(0.09),
            //     spreadRadius: 7,
            //     blurRadius: 10,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: SvgPicture.asset(AppImagePath.splashIcon)),
    ));
  }
}
