import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/parse/SubscriptionModel.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../view_model/live_controller.dart';
import '../../../../../view_model/subscription_model.dart';

class SingleLiveSubscriberSheet extends StatefulWidget {
  const SingleLiveSubscriberSheet({Key? key}) : super(key: key);

  @override
  State<SingleLiveSubscriberSheet> createState() =>
      _SingleLiveSubscriberSheetState();
}

class _SingleLiveSubscriberSheetState extends State<SingleLiveSubscriberSheet> {
  SubscriptionViewModel subscriptionViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Subscriber",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffBD8DF4)),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              height: 3.h,
              color: AppColors.grey300,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Duration of companionship",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffBD8DF4)),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            FutureBuilder<List<SubscriptionModel>>(
              future: subscriptionViewModel.getUserSubscribers(Get.find<LiveViewModel>().liveStreamingModel.getAuthor!), // Replace fetchData() with your actual function to fetch data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 130.h,
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
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                        Text("Nothing is here", style: sfProDisplayMedium.copyWith(
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
                        padding: const EdgeInsets.only(bottom: 18),
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
