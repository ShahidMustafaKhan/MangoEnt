import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../../widgets/custom_toggle_button.dart';

class SmartLiveNotification extends StatefulWidget {
  const SmartLiveNotification({Key? key}) : super(key: key);

  @override
  _SmartLiveNotificationState createState() => _SmartLiveNotificationState();
}

class _SmartLiveNotificationState extends State<SmartLiveNotification> {
  bool isNonFriendsLive = false;
  bool isOnlyFriendsLive = false;

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
                      "Smart Live Notification",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Non-friends' live",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Receive notifications of live from non-friends",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isNonFriendsLive,
                      onChanged: (value) {
                        setState(() {
                          isNonFriendsLive = value;
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Only friends I like",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Only the live of friends I'm recently interested in",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isOnlyFriendsLive,
                      onChanged: (value) {
                        setState(() {
                          isOnlyFriendsLive = value;
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
