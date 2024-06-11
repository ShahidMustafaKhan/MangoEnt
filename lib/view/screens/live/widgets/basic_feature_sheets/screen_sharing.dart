import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class ScreenSharingWidget extends StatefulWidget {
  const ScreenSharingWidget();

  @override
  _ScreenSharingWidgetState createState() => _ScreenSharingWidgetState();
}

class _ScreenSharingWidgetState extends State<ScreenSharingWidget> {
  final List<Map<String, String>> items = [
    {"image": AppImagePath.whatsApp, "label": "WhatsApp"},
    {"image": AppImagePath.Facebook, "label": "Facebook"},
    {"image": AppImagePath.twitter, "label": "Twitter"},
    {"image": AppImagePath.messenger, "label": "Messenger"},
    {"image": AppImagePath.Instagram, "label": "Instagram"},
    {"image": AppImagePath.telegram, "label": "Telegram"},
    {"image": AppImagePath.contacts, "label": "Contacts"},
    {"image": AppImagePath.others, "label": "Others"},
    {"image": AppImagePath.download, "label": "Download"},
    {"image": AppImagePath.dislike, "label": "Dislike"},
    {"image": AppImagePath.report, "label": "Report"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Share",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: 5.w,
                      height: 5.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              color: AppColors.grey300,
              height: 3,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                width: 330.w,
                height: 263.4.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0xff494848),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      width: 150.w,
                      height: 120.h,
                      child: Image.asset(
                        AppImagePath.multiGuestImage,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 55.h,
                      width: 274.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.r),
                        color: Color(0xff7E6C42),
                      ),
                      child: Center(
                        child: Text(
                          "Write description",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      height: 32.h,
                      width: 92.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.yellowBtnColor,
                      ),
                      child: Center(
                        child: Text(
                          "Post a reel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 1.h,
                childAspectRatio: 1,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          items[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      items[index]['label']!,
                      style: TextStyle(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
