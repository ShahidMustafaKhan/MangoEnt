import 'dart:async';

import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/model/trending_card_model.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../parse/LiveStreamingModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';

class TrendingViewModel extends GetxController {

  late Timer _timer;

  List<TrendingModel> trendingModelList = [];

  Status status = Status.Loading;

  String tempImagePath='https://wallpapers.com/images/featured/hd-a5u9zq0a0ymy2dug.jpg';




  Future<void> loadLive() async {
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);

    QueryBuilder<LiveStreamingModel> queryBuilder = QueryBuilder<LiveStreamingModel>(LiveStreamingModel());

    queryBuilder.whereEqualTo(LiveStreamingModel.keyStreaming, true);
    queryBuilder.whereNotEqualTo(
        LiveStreamingModel.keyAuthorUid, Get.find<UserViewModel>().currentUser.getUid);
    queryBuilder.whereNotContainedIn(
        LiveStreamingModel.keyAuthor, Get.find<UserViewModel>().currentUser.getBlockedUsers!);
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
          flag: AppImagePath.pakistanFlag,
          country: 'PK No.2',
          liveModel: liveModel,
          achievementCount: liveModel.getAuthor!.getDiamondsTotal ?? 0,
          image: liveModel.getImage!=null ? liveModel.getImage!.url! : tempImagePath);

      tempModelList.add(trendingModel);
    });

    trendingModelList=tempModelList;

  }

  startTimer() {
    _timer=Timer.periodic(const Duration(seconds: 10), (timer) {
      print("timer : 10");
      loadLive();
    });
  }

  cancelTimer() {
    if(_timer.isActive){
      _timer.cancel();
    }
  }


  TrendingViewModel();


}


