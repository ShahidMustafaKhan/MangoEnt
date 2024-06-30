import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
                    "Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                    "Private Messages Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.privateMessagesNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
                    "Broadcast Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.broadcastNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
                    "Smart Live Notifications",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.smartLiveNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
                    "Boost Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.boostNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
                    "Discover Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.discoverNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
                    "Moment Notification",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.momentNotification);
                      },
                      child: Icon(Icons.arrow_forward_ios))
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
    ));
  }
}
