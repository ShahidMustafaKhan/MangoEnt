import 'package:get/get.dart';
import 'package:teego/view/screens/authentication/broadcaster.dart';
import 'package:teego/view/screens/authentication/createAccount.dart';
import 'package:teego/view/screens/authentication/forgotPassword.dart';
import 'package:teego/view/screens/authentication/language_screen.dart';
import 'package:teego/view/screens/authentication/logIn.dart';
import 'package:teego/view/screens/authentication/newUser.dart';
import 'package:teego/view/screens/authentication/passwordChanged.dart';
import 'package:teego/view/screens/authentication/resetPassword.dart';
import 'package:teego/view/screens/chat/chat_screen.dart';
import 'package:teego/view/screens/dashboard_screen.dart';
import 'package:teego/view/screens/home/home_screen.dart';
import 'package:teego/view/screens/trending/trending_screen.dart';
import 'package:teego/view_model/theme_controller.dart';
import '../../view/screens/live/single_live_streaming/single_audience_live/single_audience_live.dart';
import '../../view/screens/live/single_live_streaming/single_audience_live/top_fan_view.dart';
import '../../view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/single_live_screen.dart';
import '../../view/screens/live/streamer_live_preview/live_preview_screen.dart';
import '../../view/screens/live/streamer_live_preview/widgets/live_bottom_card.dart';
import '../../view/screens/onBoarding.dart';
import '../../view/screens/profile/profile_screen.dart';
import 'initial_route.dart';

class AppRoutes {
  static const String initial = '/';
  static const String createAccount = '/createAccount';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String passwordChanged = '/passwordChanged';
  static const String newUser = '/newUser';
  static const String languageScreen = '/LanguageScreen';

  static const String trendingBroadcastersScreen = '/TrendingBroadcastersScreen';
  static const String dashboardScreen = '/DashboardScreen';
  static const String homeScreen = '/HomeScreen';
  static const String trendingScreen = '/TrendingScreen';
  static const String chatScreen = '/ChatScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String streamerSingleLive = '/streamerSingleLive';
  static const String audienceSingleLive = '/audienceSingleLive';
  static const String streamerLivePreview = '/streamerLivePreview';
  static const String topFan = '/topFan';
  static const String BNBPaint = '/BNBCustomPainter';


  static List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => InitialRoute.initialRoute(),
    ),
    GetPage(
        name: createAccount,
        page: () => const CreateAccount(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: onBoarding,
        page: () => OnBoardingScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: login,
        page: () => const LogIn(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: resetPassword,
        page: () => const ResetPassword(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: forgotPassword,
        page: () => const ForgotPassword(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: passwordChanged,
        page: () => const PasswordChanged(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: newUser,
        page: () => const NewUser(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: languageScreen,
        page: () => const LanguageScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: trendingBroadcastersScreen,
        page: () => const TrendingBroadcastersScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: dashboardScreen,
        page: () => DashboardView(currentUser: Get.arguments['currentUser'],),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: homeScreen,
        page: () => HomeView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: trendingScreen,
        page: () => const TrendingView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: chatScreen,
        page: () => const ChatView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: profileScreen,
        page: () => const ProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: streamerLivePreview,
        // page: () => LiveBottomCard(),
        page: () => LivePreviewScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
        name: streamerSingleLive,
        page: () => SingleLiveScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
        name: audienceSingleLive,
        page: () => SingleLiveAudienceScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
      name: topFan,
      page: () =>  TopFanView(),
    ),

  ];
}