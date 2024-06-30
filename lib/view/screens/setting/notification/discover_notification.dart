import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_toggle_button.dart';

class DiscoverNotification extends StatefulWidget {
  const DiscoverNotification({Key? key}) : super(key: key);

  @override
  _DiscoverNotificationState createState() => _DiscoverNotificationState();
}

class _DiscoverNotificationState extends State<DiscoverNotification> {
  bool isDiscoverNotification = false;

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
                      "Discover Notification",
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
                      "Inbox Discover notifications",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isDiscoverNotification,
                      onChanged: (value) {
                        setState(() {
                          isDiscoverNotification = value;
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
