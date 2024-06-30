import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../utils/theme/colors_constant.dart';
import '../../widgets/custom_buttons.dart';

class SelfBan extends StatefulWidget {
  const SelfBan({Key? key}) : super(key: key);

  @override
  _SelfBanState createState() => _SelfBanState();
}

class _SelfBanState extends State<SelfBan> {
  bool _isChecked = false;

  void _toggleCheck() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
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
                  "Self Ban",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(),
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
                    Text(
                      "LLOUSIE DNLO",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                    Expanded(
                      child: Text(
                        " You're using self-ban service, and you can choose to unban \nyourself later. Before banning, please make sure all the services or \nactivities related to your account have been properly handled.",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _toggleCheck,
                      child: Container(
                        width: 12.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isChecked ? Colors.yellow : Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: _isChecked
                            ? Icon(
                                Icons.check,
                                size: 8.w,
                                color: Colors.black,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "I have read and agree to the above information",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                    width: 343.w,
                    height: 48.h,
                    borderRadius: 35.r,
                    title: "Self Ban",
                    textColor: Color(0xff1E2121),
                    bgColor: AppColors.yellowBtnColor,
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
