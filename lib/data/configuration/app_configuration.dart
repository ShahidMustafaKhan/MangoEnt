import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:mango_ent/utils/constants/app_constants.dart';

class AppConfigurations {
  static Future<void> initialize() async {
    await dot_env.dotenv.load();
  }

  static String get applicationName {
    var value = dot_env.dotenv.env["APP_NAME"] ?? AppInfo.appTitle;
    return value;
  }
}