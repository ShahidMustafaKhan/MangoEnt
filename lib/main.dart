import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mango_ent/view/screens/home_screen.dart';
import 'package:mango_ent/view/utils/colors_constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo App',
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: AppColors.bgColor),
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
      designSize: const Size(375, 812),
    );
  }
}
