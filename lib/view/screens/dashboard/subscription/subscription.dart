import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/subscription_model.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';


class Subscription extends StatefulWidget {
  const Subscription();

  @override
  State<Subscription> createState() => _SubscriptionState();
}

enum TabsEnum {
  subscription,
  expired,
}

class _SubscriptionState extends State<Subscription> {
  TabsEnum selectedTab = TabsEnum.subscription;

  SubscriptionViewModel subscriptionViewModel = Get.find();

  @override
  void initState() {
    subscriptionViewModel.getSubscribee();
    subscriptionViewModel.getExpiredSubscription();
    super.initState();
  }

  @override
  void dispose() {
    subscriptionViewModel.getSubscribee();
    subscriptionViewModel.getExpiredSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    subscriptionViewModel.getSubscribee();
    subscriptionViewModel.getExpiredSubscription();
    return BaseScaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('My Subscription', textAlign: TextAlign.center,
          style: sfProDisplayMedium.copyWith(fontSize: 17.sp),),
      ),
      body: GetBuilder<SubscriptionViewModel>(
          init: subscriptionViewModel,
          builder: (subscriptionViewModel) {
            return ListView(
            children: [
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tab("Subscribing", TabsEnum.subscription),
                    const SizedBox(width: 10),
                    tab("Expired", TabsEnum.expired),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xff494848)),
              SizedBox(height: 24.h),
              if(subscriptionViewModel.subscribeeList.isEmpty && selectedTab == TabsEnum.subscription)
                Container(
                  height: 350.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                      Text("No subscriptions", style: sfProDisplayMedium.copyWith(
                        fontSize: 14.sp,

                      ),),
                    ],
                  ),
                ),
              if(subscriptionViewModel.expiredSubscriptionList.isEmpty && selectedTab == TabsEnum.expired)
                Container(
                  height: 350.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                      Text("No expired subscriptions", style: sfProDisplayMedium.copyWith(
                        fontSize: 14.sp,

                      ),),
                    ],
                  ),
                ),
              if(selectedTab == TabsEnum.subscription)
              ...List.generate(
                subscriptionViewModel.subscribeeList.length,
                (index) {
                  String startDate = "${subscriptionViewModel.subscribeeList[index].createdAt!.year}-${addLeadingZero(subscriptionViewModel.subscribeeList[index].createdAt!.month)}-${addLeadingZero(subscriptionViewModel.subscribeeList[index].createdAt!.day)}";
                  if(subscriptionViewModel.subscribeeList.isNotEmpty)
                  return ListTile(
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(subscriptionViewModel.subscribeeList[index].getSubscribee!.getAvatar!.url!),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Visibility(
                          visible: index == 0,
                          child: const Icon(
                            Icons.brightness_1,
                            size: 12,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      Text(
                        "${subscriptionViewModel.subscribeeList[index].getSubscribee!.getFullName}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if(subscriptionViewModel.subscribeeList[index].getSubscribee!.getHideMyLocation == false)
                      SvgPicture.asset(
                        QuickActions.getCountryFlag(subscriptionViewModel.subscribeeList[index].getSubscribee!),
                        height: 13.w,
                        width: 14.w,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    selectedTab == TabsEnum.subscription
                        ? "Since: $startDate"
                        : "Expired at: 2023-08-07",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      if( subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now())==true){
                        QuickActions.showAlertDialog(context, "Are you sure you want to unsubscribe this user?"
                            , (){
                          Get.back();
                          subscriptionViewModel.subscribeeList[index].setSubscriptionEnd = DateTime.now().subtract(Duration(hours: 1));
                          subscriptionViewModel.subscribeeList[index].save();
                          subscriptionViewModel.update();

                        });
                      }
                    },
                    child: Container(
                      width:  !subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now()) ? 85.w : 64.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now())
                            ?  amberColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now())
                            ?   "UNSUB" : "Unsubscribed",
                        style: TextStyle(
                          color: !subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now()) ? Colors.white70 : Colors.black,
                          fontSize: !subscriptionViewModel.subscribeeList[index].getSubscriptionEnd!.isAfter(DateTime.now()) ? 13.sp : 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                      Text("Nothing is here", style: sfProDisplayMedium.copyWith(
                        fontSize: 14.sp,

                      ),),
                    ],
                  );

                }
              ),
              if(selectedTab == TabsEnum.expired)
                ...List.generate(
                    subscriptionViewModel.expiredSubscriptionList.length,
                        (index) {
                      String endDate = "${subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.year}-${addLeadingZero(subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.month)}-${addLeadingZero(subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.day)}";
                      return ListTile(
                        leading: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(subscriptionViewModel.expiredSubscriptionList[index].getSubscribee!.getAvatar!.url!),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Visibility(
                                visible: index == 0,
                                child: const Icon(
                                  Icons.brightness_1,
                                  size: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Text(
                              "${subscriptionViewModel.expiredSubscriptionList[index].getSubscribee!.getFullName}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              QuickActions.getCountryFlag(subscriptionViewModel.expiredSubscriptionList[index].getSubscribee!),
                              height: 13.w,
                              width: 14.w,
                            ),
                          ],
                        ),
                        subtitle: Text(
                         "Expired at: $endDate",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: (){
                            if( subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now())==true){
                              QuickActions.showAlertDialog(context, "Are you sure you want to subscribe to this user for 450 coins? The subscription will be valid for 7 days."
                                  , (){
                                    Get.back();
                                    if(Get.find<UserViewModel>().checkCoins(450)) {
                                      subscriptionViewModel
                                          .expiredSubscriptionList[index]
                                          .setSubscriptionDate =
                                          DateTime.now();
                                      subscriptionViewModel
                                          .expiredSubscriptionList[index]
                                          .setSubscriptionEnd =
                                          DateTime.now().add(Duration(days: 7));
                                      subscriptionViewModel
                                          .expiredSubscriptionList[index]
                                          .setClaimed = false;
                                      subscriptionViewModel
                                          .expiredSubscriptionList[index]
                                          .save();
                                      subscriptionViewModel.update();
                                      subscriptionViewModel.getSubscribee();
                                    }
                                    else{
                                      QuickHelp.showAppNotificationAdvanced(title: 'Insufficient coins. Please purchase more coins!', context: context);
                                    }

                              });
                            }
                          },
                          child: Container(
                            width: !subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now()) ? 80.w : 64.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now())
                                  ?  amberColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              !subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now()) ? "Subscribed" : "SUB",
                              style: TextStyle(
                                color: !subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now()) ? Colors.white70 : Colors.black,
                                fontSize: !subscriptionViewModel.expiredSubscriptionList[index].getSubscriptionEnd!.isBefore(DateTime.now()) ? 15.sp : 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );}
                ),
            ],
          );
        }
      ),
    );
  }
  String addLeadingZero(int number) {
    // Check if the number is less than 10
    if (number < 10) {
      // If yes, add a leading zero and return as a string
      return '0$number';
    } else {
      // If no, return the number as a string
      return '$number';
    }
  }


  Widget tab(String title, TabsEnum tabEnum) => Expanded(
    child: GestureDetector(
          onTap: () => setState(() {
            selectedTab = tabEnum;
          }),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: tabEnum == selectedTab ? Colors.white : Colors.white70,
                  fontSize: tabEnum == selectedTab ? 20.sp : 14.sp,
                ),
              ),
              Visibility(
                visible: tabEnum == selectedTab,
                child: const Icon(
                  Icons.brightness_1,
                  size: 5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
  );
}
