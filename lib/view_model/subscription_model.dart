import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../parse/SubscriptionModel.dart';
import '../parse/UserModel.dart';

class SubscriptionViewModel extends GetxController {


  List<SubscriptionModel> subscribeeList = [];
  List<SubscriptionModel> expiredSubscriptionList = [];
  List<SubscriptionModel> subscribersList = [];

  List<SubscriptionModel> today = [];
  List<SubscriptionModel> currentSubscribers = [];
  List<SubscriptionModel> expired = [];
  double totalRevenue=0;


  subscribe(UserModel subscribee, int coins, String period, BuildContext context) async {
    if(Get.find<UserViewModel>().coins >= coins) {
      List<SubscriptionModel> temp = [];
      SubscriptionModel subscriptionModel= SubscriptionModel();;
      expiredSubscriptionList.forEach((element) {
        if(element.getSubscribee!.getUid! == subscribee.getUid!){
           subscriptionModel = element;
        }
      });
      subscriptionModel.setSubscriber = Get
          .find<UserViewModel>()
          .currentUser;
      subscriptionModel.setSubscriberId = Get
          .find<UserViewModel>()
          .currentUser
          .getUid!;
      subscriptionModel.setSubscribee = subscribee;
      subscriptionModel.setSubscribeeId = subscribee.getUid!;
      subscriptionModel.setSubscriptionDate = DateTime.now();
      subscriptionModel.setSubscriptionEnd = getFutureDate(period);
      subscriptionModel.setCoins = coins;
      subscriptionModel.setClaimed = false;
      ParseResponse response = await subscriptionModel.save();
      if (response.success) {
        if (response.results != null) {
          List result = response.results!;
          result.forEach((item) {
            SubscriptionModel subscriptionModel = item as SubscriptionModel;
            temp.add(subscriptionModel);
          });
          subscribeeList = temp;
          update();
          Get.find<UserViewModel>().deductBalance(coins);
          Get.find<LiveViewModel>().subscriberCount();
        }
      }
    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: 'Insufficient Balance!', context: context);
    }

  }


  bool isStreamerSubscribed(UserModel mUser) {
    for (var item in subscribeeList) {
      if (item.getSubscribee!.getUid! == mUser.getUid!) {
        return true;
      }
    }
    return false;
  }


  getSubscribee() async {
    List<SubscriptionModel> temp = [];

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscriberId, Get.find<UserViewModel>().currentUser.getUid!);
    query.whereGreaterThanOrEqualsTo(SubscriptionModel.keyEnd, DateTime.now());
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          temp.add(subscriptionModel);
        });
        subscribeeList=temp;
        update();

      }
      else{
        subscribeeList=[];
        update();
      }
    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: 'Failed to subscribe', context: Get.context!);
    }

  }

  getExpiredSubscription() async {
    List<SubscriptionModel> temp = [];
    Set<int> uniqueUids = {};

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscriberId, Get.find<UserViewModel>().currentUser.getUid!);
    query.whereLessThan(SubscriptionModel.keyEnd, DateTime.now());
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          int uid = subscriptionModel.getSubscribee!.getUid!;
          if (!uniqueUids.contains(uid)) {
            // Add the UID to the set
            uniqueUids.add(uid);
            // Add the subscription model to the temporary list
            temp.add(subscriptionModel);
          }
        });
        expiredSubscriptionList=temp;
        update();

      }
      else{
        expiredSubscriptionList=[];
        update();
      }
    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: 'Failed to subscribe', context: Get.context!);
    }

  }


  claimSubscriptionAmount(List<SubscriptionModel> result){
    result.forEach((item){
      SubscriptionModel subscriptionModel = item;
      if(subscriptionModel.getClaimed == false){
        Get.find<UserViewModel>().addBalance(subscriptionModel.getCoins!);
        subscriptionModel.setClaimed =true;
        subscriptionModel.save();
      }
    });
  }

  getMySubscriber() async {
    List<SubscriptionModel> temp = [];

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscribeeId, Get.find<UserViewModel>().currentUser.getUid!);
    query.whereGreaterThanOrEqualsTo(SubscriptionModel.keyEnd, DateTime.now());
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          temp.add(subscriptionModel);
        });
        subscribersList=temp;
        update();
        claimSubscriptionAmount(subscribeeList);
      }
      else
        subscribersList=[];
         update();
    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: 'Failed to subscribe', context: Get.context!);
    }

  }



  getAllTimeSubscribers() async {
    List<SubscriptionModel> temp = [];

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscribeeId, Get.find<UserViewModel>().currentUser.getUid!);
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          temp.add(subscriptionModel);
        });
        categoriesSubscribers(temp);
        calculateRevenue(temp);
      }
      else{

      }
    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: 'Failed to subscribe', context: Get.context!);
    }

  }

  void categoriesSubscribers(List<SubscriptionModel> subscriberList) {
    DateTime now = DateTime.now();
    List<SubscriptionModel> tempToday = [];
    List<SubscriptionModel> tempCurrentSubscribers = [];
    List<SubscriptionModel> tempExpired = [];

    // Iterate through the subscriberList
    subscriberList.forEach((item) {
      if (item.getSubscriptionEnd!.isBefore(now)) {
        tempExpired.add(item);
      } else {
        tempCurrentSubscribers.add(item);
        if (item.getSubscriptionDate!.difference(now).inHours <= 24) {
          tempToday.add(item);
        }
      }
    });

    today = tempToday;
    currentSubscribers = tempCurrentSubscribers;
    expired = tempExpired;
    update();

  }



  Future<List<SubscriptionModel>> getUserSubscribers(UserModel user) async {
    List<SubscriptionModel> temp = [];

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscribeeId, user.getUid!);
    query.whereGreaterThanOrEqualsTo(SubscriptionModel.keyEnd, DateTime.now());
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          temp.add(subscriptionModel);
        });
        return temp;
      }
      else
        return [];
    }
    else{
      return [];
    }
  }

  Future<List<SubscriptionModel>> getUserAllTimeSubscribers(UserModel user) async {
    List<SubscriptionModel> temp = [];

    QueryBuilder<SubscriptionModel> query =
    QueryBuilder<SubscriptionModel>(SubscriptionModel());

    query.whereEqualTo(SubscriptionModel.keySubscribeeId, user.getUid!);
    query.includeObject([
      SubscriptionModel.keySubscribee,
      SubscriptionModel.keySubscriber,
      SubscriptionModel.keyStart,
      SubscriptionModel.keyEnd,
    ]);

    ParseResponse response = await query.query();

    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        List result = response.results! ;
        result.forEach((item){
          SubscriptionModel subscriptionModel = item as SubscriptionModel;
          temp.add(subscriptionModel);
        });
        return temp;
      }
      else
        return [];
    }
    else{
      return [];
    }

  }


  void calculateRevenue(List<SubscriptionModel> subscriberList) {
    int coins=0;

    // Iterate through the subscriberList
    subscriberList.forEach((item) {
     coins = coins + item.getCoins!;
    });

    totalRevenue= coins * Get.find<UserViewModel>().singleCoinPrice;
  }

  List<SubscriptionModel> todaySubscribers(List<SubscriptionModel> subscriberList) {
    DateTime now = DateTime.now();
    List<SubscriptionModel> tempToday = [];

    // Iterate through the subscriberList
    subscriberList.forEach((item) {
      if (!item.getSubscriptionEnd!.isBefore(now) &&
          item.getSubscriptionDate!.difference(now).inHours <= 24) {
        tempToday.add(item);
      }
    });

    return tempToday;
  }

  List<SubscriptionModel> expiredSubscription(List<SubscriptionModel> subscriberList) {
    DateTime now = DateTime.now();
    List<SubscriptionModel> tempExpired = [];

    // Iterate through the subscriberList
    subscriberList.forEach((item) {
      if (item.getSubscriptionEnd!.isBefore(now)) {
        tempExpired.add(item);
      }
    });

    return tempExpired;
  }

  List<SubscriptionModel> currentSubscribersCount(List<SubscriptionModel> subscriberList) {
    DateTime now = DateTime.now();
    List<SubscriptionModel> tempCurrentSubscribers = [];

    // Iterate through the subscriberList
    subscriberList.forEach((item) {
      if (!item.getSubscriptionEnd!.isBefore(now)) {
        tempCurrentSubscribers.add(item);
      }
    });

    return tempCurrentSubscribers;
  }




  DateTime getFutureDate(String period) {
    DateTime now = DateTime.now();

    if (period == 'week') {
      return now.add(Duration(days: 7));
    } else if (period == 'month') {
      return DateTime(now.year, now.month + 1, now.day);
    } else {
      throw ArgumentError('Invalid period. Use "week" or "month".');
    }
  }

  SubscriptionViewModel();


  @override
  void onInit() {
    getSubscribee();
    getMySubscriber();
    getExpiredSubscription();
    getAllTimeSubscribers();
    super.onInit();
  }
}
