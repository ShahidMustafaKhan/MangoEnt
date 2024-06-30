import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teego/view_model/userViewModel.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  bool isLocationOn = false;
  bool isBirthdayDisabled = false;

  UserViewModel userViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserViewModel>(
        init: userViewModel,
        builder: (userViewModel) {
          return SizedBox(
          height: 200.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Profile Settings",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                _buildSettingRow(
                  "Hide my location",
                  userViewModel.currentUser.getHideMyLocation!,
                  (value) => userViewModel.hideMyLocation(value)),

                SizedBox(height: 30.h),
                _buildSettingRow(
                  "Hide my birthday",
                    userViewModel.currentUser.getHideMyBirthday!,
                    (value) => userViewModel.hideMyBirthday(value)),

              ],
            ),
          ),
        );
      }
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
          color: isActive ? Colors.yellow : Colors.grey,
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
