import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


import '../helpers/quick_actions.dart';
import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';

class UserViewModel extends GetxController {


  UserModel currentUser;
  double singleCoinPrice = 0.0106;


 int get level{
    return currentUser.getLevel ?? 1;
  }

  int get xp{
    return currentUser.getXp ?? 0;
  }

  double get xpFactor{
   return (1/5000)*xp;
  }

  double get myBalance{
    return (currentUser.getCoins * singleCoinPrice) * 0.5;
  }

  int get coins{
    return currentUser.getCoins;
  }

  bool checkCoins(int coins){
        return currentUser
        .getCoins >=
        coins;
  }


  updateUserModel() async {
   ParseResponse response = await currentUser.save();
   if(response.success){
     if(response.results!=null){
       currentUser = response.results!.first as UserModel;
       update();
     }
   }
  }

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
      return false;
    }
  }




  getDeviceName(BuildContext context) async {
    currentUser.setDevice = await QuickActions.getDeviceName(context);
    ParseResponse response = await currentUser.save();
    if(response.success){
      if(response.results!=null && response.results!.isNotEmpty){
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
  }

  bool isUserInBlockList(UserModel userModel){
    if(currentUser.getBlockedUsersIds!.contains(userModel.getUid!))
      return true;
    else
      return false;
  }

  addOrRemoveFromBlockList(UserModel mUser, BuildContext context){
    if(isUserInBlockList(mUser))
      QuickActions.showAlertDialog(context, 'Are you sure you want to add user to block list?', (){
       currentUser.setBlockedUserIds= mUser.getUid!;
        currentUser.save().then((value){
         currentUser.update();
          Get.back();
          Get.back();
          QuickHelp.showAppNotificationAdvanced(title: 'User Added to Block List!', context: context, isError: false);
        });
      });
    else{
      QuickActions.showAlertDialog(context, 'Are you sure you want to remove user from block list?', (){
        currentUser.removeBlockedUserIds= mUser.getUid!;
        currentUser.save().then((value){
          currentUser.update();
          Get.back();
          Get.back();
          QuickHelp.showAppNotification(title: 'User removed from Block List!', context: context, isError: false);
        });
      });
    }
  }


  addToBlockList(int mUid) async {
        currentUser.setBlockedUserIds= mUid;
        ParseResponse response = await currentUser.save();
        if(response.success){
          if(response.results!=null){
            currentUser = response.results!.first as UserModel;
            update();
          }
        }
  }

  removeFromBlockList(int mUid) async {
    currentUser.removeBlockedUserIds = mUid;
    ParseResponse response = await currentUser.save();
    if(response.success){
      if(response.results!=null){
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
  }


  deductBalance(int coins, {bool save=false}){
   currentUser.decrementCoins = coins;
   if(save==true)
     currentUser.save();
   addXp(100);
  }

  Future addBalance(int coins) async {
    currentUser.setCoins = coins;
    ParseResponse response = await currentUser.save();
    if(response.success){
      if(response.results!=null){
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
  }



  addXp(int xp, {Function? then}) async {
    int xpTemp = currentUser.getXp!;
    xpTemp = xpTemp + xp;
    if(xpTemp >= 5000) {
      currentUser.setXp = (xpTemp - 5000);
      currentUser.incrementLevel = 1;
      ParseResponse response = await currentUser.save();
      if (response.success) {
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
    else if(xpTemp <= 50 && (currentUser.getLevel == 1 || currentUser.getLevel==null) ){

      currentUser.setXp= xpTemp;
      currentUser.setLevel=1;
      ParseResponse response = await currentUser.save();
      if (response.success) {
        currentUser = response.results!.first as UserModel;
        update();
      }
    }
    else{
        currentUser.incrementXp=xp;
        ParseResponse response = await currentUser.save();
        if (response.success) {
          currentUser = response.results!.first as UserModel;
          update();
        }
      }

  }

  hideMyLocation(bool value) async {
   currentUser.setHideMyLocation = value;
   ParseResponse response = await currentUser.save();
   if (response.success) {
     currentUser = response.results!.first as UserModel;
     update();
   }
  }

  hideMyBirthday(bool value) async {
    currentUser.setHideMyBirthday = value;
    ParseResponse response = await currentUser.save();
    if (response.success) {
      currentUser = response.results!.first as UserModel;
      update();
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


