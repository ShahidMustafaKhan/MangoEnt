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
import 'package:teego/view/screens/home/home_screen/home_screen.dart';
import 'package:teego/view/screens/trending/trending_screen.dart';
import 'package:teego/view_model/theme_controller.dart';
import '../../view/screens/chat/chat_report_screen.dart';
import '../../view/screens/chat/chat_setting_screen.dart';
import '../../view/screens/home/home_screen/search_screen.dart';
import '../../view/screens/live/audio_live_streaming/audio_audience_live/audio_audience_live_screen.dart';
import '../../view/screens/live/audio_live_streaming/audio_streamer_live/audio_streamer_live_screen.dart';
import '../../view/screens/live/multi_live_streaming/multi_audience_live/multi_audience_live_screen.dart';
import '../../view/screens/live/multi_live_streaming/multi_streamer_live/multi_streamer_live_screen.dart';
import '../../view/screens/live/single_live_streaming/single_audience_live/single_audience_live.dart';
import '../../view/screens/live/single_live_streaming/single_audience_live/top_fan_view.dart';
import '../../view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/single_live_screen.dart';
import '../../view/screens/live/streamer_live_preview/live_preview_screen.dart';
import '../../view/screens/live/streamer_live_preview/widgets/live_bottom_card.dart';
import '../../view/screens/live/widgets/basic_feature_sheets/end_screen.dart';
import '../../view/screens/onBoarding.dart';
import '../../view/screens/profile/profile_screen.dart';
import '../../view/screens/trending/post_notification_screen.dart';
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
  static const String streamerAudioLive = '/streamerAudioLive';
  static const String audienceAudioLive = '/audienceAudioLive';
  static const String streamerMultiLive = '/streamerMultiLive';
  static const String audienceMultiLive = '/audienceMultiLive';
  static const String streamerLivePreview = '/streamerLivePreview';
  static const String topFan = '/topFan';
  static const String BNBPaint = '/BNBCustomPainter';
  static const String searchScreen = '/searchScreen';
  static const String postNotificationScreen = '/PostNotificationScreen';
  static const String endScreen = '/EndScreen';
  static const String messageView = '/messageView';
  static const String chatSettingScreen = '/chatSettingScreen';
  static const String chatReportScreen = '/chatReportScreen';


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
    // GetPage(
    //     name: newUser,
    //     page: () => NewUser(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => ThemeController());
    //     })),
    GetPage(
        name: languageScreen,
        page: () => LanguageScreen(),
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
        page: () => DashboardView(),
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
        page: () => TrendingView(),
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
        name: streamerAudioLive,
        page: () => StreamerAudioLive(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
        name: audienceAudioLive,
        page: () => AudienceAudioLive(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
        name: streamerMultiLive,
        page: () => StreamerMultiLive(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
        name: audienceMultiLive,
        page: () => AudienceMultiLive(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })
    ),
    GetPage(
      name: topFan,
      page: () =>  TopFanView(),
    ),

    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: postNotificationScreen, page: () => PostNotificationScreen()),
    GetPage(name: endScreen, page: () => EndScreen()),
    GetPage(name: messageView, page: () => MessageView()),
    GetPage(name: chatSettingScreen, page: () => ChatSettingScreen()),
    GetPage(name: chatReportScreen, page: () => ChatReportScreen()),


  ];
}