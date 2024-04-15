<<<<<<< HEAD
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:mango_ent/utils/constants/app_constants.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';
>>>>>>> b66b919 (latest)

class AppConfigurations {
  static Future<void> initialize() async {
    await dot_env.dotenv.load();
  }

  static String get applicationName {
    var value = dot_env.dotenv.env["APP_NAME"] ?? AppInfo.appTitle;
    return value;
  }
<<<<<<< HEAD
=======

  static setSystemPreference ({bool isBottomNav = false}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: (Get.isDarkMode || isBottomNav) ? AppColors.navBarColor : AppColors.lightBGColor));
  }
>>>>>>> b66b919 (latest)
}