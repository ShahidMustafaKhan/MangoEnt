import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';

class UserViewModel extends GetxController {


  UserModel currentUser;



  Future<void> updateUserDetails(String name, String gender, String country, String birthDate, BuildContext context) async {
    QuickHelp.showLoadingDialog(context);

    String fullName = name;
    String firstName = "";
    String lastName = "";

    if (fullName.contains(" ")) {
      int firstSpace = fullName.indexOf(" ");
      firstName = fullName.substring(0, firstSpace);
      lastName = fullName.substring(firstSpace).trim();
    } else {
      firstName = fullName;
    }


    currentUser.setFullName = fullName;
    currentUser.setFirstName = firstName;
    currentUser.setLastName = lastName;
    currentUser.setGender = gender;
    currentUser.setCountry = country;

    currentUser.setBirthday =
        QuickHelp.getDate(birthDate);


    ParseResponse userResult = await currentUser.save();

    if (userResult.success) {
      QuickHelp.hideLoadingDialog(context,
          result: userResult.results!.first as UserModel);

      QuickHelp.hideLoadingDialog(context,
          result: userResult.results!.first as UserModel);

      currentUser = userResult.results!.first as UserModel;

      // _getUser();
    } else if (userResult.error!.code == 100) {
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(
          context: context, title: "error".tr(), message: "not_connected".tr());
    } else {
      QuickHelp.hideLoadingDialog(context);
      // QuickHelp.showAppNotificationAdvanced(
      //     context: context,
      //     title: "error".tr(),
      //     message: "try_again_later".tr());
    }
  }

  Future<void> getFollowers() async {
    List<String> temp=[];
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());

    ParseResponse response = await queryUsers.query();
    if(response.success){
      if(response.results!=null)
        response.results!.forEach((value) {
          UserModel userModel = value as UserModel;
          if(userModel.getFollowing!=null && userModel.getFollowing!.contains(currentUser.objectId.toString()))
          temp.add(userModel.objectId!);
        });
      currentUser.resetFollowers=temp;
      currentUser.save();
      update();
    }
  }


  Future<List> getFollowersUserModel() async {
    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereContainedIn(UserModel.keyObjectId, currentUser.getFollowers ?? []);

    ParseResponse response = await queryUsers.query();
    if(response.success){
      if(response.results!=null)
        return response.results!;
      else
        return [];
    }
    else
      return [];
  }


   followOrUnFollow(String objectId) async {
    if(currentUser.getFollowing!.contains(objectId)){
      currentUser.removeFollowing= objectId;
      ParseResponse response = await currentUser.save();
      if(response.success){
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
    else{
      currentUser.setFollowing = objectId;
      ParseResponse response = await currentUser.save();
      if(response.success){
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
  }

  bool followingUser(UserModel user){
    if(currentUser.getFollowing!.contains(user.objectId)){
      return true;
    }
    else{
      currentUser.setFollowing = user.objectId!;
      return false;
    }
  }





  updateViewModel(){
    update();
  }



  UserViewModel(this.currentUser);

  @override
  void onInit() {
    currentUser = this.currentUser;
    super.onInit();
  }


}


