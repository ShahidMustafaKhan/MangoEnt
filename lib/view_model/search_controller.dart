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

class SearchController extends GetxController {


  Status status= Status.Loading;

  List<UserModel> recentPopular = [];
  List<UserModel> searchPopular = [];



  Future<void> getRecentPopularUserModel() async {
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereNotContainedIn(
        UserModel.keyUid, Get.find<UserViewModel>().currentUser.getBlockedUsersIds!);
    queryUsers.whereNotEqualTo(
        UserModel.keyUid, Get.find<UserViewModel>().currentUser.getUid);
    queryUsers.orderByDescending(UserModel.keyFollowers);
    queryUsers.setLimit(6);

    ParseResponse response = await queryUsers.query();
    if(response.success){
      if(response.results!=null)
        _loadApiData(response.results!);
      else
        recentPopular=[];
    }
    else
      recentPopular=[];

  }



  Future<void> _loadApiData(List<dynamic> result) async{
    List<UserModel> tempModelList = [];

    result.forEach((value) {
      UserModel userModel = value as UserModel;
      tempModelList.add(userModel);
    });
      recentPopular=tempModelList;
      status = Status.Completed;
      update();
  }


  Future<void> searchRecentPopularUserModel(String keyWord) async {
    status= Status.Loading;
    update();
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereNotContainedIn(
        UserModel.keyUid, Get.find<UserViewModel>().currentUser.getBlockedUsersIds!);
    queryUsers.whereNotEqualTo(
        UserModel.keyUid, Get.find<UserViewModel>().currentUser.getUid);
    // queryUsers.whereEqualTo(
    //     UserModel.keyUid, int.parse(keyWord));
    queryUsers.whereContains(
        UserModel.keyFirstName, keyWord);

    queryUsers.orderByDescending(UserModel.keyFollowers);
    queryUsers.setLimit(6);

    ParseResponse response = await queryUsers.query();
    if(response.success){
      if(response.results!=null)
        _loadApiData(response.results!);
      else{
        recentPopular=[];
        status = Status.Completed;
        update();
      }
    }
    else{
      recentPopular=[];
      status = Status.Completed;
      update();
    }

  }



  SearchController();

  @override
  void onInit() {
    getRecentPopularUserModel();
    super.onInit();
  }




}


