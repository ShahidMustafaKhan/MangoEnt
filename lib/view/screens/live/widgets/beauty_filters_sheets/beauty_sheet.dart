import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class BeautyWidget extends StatelessWidget {
  const BeautyWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImagePath.buffering),
                            SizedBox(width: 5.w),
                            CustomSlider(),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Buffering",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          children: [
                            Image.asset(AppImagePath.eyes),
                            SizedBox(width: 5.w),
                            CustomSlider(),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Eyes",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImagePath.touchup),
                            SizedBox(width: 5.w),
                            CustomSlider(),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Touch up",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          children: [
                            Image.asset(AppImagePath.facey),
                            SizedBox(width: 5.w),
                            CustomSlider(),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Facey",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 117.w,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 1.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.h),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 15.h),
              thumbColor: AppColors.yellowBtnColor,
              activeTrackColor: Color(0xffF2F2F2),
              inactiveTrackColor: Color(0xff494848),
            ),
            child: Slider(
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
