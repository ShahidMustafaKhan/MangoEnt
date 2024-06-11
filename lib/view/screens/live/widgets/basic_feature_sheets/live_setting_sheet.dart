import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';

import '../../../../../view_model/live_controller.dart';

class LiveSettingSheet extends StatefulWidget {
  const LiveSettingSheet({Key? key}) : super(key: key);

  @override
  State<LiveSettingSheet> createState() => _LiveSettingSheetState();
}

class _LiveSettingSheetState extends State<LiveSettingSheet> {
  bool isGiftAnimationOn = false;
  bool isRecordDisabled = false;
  bool isScreenshotDisabled = false;

  LiveViewModel liveViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: liveViewModel.role == ZegoLiveRole.host ? 300.h : 150.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Live Settings",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 3.h,
              color: AppColors.grey300,
            ),
            SizedBox(height: 30.h),
            _buildSettingRow(
              "Gift animation",
              isGiftAnimationOn,
              (value) => setState(() => isGiftAnimationOn = value),
            ),
            SizedBox(height: 30.h),
            if(liveViewModel.role == ZegoLiveRole.host)
            _buildSettingRow(
              "Disable Record",
              isRecordDisabled,
              (value) => setState(() => isRecordDisabled = value),
            ),
            if(liveViewModel.role == ZegoLiveRole.host)
              SizedBox(height: 30.h),
            if(liveViewModel.role == ZegoLiveRole.host)
              _buildSettingRow(
              "Disable Screenshot",
              isScreenshotDisabled,
              (value) => setState(() => isScreenshotDisabled = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(
      String text, bool isActive, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        ToggleButton(isActive: isActive, onChanged: onChanged),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ToggleButton({
    Key? key,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: Container(
        width: 60.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: isActive ? Color(0xffF9C034) : Colors.grey,
        ),
        child: Stack(
          children: [
            Align(
              alignment:
                  isActive ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 28.w,
                height: 28.h,
                margin: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffFFFFFF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
