import 'dart:async';

import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/view_model/userViewModel.dart';
import '../model/battle_model.dart';
import '../parse/LiveStreamingModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';


class BattleLiveViewModel extends GetxController {

  Status status= Status.Loading;

  late Timer _timer;


  List<BattleLiveModel> battleModelList = [
    // BattleModel(
    //     hostName: 'Jessi🚨🚨🚨🦊🦊',
    //     hostBgImage: Assets.pngLeft,
    //     player2Name: 'Vis1245',
    //     player2BgImage: Assets.pngRight,
    //     team1Score: 50,
    //     team2Score: 50),
    // BattleModel(
    //     hostName: 'Jessi🚨🚨🚨🦊🦊',
    //     hostBgImage: Assets.pngLeft,
    //     player2Name: 'Vis1245',
    //     player2BgImage: Assets.pngRight,
    //     team1Score: 50,
    //     team2Score: 50),
    // BattleModel(
    //     hostName: 'Jessi🚨🚨🚨🦊🦊',
    //     hostBgImage: Assets.pngLeft,
    //     player2Name: 'Vis1245',
    //     player2BgImage: Assets.pngRight,
    //     team1Score: 50,
    //     team2Score: 50),
    // BattleModel(
    //     hostName: 'Jessi🚨🚨🚨🦊🦊',
    //     hostBgImage: Assets.pngLeft,
    //     player2Name: 'Vis1245',
    //     player2BgImage: Assets.pngRight,
    //     team1Score: 50,
    //     team2Score: 50),

  ];



  Future<void> loadLive({battle=false}) async {
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);

    QueryBuilder<BattleModel> queryBuilder = QueryBuilder<BattleModel>(BattleModel());

    queryBuilder.whereEqualTo(BattleModel.keyBattleView, true);
    queryBuilder.whereNotEqualTo(
        BattleModel.keyHostUid, Get.find<UserViewModel>().currentUser.getUid);
    queryBuilder.whereNotContainedIn(
        BattleModel.keyHostUid, Get.find<UserViewModel>().currentUser.getBlockedUsersIds!);
    queryBuilder.whereValueExists(BattleModel.keyHost, true);
    queryBuilder.whereValueExists(BattleModel.keyLiveObject, true);
    queryBuilder.whereDoesNotMatchQuery(
        BattleModel.keyHost, queryUsers);

    queryBuilder.setLimit(25);
    queryBuilder.includeObject([
      BattleModel.keyHost,
      BattleModel.keyPlayerB,
      BattleModel.keyLiveObject,
    ]);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
          _loadApiData(apiResponse.results!).then((value){
            status=Status.Completed;
            update();
          });
        }
      else {
        _loadEmptyApiData();
      }
    } else {
      status=Status.Error;
      update();
    }
  }

  Future<void> _loadApiData(List<dynamic> result) async{
    List<BattleLiveModel> tempModelList = [];

    result.forEach((value) {
      BattleModel battleModel = value as BattleModel;

        if(battleModel.getLiveObject!.getStreaming == true){
          BattleLiveModel battleLiveModel = BattleLiveModel(
            hostName: battleModel.getHost!.getFullName!,
            hostBgImage: battleModel.getHost!.getAvatar!.url!,
            player2Name: battleModel.getPlayerB!.getFullName!,
            player2BgImage: battleModel.getPlayerB!.getAvatar!.url!,
            team1Score:  battleModel.getTeamScoreA ??  0,
            team2Score:  battleModel.getTeamScoreB ??  0,
            liveModel: battleModel.getLiveObject!);

          tempModelList.add(battleLiveModel);
        }

    });
    battleModelList=tempModelList;
  }

  void _loadEmptyApiData(){
       battleModelList=[];
      status=Status.Empty;
      update();
  }


  startTimer() {
    _timer=Timer.periodic(const Duration(seconds: 10), (timer) {
      loadLive();
    });
  }

  cancelTimer() {
    if(_timer.isActive){
      _timer.cancel();
    }
  }

  BattleLiveViewModel();
}
