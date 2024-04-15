import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/theme/colors_constant.dart';

class SocialButton extends StatelessWidget {
  final String path;
  final Function() onTap;
  const SocialButton({
    Key? key,
    required this.path,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 50.h,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(color: AppColors.yellow, width: 2.5),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: SvgPicture.asset(path,height: 25,
                width: 25,)),
        ),
      ),
    );
  }
}