import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../helpers/quick_actions.dart';
import '../../../../helpers/quick_help.dart';
import '../../../../parse/SubscriptionModel.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../../../../view_model/subscription_model.dart';

class SubscribersList extends StatelessWidget {
  const SubscribersList();

  @override
  Widget build(BuildContext context) {
    SubscriptionViewModel subscriptionViewModel = Get.find();

    return BaseScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Subscribers List', textAlign: TextAlign.center,
        style: sfProDisplayMedium.copyWith(fontSize: 17.sp),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Duration of companionship      ",
                style: TextStyle(
                  color: const Color(0xffBD8DF4),
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            FutureBuilder<List<SubscriptionModel>>(
              future: subscriptionViewModel.getUserSubscribers(Get.find<UserViewModel>().currentUser), // Replace fetchData() with your actual function to fetch data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 300.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator(color: AppColors.yellowColor,)),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.length==0) {
                  return Container(
                    height: 300.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                        Text("No Subscribers", style: sfProDisplayMedium.copyWith(
                          fontSize: 14.sp,

                        ),),
                      ],
                    ),
                  );
                } else {
                  List<SubscriptionModel> modelList  = snapshot.data as List<SubscriptionModel>;
                  return ListView.builder(
                    itemCount:  snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      SubscriptionModel subscription = modelList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 18, left: 15.w, right: 18.w),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage: NetworkImage(subscription.getSubscriber!.getAvatar!.url!),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 1,
                                  child: Container(
                                    width: 10.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(subscription.getSubscriber!.getFullName!),
                                    const SizedBox(width: 16),
                                    if(subscription.getSubscriber!.getHideMyLocation == false)
                                      SvgPicture.asset(
                                      QuickActions.getCountryFlag(subscription.getSubscriber!),
                                      width: 24,
                                      height: 17,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "Since: ${subscription.getSubscriptionDate!.year}-${subscription.getSubscriptionDate!.month}-${subscription.getSubscriptionDate!.day}",
                                      style: sfProDisplayRegular.copyWith(
                                        fontSize: 12,
                                        color: AppColors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(QuickHelp.getTimeAgo(subscription.getSubscriptionDate!)),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
