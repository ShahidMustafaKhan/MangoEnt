import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../helpers/quick_actions.dart';
import '../parse/UserModel.dart';

class StreamerProfileController extends GetxController {
  var selectedIndex = 1.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  UserModel? profile;
  bool otherProfile=false;


  StreamerProfileController(this.otherProfile, this.profile);


  @override
  void onInit() {
    otherProfile=this.otherProfile;
    profile=this.profile;
    super.onInit();
  }
}
