import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

class SocialWidget extends StatelessWidget {
  SocialWidget({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Container(
              width: 330.w,
              height: 106.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xff494848),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, top: 10.h),
                    child: Row(
                      children: [
                        Container(
                          height: 42.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: Colors.blue),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Unmissable broadcast \ncome and join us to share the \nfun!...",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        PrimaryButton(
                            width: 74.w,
                            height: 32.h,
                            borderRadius: 30.r,
                            title: "Copy",
                            textColor: AppColors.black,
                            bgColor: AppColors.yellowBtnColor,
                            onTap: () {}),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImagePath.link,
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "https://www.emolm.com/us/m/v/1722492146no-kksiq",
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
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
    );
  }
}
