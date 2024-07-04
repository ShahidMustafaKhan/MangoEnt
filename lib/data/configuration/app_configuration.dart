import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class AppConfigurations {
  static Future<void> initialize() async {
    await dot_env.dotenv.load();
  }

  static String get applicationName {
    var value = dot_env.dotenv.env["APP_NAME"] ?? AppInfo.appTitle;
    return value;
  }

  static setSystemPreference ({bool isBottomNav = false}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: AppColors.white100.withOpacity(0.1), // Set the divider color if needed
        systemNavigationBarColor: (Get.isDarkMode || isBottomNav) ? AppColors.navBarColor :  Color(0xff333333)));
  }
}