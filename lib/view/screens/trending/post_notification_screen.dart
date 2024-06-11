import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

class PostNotificationScreen extends StatefulWidget {
  const PostNotificationScreen({Key? key}) : super(key: key);
  @override
  State<PostNotificationScreen> createState() => _PostNotificationScreenState();
}

class _PostNotificationScreenState extends State<PostNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new)),
              SizedBox(
                width: 120.w,
              ),
              Text(
                "Notification",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                String notificationText;
                Widget trailingWidget;

                switch (index) {
                  case 0:
                    notificationText = "Liked your post.";
                    trailingWidget = Container(
                      width: 52.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.asset(
                          AppImagePath.multiGuestImage,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                    break;
                  case 1:
                    notificationText = "Started following you";
                    trailingWidget = Container(
                      width: 52.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    );
                    break;
                  case 2:
                    notificationText = "Posted a moment";
                    trailingWidget = Container(
                      width: 52.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Image.asset(
                        AppImagePath.multiGuestImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                    break;
                  case 3:
                    notificationText = "Commented on your post: good luck";
                    trailingWidget = Container(
                      width: 52.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Image.asset(
                        AppImagePath.multiGuestImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                    break;
                  default:
                    notificationText = "";
                    trailingWidget = SizedBox.shrink();
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: Container(
                    width: 375,
                    height: 84,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColors.grey300))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppImagePath.profilePic,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stephan Louis",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              Row(
                                children: [
                                  Text(
                                    notificationText,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "10:04 AM",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          trailingWidget,
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    ));
  }
}
