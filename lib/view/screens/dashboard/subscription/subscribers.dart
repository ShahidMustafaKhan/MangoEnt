import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/dashboard/subscription/subscribers_list.dart';
import 'package:teego/view/screens/dashboard/subscription/subscription_income.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../view_model/live_controller.dart';
import '../../../../view_model/subscription_model.dart';
import '../../../../view_model/userViewModel.dart';
import '../../../widgets/base_scaffold.dart';
import '../bag/add_badge_emoji_sheet.dart';


class Subscribers extends StatefulWidget {
  const Subscribers();

  @override
  State<Subscribers> createState() => _SubscribersState();
}

class _SubscribersState extends State<Subscribers> {
  SubscriptionViewModel subscriptionViewModel = Get.find();
  UserViewModel userViewModel = Get.find();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController expireEditingController = TextEditingController();

  RxString announcement = ''.obs;

  @override
  void initState() {
    textEditingController.text =  Get.find<UserViewModel>().currentUser.getSubscribeAnnouncement ?? "Exclusive features for subscription, active to join now.";
    expireEditingController.text =  "Hi, your subscription is gonna expire soon remember to renew it.";
    announcement.value =  Get.find<UserViewModel>().currentUser.getSubscribeAnnouncement ?? "Exclusive features for subscription, active to join now.";
    subscriptionViewModel.getAllTimeSubscribers();
    super.initState();
  }

  @override
  void dispose() {
    Get.find<UserViewModel>().currentUser.setSubscriptionAnnouncement = textEditingController.text;
    Get.find<UserViewModel>().update();
    textEditingController.dispose();
    expireEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(centerTitle: true, title: Text('My Subscribers',
        style: sfProDisplayMedium.copyWith(fontSize: 16.sp),),
        backgroundColor: Colors.transparent,
     ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Container(
                height: 122.h,
                width: 342.w,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffBD8DF4), width: 2),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffBD8DF4),
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(userViewModel.currentUser.getAvatar!.url!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "🦊 ${userViewModel.currentUser.getFullName!.capitalize} 🦊",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: ()=> Get.to(SubscribersList()),
                              child: Container(
                                height: 24.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xff515151),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Subscriber 2 >",
                                  style: TextStyle(
                                    color: const Color(0xffBD8DF4),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() {
                        return Text(
                          announcement.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              //*

              GestureDetector(
                onTap: ()=> Get.to(SubscriptionIncome()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Estimated Revenue:",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18.sp,
                            color: const Color(0xff515151),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "\$ ${subscriptionViewModel.totalRevenue.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: amberColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: const Color(0xff515151),
                        size: 16.h,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              //* Today / Subscribers / Expired
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleSubtitle("${subscriptionViewModel.today.length}", "Today"),
                  verticalLine,
                  GestureDetector(
                    onTap: () => Get.to(() => const SubscribersList()),
                    child: titleSubtitle("${subscriptionViewModel.currentSubscribers.length}", "Subscribers"),
                  ),
                  verticalLine,
                  titleSubtitle("${subscriptionViewModel.expired.length}", "Expired"),
                ],
              ),

              SizedBox(height: 32.h),

              //*
              titleContainer("Subscriber Announcement", "${textEditingController.text.length}/2000"),
              SizedBox(height: 8.h),

              container("Thanks for subscribing and enjoy yourself here!", textEditingController, false),
              SizedBox(height: 24.h),

              //*
              Text(
                "Gif's and Emojis",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 88.h,
                    width: 88.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: amberColor,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(celebration),
                      ),
                    ),
                  ),
                  grid,
                ],
              ),

              SizedBox(height: 24.h),

              //*
              Text(
                "Badges",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 88.h,
                    width: 88.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: amberColor,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(batch),
                      ),
                    ),
                  ),
                  grid,
                ],
              ),
              SizedBox(height: 24.h),

              //*
              titleContainer("Expiration Reminder", "${expireEditingController.text.length}/2000"),
              SizedBox(height: 8.h),

              container(
                  "Hi, your subscription is gonna expire soon remember to renew it", expireEditingController, true),
              SizedBox(height: 24.h),

              //*
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget container(String text, TextEditingController textEditingController, bool expirationReminder) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: Color(0xffB9B8BB),
        ),
        height: 100.h,
        width: 343.w,
        child: TextField(
          controller: textEditingController,
          expands: true,
          maxLines: null,
          minLines: null,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value){
            if(expirationReminder == false)
            announcement.value = value;
          },
          onSubmitted: (value){
            if(expirationReminder == false){
              if(value.isNotEmpty){
              Get.find<UserViewModel>().currentUser.setSubscriptionAnnouncement = value;
              Get.find<UserViewModel>().update();}}
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
            fillColor: Colors.transparent,
            contentPadding:
            EdgeInsets.only(left: 10.h, top: 5.h, bottom: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none, // No border
            ),
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      );


      // Container(
      //   height: 100.h,
      //   width: 343.w,
      //   decoration: BoxDecoration(
      //     color: const Color(0xffBEBEBF),
      //     borderRadius: BorderRadius.circular(8.r),
      //   ),
      //   padding: const EdgeInsets.all(8),
      //   child: Text(
      //     text,
      //     style: TextStyle(
      //       fontSize: 14.sp,
      //     ),
      //   ),
      // );

  Widget titleContainer(String leadingText, String trailingText) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            trailingText,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      );

  Widget get grid => SizedBox(
        width: 231.w,
        height: 88.h,
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.3,
          ),
          children: List.generate(
            8,
            (index) => GestureDetector(
              onTap: () => Get.bottomSheet(
                const AddBadgeEmojiSheet(),
                backgroundColor: Colors.transparent,
              ),
              child: Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white70),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      );

  Widget get verticalLine => Container(
    width: 2.w,
    height: 35.h,
    color: amberColor,
  );

  Widget titleSubtitle(String title, String subtitle) => Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        subtitle,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      ),
    ],
  );

  Widget tile(String icon, String tile, String title, String subtitle) =>
      Container(
        height: 70.h,
        width: 163.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(tile),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 6.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
            Image.asset(
              icon,
              height: 50.h,
            ),
          ],
        ),
      );

}
