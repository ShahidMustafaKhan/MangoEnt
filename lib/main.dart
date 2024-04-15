import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mango_ent/data/configuration/app_configuration.dart';
import 'package:mango_ent/utils/constants/app_constants.dart';
import 'package:mango_ent/utils/routes/app_routes.dart';
import 'package:mango_ent/utils/theme/theme_helper.dart';
import 'package:mango_ent/utils/constants/colors_constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfigurations.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.bgColor,
      systemNavigationBarColor: AppColors.navBarColor));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        title: AppConfigurations.applicationName,
        scrollBehavior:
        ScrollConfiguration.of(context).copyWith(overscroll: false),
        theme: theme,
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.initial,
        // routes: {
        //   '/': (context) => const HomeScreen(),
        // },
      ),
    );
  }
}
