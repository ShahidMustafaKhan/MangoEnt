import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        width: 51.w,
        height: 31.h,
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
                  shape: BoxShape.circle,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
