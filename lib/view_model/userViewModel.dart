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


  updateViewModel(){
    update();
  }



  UserViewModel(this.currentUser);


}


