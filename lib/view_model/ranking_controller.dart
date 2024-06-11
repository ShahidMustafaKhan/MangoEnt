import 'dart:async';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../parse/RankingModel.dart';
import '../parse/UserModel.dart';

class RankingViewModel extends GetxController {


  List<RankingModel> dailyRanking = [];
  List<RankingModel> weeklyRanking = [];
  List<RankingModel> monthRanking = [];


  Future<void> fetchRanking() async {
    List<RankingModel> tempDailyRanking = [];
    List<RankingModel> tempWeeklyRanking = [];
    List<RankingModel> tempMonthRanking = [];

    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);

    QueryBuilder<RankingModel> queryBuilder = QueryBuilder<
        RankingModel>(RankingModel());

    queryBuilder.whereEqualTo(RankingModel.keyCategory, RankingModel.keyCategoryGifter);

    queryBuilder.orderByDescending(RankingModel.keyCoins);


    queryBuilder.includeObject([
      RankingModel.keySender,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        List<RankingModel> ranking=[] ;

        for (dynamic rank in apiResponse.results!) {
          ranking.add(rank as RankingModel);
        }

        DateTime now = DateTime.now();

        for (RankingModel rank in ranking) {
          DateTime createdDate = rank.createdAt!;  // Assuming keyCreated is a DateTime object

          Duration difference = now.difference(createdDate);

          if (difference.inDays < 1) {
            _addOrUpdateRanking(tempDailyRanking,rank);
            // tempDailyRanking.add(rank);
          }
          if (difference.inDays < 7) {
            _addOrUpdateRanking(tempWeeklyRanking,rank);

            // tempWeeklyRanking.add(rank);
          }
          if (difference.inDays < 30) {
            _addOrUpdateRanking(tempMonthRanking,rank);

            // tempMonthRanking.add(rank);
          }
        }

        // Sort the lists by coins in descending order
        tempDailyRanking.sort((a, b) => b.getCoins!.compareTo(a.getCoins!));
        tempWeeklyRanking.sort((a, b) => b.getCoins!.compareTo(a.getCoins!));
        tempMonthRanking.sort((a, b) => b.getCoins!.compareTo(a.getCoins!));


        dailyRanking=tempDailyRanking;
        weeklyRanking=tempWeeklyRanking;
        monthRanking=tempMonthRanking;
        update();

      }
      else{
        dailyRanking=tempDailyRanking;
        weeklyRanking=tempWeeklyRanking;
        monthRanking=tempMonthRanking;
        update();

      }
    }
  }


  void _addOrUpdateRanking(List<RankingModel> rankingList, RankingModel rank) {
    bool found = false;

    for (RankingModel existingRank in rankingList) {
      if (existingRank.getGifterID == rank.getGifterID) {
        existingRank.setCoins = (existingRank.getCoins! + rank.getCoins!);
        found = true;
        break;
      }
    }

    if (!found) {
      rankingList.add(rank);
    }
  }


  addRecord(int coins){
    RankingModel rankingModel = RankingModel();
    rankingModel.setGifter = Get.find<UserViewModel>().currentUser;
    rankingModel.setGifterID = Get.find<UserViewModel>().currentUser.getUid!;
    rankingModel.setCoins = coins;
    rankingModel.setCategory = RankingModel.keyCategoryGifter;
    rankingModel.save();
  }

  RankingViewModel();

  @override
  void onInit() {
    fetchRanking();
    super.onInit();
  }




}


