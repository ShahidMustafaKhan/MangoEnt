import 'package:get/get.dart';
import 'package:mango_ent/view/screens/home_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  static List<GetPage> pages = [
    // GetPage(
    //   name: dashboard,
    //   page: () => const InterpreterDashBoard(),
    //   binding: DashBoardBinding(),
    // ),
    GetPage(
      name: initial,
      page: () => const HomeScreen(),
    ),
  ];
}