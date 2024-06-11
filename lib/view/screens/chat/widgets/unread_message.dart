import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../widgets/custom_buttons.dart';

class UnreadMessageWidget extends StatefulWidget {
  const UnreadMessageWidget({Key? key}) : super(key: key);

  @override
  State<UnreadMessageWidget> createState() => _UnreadMessageWidgetState();
}

class _UnreadMessageWidgetState extends State<UnreadMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: ()=> Get.back(),
              child: Container(
                width: 343.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Color(0xff363339),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ignore unread",
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            PrimaryButton(
              bgColor: Colors.yellow,
              width: 342.w,
              height: 48.h,
              borderRadius: 12.r,
              title: "Cancel",
              textColor: Colors.white,
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
