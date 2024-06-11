import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../widgets/custom_buttons.dart';

class BoostSheet extends StatefulWidget {
  const BoostSheet({Key? key}) : super(key: key);

  @override
  State<BoostSheet> createState() => _BoostSheetState();
}

class _BoostSheetState extends State<BoostSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
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
                    "Boost",
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
            SizedBox(
              height: 50.h,
            ),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                width: 343.w,
                height: 65.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Color(0xff65512E)),
                child: Center(
                  child: Text(
                    "Join my live!",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Positioned(bottom: 20, child: Image.asset(AppImagePath.boost))
            ]),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(
              bgColor: Colors.yellow,
              width: 343.w,
              height: 48.h,
              borderRadius: 50.r,
              title: "Send",
              textColor: Colors.black,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
