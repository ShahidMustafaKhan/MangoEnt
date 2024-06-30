import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/parse/SubscriptionModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/dashboard/subscription/subscribers_list.dart';
import 'package:teego/view/screens/live/widgets/subscrption/single_live_subscriber_sheet.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../../view_model/live_controller.dart';
import '../../../../../view_model/subscription_model.dart';
import '../../../dashboard/subscription/subscription_income.dart';

class SubscriberSheet extends StatefulWidget {
  const SubscriberSheet({Key? key}) : super(key: key);

  @override
  State<SubscriberSheet> createState() => _SubscriberSheetState();
}

class _SubscriberSheetState extends State<SubscriberSheet> {
  SubscriptionViewModel subscriptionViewModel = Get.find();
  LiveViewModel liveViewModel = Get.find();
  TextEditingController textEditingController = TextEditingController();

  RxString announcement = ''.obs;

  @override
  void initState() {
    textEditingController.text =  Get.find<UserViewModel>().currentUser.getSubscribeAnnouncement ?? "Exclusive features for subscription, active to join now.";
    announcement.value =  Get.find<UserViewModel>().currentUser.getSubscribeAnnouncement ?? "Exclusive features for subscription, active to join now.";
    subscriptionViewModel.getAllTimeSubscribers();
    super.initState();
  }

  @override
  void dispose() {
    Get.find<UserViewModel>().currentUser.setSubscriptionAnnouncement = textEditingController.text;
    Get.find<UserViewModel>().update();
    textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<SubscriptionViewModel>(
        init: subscriptionViewModel,
        builder: (subscriptionViewModel) {
          return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 543.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Subscriber",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Divider(
                        height: 3.h,
                        color: AppColors.grey300,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        width: 343.w,
                        height: 122.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xff0F0C15),
                            border: Border.all(color: Color(0xffBD8DF4), width: 3)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xffBD8DF4)),
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: Image.network(
                                        liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  ${liveViewModel.liveStreamingModel.getAuthor!.getFullName!}",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      GestureDetector(
                                        onTap: ()=> openBottomSheet(SingleLiveSubscriberSheet(), context),
                                        child: Container(
                                          width: 99.w,
                                          height: 24.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.r),
                                              color: Color(0xff3F3D44)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Subscriber ",
                                                style: TextStyle(
                                                    color: Color(0xffBD8DF4),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xffBD8DF4),
                                                size: 17,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(() {
                                  return Text(
                                    announcement.value.isEmpty
                                        ? "Exclusive features for subscription, active to join now.":
                                    announcement.value,
                                    style: TextStyle(
                                        fontSize: 12.sp, fontWeight: FontWeight.w400),
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                       Column(
                              children: [
                                GestureDetector(
                                  onTap: ()=> Get.to(SubscriptionIncome()),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Estimated revenue:",
                                        style: TextStyle(
                                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '\$${subscriptionViewModel.totalRevenue}',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.yellowBtnColor),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${subscriptionViewModel.today.length}",
                                          style: TextStyle(
                                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 35.h,
                                      width: 1.w,
                                      color: AppColors.yellowBtnColor,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "${subscriptionViewModel.currentSubscribers.length}",
                                          style: TextStyle(
                                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Subscribers",
                                          style: TextStyle(
                                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 35.h,
                                      width: 1.w,
                                      color: AppColors.yellowBtnColor,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "${subscriptionViewModel.expired.length}",
                                          style: TextStyle(
                                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Expired",
                                          style: TextStyle(
                                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),




                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: double.infinity,
                  height: 16.h,
                  color: Color(0xff494848),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Subscriber Announcement",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text("${textEditingController.text.length}/200")
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 100.h,
                        width: 343.w,
                        child: TextField(
                          controller: textEditingController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (value){
                            announcement.value = value;
                          },
                          onSubmitted: (value){
                            if(value.isNotEmpty){
                            Get.find<UserViewModel>().currentUser.setSubscriptionAnnouncement = value;
                            Get.find<UserViewModel>().update();}
                          },
                          decoration: InputDecoration(
                            hintText:
                                "Exclusive features for subscription, active to join now.",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: Color(0xffB9B8BB),
                            contentPadding:
                                EdgeInsets.only(left: 10.h, top: 10.h, bottom: 60),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none, // No border
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.top,
                          minLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
