import 'dart:async';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../model/country_model.dart';
import '../parse/RankingModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/app_constants.dart';

class RankingViewModel extends GetxController {


  List<RankingModel> ranking = [];

  List<RankingModel> dailyTopFansRanking = [];
  List<RankingModel> weeklyTopFansRanking = [];
  List<RankingModel> monthTopFansRanking = [];

  List<RankingModel> weeklyCoinsRanking = [];
  List<RankingModel> monthCoinsRanking = [];

  List<RankingModel> weeklyGifterRanking = [];
  List<RankingModel> monthGifterRanking = [];

  List<RankingModel> weeklyRechargerRanking = [];
  List<RankingModel> monthRechargerRanking = [];

  List<RankingModel> weeklyLevelRanking = [];
  List<RankingModel> monthLevelRanking = [];



  List<String> categories = [
    "Coins",
    "Gifter",
    "Recharger",
    "Level",
  ];

  RxInt selectedId = 1.obs;
  RxBool isLoading = false.obs;
  RxBool showTrophyScreen = false.obs;

  final RxInt timeframe = 0.obs;
  final RxList<String> timeframeOptions  = <String>["Weekly", "Monthly"].obs;

  setRanking(){
    if(selectedId.value == 0){ //coins
      if(timeframe.value == 0)
        rankingBasedOnGeography(weeklyCoinsRanking);
      else
        rankingBasedOnGeography(monthCoinsRanking);
    }
    else if(selectedId.value == 1){ // gifter
      if(timeframe.value == 0)
        rankingBasedOnGeography(weeklyGifterRanking);
      else
        rankingBasedOnGeography(monthGifterRanking);
    }
    else if(selectedId.value == 2){ // recharger
      if(timeframe.value == 0)
        rankingBasedOnGeography(weeklyRechargerRanking);
      else
        rankingBasedOnGeography(monthRechargerRanking);
    }
    else{ //level
      if(timeframe.value == 0)
        rankingBasedOnGeography(weeklyLevelRanking);
      else
        rankingBasedOnGeography(monthLevelRanking);
    }
  }

  void rankingBasedOnGeography(List<RankingModel> rankingModelList){
    if (selectedCountry.name == countries[0].name) {
      ranking = rankingModelList;
      update();
    } else {
      iterateList(rankingModelList);
    }
  }

  void iterateList(List<RankingModel> rankingModelList){
    ranking = [];
    for (var rankingModel in rankingModelList) {
      if (rankingModel.getGifter!.getCountry! == selectedCountry.name) {
        ranking.add(rankingModel);
      }
    }
    update();
  }


  List<CountryModel> countries = [
    CountryModel(name: "Global", flag: AppImagePath.trophyGlobalIcon),
    CountryModel(name: "Pakistan", flag: AppImagePath.pakistanFlag),
    CountryModel(name: "USA", flag: AppImagePath.americanFlag),
    CountryModel(name: "Canada", flag: AppImagePath.canadaFlag),
    CountryModel(name: "France", flag: AppImagePath.franceFlag),
    CountryModel(name: "Ukraine", flag: AppImagePath.ukraineFlag),
  ];

  late CountryModel selectedCountry;


  Future<void> fetchTopFansRanking() async {
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


        dailyTopFansRanking=tempDailyRanking;
        weeklyLevelRanking=tempWeeklyRanking;
        monthLevelRanking=tempMonthRanking;
        update();

      }
      else{
        dailyTopFansRanking=tempDailyRanking;
        weeklyLevelRanking=tempWeeklyRanking;
        monthLevelRanking=tempMonthRanking;
        update();

      }
    }
  }

  Future<void> fetchGlobalCoinsRanking() async {
    List<RankingModel> tempWeeklyCoinsRanking = [];
    List<RankingModel> tempMonthCoinsRanking = [];


    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);


    DateTime now = DateTime.now();

    // Query for all rankings
    QueryBuilder<RankingModel> queryBuilder = QueryBuilder<
        RankingModel>(RankingModel());

    queryBuilder.orderByDescending(RankingModel.keyCoins);
    queryBuilder.whereEqualTo(RankingModel.keyCategory, RankingModel.keyCategoryCoins);


    queryBuilder.includeObject([
      RankingModel.keySender,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.success) {
        List<RankingModel> rankings = apiResponse.results?.cast<
            RankingModel>() ?? [];

        for (RankingModel rank in rankings) {
          DateTime createdDate = rank.createdAt!;

          // Calculate days difference
          Duration difference = now.difference(createdDate);

          // Determine category and timeframe
          if (difference.inDays < 7) {
              _addOrUpdateRanking(tempWeeklyCoinsRanking, rank);
          }

          if (difference.inDays < 30) {
              _addOrUpdateRanking(tempMonthCoinsRanking, rank);
          }
        }

        // Sort each list by coins in descending order
        tempWeeklyCoinsRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));
        tempMonthCoinsRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));


        weeklyCoinsRanking = tempWeeklyCoinsRanking;
        monthCoinsRanking = tempMonthCoinsRanking;

        update();
        setRanking();
      } else {
        // Handle error or empty response if needed
      }
    }
  }


  Future<void> fetchGlobalGifterRanking() async {

    List<RankingModel> tempWeeklyGifterRanking = [];
    List<RankingModel> tempMonthGifterRanking = [];


    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);


    DateTime now = DateTime.now();

    // Query for all rankings
    QueryBuilder<RankingModel> queryBuilder = QueryBuilder<
        RankingModel>(RankingModel());

    queryBuilder.orderByDescending(RankingModel.keyCoins);
    queryBuilder.whereEqualTo(RankingModel.keyCategory, RankingModel.keyCategoryGifter);


    queryBuilder.includeObject([
      RankingModel.keySender,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.success) {
        List<RankingModel> rankings = apiResponse.results?.cast<
            RankingModel>() ?? [];

        for (RankingModel rank in rankings) {
          DateTime createdDate = rank.createdAt!;

          // Calculate days difference
          Duration difference = now.difference(createdDate);

          // Determine category and timeframe
          if (difference.inDays < 7) {
              _addOrUpdateRanking(tempWeeklyGifterRanking, rank);
          }

          if (difference.inDays < 30) {
              _addOrUpdateRanking(tempMonthGifterRanking, rank);
          }
        }

        // Sort each list by coins in descending order

        tempWeeklyGifterRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));
        tempMonthGifterRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));


        // Assign to the respective variables and update

        weeklyGifterRanking = tempWeeklyGifterRanking;
        monthGifterRanking = tempMonthGifterRanking;

        update();
      } else {
        // Handle error or empty response if needed
      }
    }
  }

  Future<void> fetchGlobalLevelRanking() async {

    List<RankingModel> tempWeeklyLevelRanking = [];
    List<RankingModel> tempMonthLevelRanking = [];


    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);


    DateTime now = DateTime.now();

    // Query for all rankings
    QueryBuilder<RankingModel> queryBuilder = QueryBuilder<
        RankingModel>(RankingModel());

    queryBuilder.orderByDescending(RankingModel.keyCoins);
    queryBuilder.whereEqualTo(RankingModel.keyCategory, RankingModel.keyCategoryLevel);


    queryBuilder.includeObject([
      RankingModel.keySender,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.success) {
        List<RankingModel> rankings = apiResponse.results?.cast<
            RankingModel>() ?? [];

        for (RankingModel rank in rankings) {
          DateTime createdDate = rank.createdAt!;

          // Calculate days difference
          Duration difference = now.difference(createdDate);

          // Determine category and timeframe
          if (difference.inDays < 7) {
              _addOrUpdateRanking(tempWeeklyLevelRanking, rank);
          }

          if (difference.inDays < 30) {
              _addOrUpdateRanking(tempMonthLevelRanking, rank);
          }
        }

        // Sort each list by coins in descending order

        tempWeeklyLevelRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));
        tempMonthLevelRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));


        // Assign to the respective variables and update

        weeklyLevelRanking = tempWeeklyLevelRanking;
        monthLevelRanking = tempMonthLevelRanking;

        update();
      } else {
        // Handle error or empty response if needed
      }
    }
  }

  Future<void> fetchGlobalRechargerRanking() async {

    List<RankingModel> tempWeeklyRechargerRanking = [];
    List<RankingModel> tempMonthRechargerRanking = [];


    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);


    DateTime now = DateTime.now();

    // Query for all rankings
    QueryBuilder<RankingModel> queryBuilder = QueryBuilder<
        RankingModel>(RankingModel());

    queryBuilder.orderByDescending(RankingModel.keyCoins);
    queryBuilder.whereEqualTo(RankingModel.keyCategory, RankingModel.keyCategoryRecharger);


    queryBuilder.includeObject([
      RankingModel.keySender,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.success) {
        List<RankingModel> rankings = apiResponse.results?.cast<
            RankingModel>() ?? [];

        for (RankingModel rank in rankings) {
          DateTime createdDate = rank.createdAt!;

          // Calculate days difference
          Duration difference = now.difference(createdDate);

          // Determine category and timeframe
          if (difference.inDays < 7) {
              _addOrUpdateRanking(tempWeeklyRechargerRanking, rank);
          }

          if (difference.inDays < 30) {
              _addOrUpdateRanking(tempMonthRechargerRanking, rank);
          }
        }

        // Sort each list by coins in descending order

        tempWeeklyRechargerRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));
        tempMonthRechargerRanking.sort((a, b) =>
            b.getCoins!.compareTo(a.getCoins!));


        // Assign to the respective variables and update

        weeklyRechargerRanking = tempWeeklyRechargerRanking;
        monthRechargerRanking = tempMonthRechargerRanking;

        update();
      } else {
        // Handle error or empty response if needed
      }
    }
  }


  Future<void> fetchGlobalRanking() async{
    fetchGlobalCoinsRanking();
    fetchGlobalGifterRanking();
    fetchGlobalLevelRanking();
    fetchGlobalRechargerRanking();
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


  addRecord(int coins, String category){
    RankingModel rankingModel = RankingModel();
    rankingModel.setGifter = Get.find<UserViewModel>().currentUser;
    rankingModel.setGifterID = Get.find<UserViewModel>().currentUser.getUid!;
    rankingModel.setCoins = coins;
    rankingModel.setCategory = RankingModel.keyCategoryGifter;
    rankingModel.save();
  }

  addRechargeRecord(int recharge){
    RankingModel rankingModel = RankingModel();
    rankingModel.setGifter = Get.find<UserViewModel>().currentUser;
    rankingModel.setGifterID = Get.find<UserViewModel>().currentUser.getUid!;
    rankingModel.setCoins = recharge;
    rankingModel.setCategory = RankingModel.keyCategoryRecharger;
    rankingModel.save();
  }

  addLevelRecord(int xp){
    RankingModel rankingModel = RankingModel();
    rankingModel.setGifter = Get.find<UserViewModel>().currentUser;
    rankingModel.setGifterID = Get.find<UserViewModel>().currentUser.getUid!;
    rankingModel.setCoins = xp;
    rankingModel.setCategory = RankingModel.keyCategoryLevel;
    rankingModel.save();
  }

  addCoinsRecord(int coins){
    RankingModel rankingModel = RankingModel();
    rankingModel.setGifter = Get.find<UserViewModel>().currentUser;
    rankingModel.setGifterID = Get.find<UserViewModel>().currentUser.getUid!;
    rankingModel.setCoins = coins;
    rankingModel.setCategory = RankingModel.keyCategoryCoins;
    rankingModel.save();
  }


  RankingViewModel();

  @override
  void onInit() {
    fetchTopFansRanking();
    fetchGlobalRanking().then((value) => setRanking());
    selectedCountry = countries[0];
    super.onInit();
  }




}


