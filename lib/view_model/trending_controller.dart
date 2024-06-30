import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/model/trending_card_model.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../helpers/quick_actions.dart';
import '../parse/LiveStreamingModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';

class TrendingViewModel extends GetxController {

  late Timer _timer;

  List<TrendingModel> trendingModelList = [];

  Status status = Status.Loading;

  String tempImagePath='https://wallpapers.com/images/featured/hd-a5u9zq0a0ymy2dug.jpg';

  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;


  Future<void> loadLive() async {
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);

    QueryBuilder<LiveStreamingModel> queryBuilder = QueryBuilder<LiveStreamingModel>(LiveStreamingModel());

    queryBuilder.whereEqualTo(LiveStreamingModel.keyStreaming, true);
    queryBuilder.whereNotEqualTo(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getUid);
    queryBuilder.whereNotContainedIn(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getBlockedUsersIds!);
    queryBuilder.whereValueExists(LiveStreamingModel.keyAuthor, true);
    queryBuilder.whereDoesNotMatchQuery(
        LiveStreamingModel.keyAuthor, queryUsers);

    queryBuilder.orderByDescending(LiveStreamingModel.keyViewersCountLive);
    queryBuilder.setLimit(10);

    queryBuilder.setLimit(25);
    queryBuilder.includeObject([
      LiveStreamingModel.keyAuthor,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        _loadApiData(apiResponse.results!).then((value){
          status=Status.Completed;
          update();
        });

      } else {
        status=Status.Empty;
        trendingModelList=[];
        update();
      }
    } else {
      status=Status.Error;
      update();
    }
  }

  Future<void> _loadApiData(List<dynamic> result) async {
    List<TrendingModel> tempModelList = [];
    result.forEach((value) {
      LiveStreamingModel liveModel = value as LiveStreamingModel;
      TrendingModel trendingModel = TrendingModel(
          name: liveModel.getAuthor!.getFullName!,
          avatar: liveModel.getAuthor!.getAvatar!.url!,
          flag: QuickActions.getCountryFlag(liveModel.getAuthor!),
          country: '${QuickActions.getCountryCode(liveModel.getAuthor!)} ',
          liveModel: liveModel,
          achievementCount: liveModel.getAuthor!.getCoins ?? 0,
          image: liveModel.getImage!=null ? liveModel.getImage!.url! : tempImagePath);

      tempModelList.add(trendingModel);
    });

    trendingModelList=tempModelList;

  }

  subscribeLiveStreamingModel() async {
    QueryBuilder query =
    QueryBuilder(LiveStreamingModel());

    query.includeObject([
      LiveStreamingModel.keyAuthor,
      LiveStreamingModel.keyBattleModel,
    ]);

    subscription = await liveQuery.client.subscribe(query);

    subscription!.on(LiveQueryEvent.update, (value) async {

      if(kDebugMode){
        print('*** livestreaming UPDATE ***');
        print('*** livestreaming UPDATE ***');
      }

      loadLive();

    });
  }

  unSubscribeLiveStreamingModel() async {
    if (subscription != null) {
      liveQuery.client.unSubscribe(subscription!);
    }
    subscription = null;
  }


  TrendingViewModel();


}


