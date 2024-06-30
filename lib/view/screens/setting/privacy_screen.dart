import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import '../../widgets/custom_toggle_button.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({Key? key}) : super(key: key);

  @override
  _PrivacySettingScreenState createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  bool isShowLastActive = false;
  bool isShowOnline = false;
  bool isForbidRecording = false;
  bool isReceiveMessages = false;

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
                      "Privacy",
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
                          "Show last active time",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "After turning on, others Will see your last \nactive time",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isShowLastActive,
                      onChanged: (value) {
                        setState(() {
                          isShowLastActive = value;
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
                          "Show online status",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "After turning on, your friends will see your \nonline status",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isShowOnline,
                      onChanged: (value) {
                        setState(() {
                          isShowOnline = value;
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
                          "Forbid recording in live",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Enable this to forbid video recording and\nscreenshots of your streaming",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isForbidRecording,
                      onChanged: (value) {
                        setState(() {
                          isForbidRecording = value;
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
                      "Receive messages from users you\nhaven't followed",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    ToggleButton(
                      isActive: isReceiveMessages,
                      onChanged: (value) {
                        setState(() {
                          isReceiveMessages = value;
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
