import 'package:get/get.dart';

import '../view/screens/live/zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';

class GridController extends GetxController {
  var isExpanded = false.obs;
  late ZegoSDKUser user;
  int? seat;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}
