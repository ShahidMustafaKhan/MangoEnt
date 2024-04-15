import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/constants/typography.dart';


class NothingIsHere extends StatelessWidget {
  double height;
  double width;

  NothingIsHere({Key? key, this.height=220 , this.width=210}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width.w,
          height: height.h,
          child: Image.asset(
            AppImagePath.nothingIsHere,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
            Text("Nothing is here", style: sfProDisplayMedium.copyWith(
              fontSize: 14.sp,

            ),),
          ],
        ),
        SizedBox(height: 150.h,)
      ],
    );
  }
}
