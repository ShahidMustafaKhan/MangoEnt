import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_toggle_button.dart';

class BoostNotification extends StatefulWidget {
  const BoostNotification({Key? key}) : super(key: key);

  @override
  _BoostNotificationState createState() => _BoostNotificationState();
}

class _BoostNotificationState extends State<BoostNotification> {
  bool isBoostActive = false;
  bool isFloatingWindow = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    Text(
                      "Boost Notification",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Text(
                      "Inbox Boost notifications",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isBoostActive,
                      onChanged: (value) {
                        setState(() {
                          isBoostActive = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(color: Color(0xff494848)),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      "Boost floating window",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isFloatingWindow,
                      onChanged: (value) {
                        setState(() {
                          isFloatingWindow = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(color: Color(0xff494848)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
