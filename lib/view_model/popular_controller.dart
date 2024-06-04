import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../helpers/quick_help.dart';
import '../model/popular_card_model.dart';
import '../parse/LiveStreamingModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';

class PopularViewModel extends GetxController {

  late Timer _timer;

  String tempImagePath='https://wallpapers.com/images/featured/hd-a5u9zq0a0ymy2dug.jpg';

  RxBool isAllTapSelected = true.obs;

  Status status= Status.Loading;

  List<PopularModel> popularTrendingModelList = [];

  List<PopularModel> popularAllModelList = [];

  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;



  switchToggle(
  {
    required String toggle
  })
  {
    if(toggle=='All'){
      isAllTapSelected.value=true;
      update();
    }
    else{
      isAllTapSelected.value=false;
      update();
    }
  }

  Future<void> loadLive({battle=false}) async {
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

    if(isAllTapSelected.value==true){
      queryBuilder.orderByDescending(LiveStreamingModel.keyStreamerFollowers);
      queryBuilder.setLimit(10);
    }
    else {
      queryBuilder.orderByDescending(LiveStreamingModel.keyViewersCountLive);
      queryBuilder.setLimit(10);
    }

    queryBuilder.setLimit(25);
    queryBuilder.includeObject([
      LiveStreamingModel.keyAuthor,
      LiveStreamingModel.keyAuthorInvited,
      LiveStreamingModel.keyPrivateLiveGift,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
          if(battle==false){
            _loadApiData(apiResponse.results!).then((value){
              status=Status.Completed;
              update();
            });
          }
          else{
            _loadBattleData(apiResponse.results!).then((value){
              status=Status.Completed;
              update();
            });
          }


      } else {
        _loadEmptyApiData();
      }
    } else {
      status=Status.Error;
      update();
    }
  }

  Future<void> _loadApiData(List<dynamic> result) async{
    List<PopularModel> tempModelList = [];

    result.forEach((value) {
      LiveStreamingModel liveModel = value as LiveStreamingModel;
      PopularModel popularModel = PopularModel(
                  name: liveModel.getAuthor!.getFullName!,
                  avatar: liveModel.getAuthor!.getAvatar!.url!,
                  flag: QuickActions.getCountryFlag(liveModel.getAuthor!),
                  country: '${QuickActions.getCountryCode(liveModel.getAuthor!)} No.2',
                  liveModel: liveModel,
                  achievementCount: liveModel.getAuthor!.getDiamondsTotal ?? 0,
                  image: liveModel.getImage!=null ? liveModel.getImage!.url! : tempImagePath);

      tempModelList.add(popularModel);
    });
    if(isAllTapSelected.value){
      popularAllModelList=tempModelList;
    }
    else{
      popularTrendingModelList=tempModelList;
    }

  }

  Future<void> _loadBattleData(List<dynamic> result) async{
    List<PopularModel> tempModelList = [];

    result.forEach((value) {
      LiveStreamingModel liveModel = value as LiveStreamingModel;
      PopularModel popularModel = PopularModel(
          name: liveModel.getAuthor!.getFullName!,
          avatar: liveModel.getAuthor!.getAvatar!.url!,
          flag: AppImagePath.pakistanFlag,
          country: 'PK No.2',
          liveModel: liveModel,
          achievementCount: liveModel.getAuthor!.getDiamondsTotal ?? 0,
          image: liveModel.getImage!=null ? liveModel.getImage!.url! : tempImagePath);

      tempModelList.add(popularModel);
    });
      popularAllModelList=tempModelList;


  }

  void _loadEmptyApiData(){
    if(isAllTapSelected.value){
      popularAllModelList=[];
      status=Status.Completed;
      update();
    }
    else{
      popularTrendingModelList=[];
      status=Status.Completed;
      update();
    }
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



  PopularViewModel();




}


