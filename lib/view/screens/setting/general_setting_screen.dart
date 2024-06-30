import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../widgets/custom_toggle_button.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({Key? key}) : super(key: key);

  @override
  _GeneralSettingState createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool isSwipeBetweenBroadcast = false;
  bool isNewFans = false;
  bool isAllowFriendsInvutation = false;
  bool isAllowRecommendation = false;
  bool isFloatingWindow = false;
  bool IsMobileDesktop = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
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
                      "General",
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
                          "Language you prefer",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Receive target live recommendations or audience",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.languageScreen);
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Swipe between broadcasts",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Once disabled, you won't be able to switch\nbetween different broadcast by swipe up/\ndown",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isSwipeBetweenBroadcast,
                      onChanged: (value) {
                        setState(() {
                          isSwipeBetweenBroadcast = value;
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
                          "New Fans",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Get notified when peopple follow",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isNewFans,
                      onChanged: (value) {
                        setState(() {
                          isNewFans = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 16.h,
            color: Color(0xff494848),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Allow friend's invitation",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Get notified when people follow you",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isAllowFriendsInvutation,
                      onChanged: (value) {
                        setState(() {
                          isAllowFriendsInvutation = value;
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
                          "Allow recommendation",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "You'll will show in others users Battles\nrecommendation",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isAllowRecommendation,
                      onChanged: (value) {
                        setState(() {
                          isAllowRecommendation = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Container(
            height: 16.h,
            width: double.infinity,
            color: Color(0xff494848),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Floating window",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "The floating window will be automatically\nactivated when switching from MangoEnt to\nphone screen",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
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
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile desktop floating window",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "The floating window will be automatically\nactivated when switching from MangoEnt to\nphone screen",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: IsMobileDesktop,
                      onChanged: (value) {
                        setState(() {
                          IsMobileDesktop = value;
                        });
                      },
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Divider(color: Color(0xff494848)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
