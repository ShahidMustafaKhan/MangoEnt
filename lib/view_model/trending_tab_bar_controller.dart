import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TrendingTabBarViewModel extends GetxController {
  List<String> categories = [
    "Post",
    "Following",
    "For You",
  ];

  RxInt selectedId = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedId.value = 0;
  }
}
