import 'package:get/get.dart';
import 'package:teego/utils/theme/theme_helper.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  RxBool darkTheme = true.obs;

  void toggleTheme() {
    Get.changeTheme(
        Get.isDarkMode ? ThemeHelper.lightTheme : ThemeHelper.darkTheme);
    update();
  }
}
