import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../view_model/zego_controller.dart';



class EmptySeat extends StatelessWidget {
  final int circleNumber;
  EmptySeat(this.circleNumber);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return Column(
      children: [
        Container(
          height: 54.r,
          width: 54.r,
          decoration: BoxDecoration(
            color: Color(0xFF2C2931),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.add, size: 24.sp),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          circleNumber.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
