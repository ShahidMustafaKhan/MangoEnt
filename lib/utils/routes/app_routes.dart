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
import '../../view/screens/dashboard/bag/bag.dart';
import '../../view/screens/dashboard/level/level.dart';
import '../../view/screens/dashboard/profile/profile_screen.dart';
import '../../view/screens/dashboard/profile_dashboard_screen.dart';
import '../../view/screens/dashboard/store/store.dart';
import '../../view/screens/dashboard/subscription/subscribers.dart';
import '../../view/screens/dashboard/subscription/subscription.dart';
import '../../view/screens/dashboard/wallet/transaction_history.dart';
import '../../view/screens/dashboard/wallet/wallet.dart';
import '../../view/screens/home/home_screen/search_screen.dart';
import '../../view/screens/live/audio_live_streaming/audio_audience_live/audio_audience_live_screen.dart';
import '../../view/screens/live/audio_live_streaming/audio_streamer_live/audio_streamer_live_screen.dart';
import '../../view/screens/live/multi_live_streaming/multi_audience_live/multi_audience_live_screen.dart';
import '../../view/screens/live/multi_live_streaming/multi_streamer_live/multi_streamer_live_screen.dart';
import '../../view/screens/live/single_live_streaming/single_audience_live/single_audience_live.dart';
import '../../view/screens/ranking/top_fan_view.dart';
import '../../view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/single_live_screen.dart';
import '../../view/screens/live/streamer_live_preview/live_preview_screen.dart';
import '../../view/screens/live/widgets/basic_feature_sheets/end_screen.dart';
import '../../view/screens/onBoarding.dart';
import '../../view/screens/dashboard/profile/edit_profile_screen.dart';
import '../../view/screens/setting/account_and_security_screen.dart';
import '../../view/screens/setting/change_email/change_email_screen.dart';
import '../../view/screens/setting/change_email/security_verification_email.dart';
import '../../view/screens/setting/change_password/change_new_password_screen.dart';
import '../../view/screens/setting/change_password/change_password_screen.dart';
import '../../view/screens/setting/change_password/password_success_screen.dart';
import '../../view/screens/setting/connected_account_screen.dart';
import '../../view/screens/setting/delete_account_screen.dart';
import '../../view/screens/setting/dislike_setting_screen.dart';
import '../../view/screens/setting/general_setting_screen.dart';
import '../../view/screens/setting/link_email/link_email_screen.dart';
import '../../view/screens/setting/link_email/success_email_screen.dart';
import '../../view/screens/setting/link_email/verify_email_screen.dart';
import '../../view/screens/setting/login_method_screen.dart';
import '../../view/screens/setting/notification/boost_notification.dart';
import '../../view/screens/setting/notification/broadcast_notification.dart';
import '../../view/screens/setting/notification/discover_notification.dart';
import '../../view/screens/setting/notification/moment_notification.dart';
import '../../view/screens/setting/notification/notification_screen.dart';
import '../../view/screens/setting/notification/private_message_notification.dart';
import '../../view/screens/setting/notification/smart_live_notification.dart';
import '../../view/screens/setting/privacy_screen.dart';
import '../../view/screens/setting/reset_password/reset_password_screen.dart';
import '../../view/screens/setting/reset_password/retrieve_password_screen.dart';
import '../../view/screens/setting/reset_password/set_new_password_screen.dart';
import '../../view/screens/setting/self_ban_screen.dart';
import '../../view/screens/setting/setting_screen.dart';
import '../../view/screens/trending/create_post_screen.dart';
import '../../view/screens/trending/post_notification_screen.dart';
import '../../view/screens/userProfileView/user_profile_view_screen.dart';
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
  static const String userDashBoardScreen = '/UserDashBoardScreen';
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
  static const String profileDashBoardScreen = '/profileDashBoardScreen';
  static const String userProfileView = '/userProfileView';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String transactionHistory = '/transactionHistory';
  static const String bag = '/bag';
  static const String level = '/level';
  static const String topFans = '/topFans';
  static const String subscription = '/subscription';
  static const String subscribers = '/subscribers';
  static const String wallet = '/wallet';
  static const String store = '/store';
  static const String settingScreen = '/settingScreen';
  static const String accountAndSecurity = '/accountAndSecurity';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String retrievePasswordScreen = '/retrievePasswordScreen';
  static const String setNewPassword = '/setNewPassword';
  static const String linkEmail = '/linkEmail';
  static const String verifyEmail = '/verifyEmail';
  static const String successEmailScreen = '/successEmailScreen';
  static const String changeEmail = '/changeEmail';
  static const String securityVerificationEmail = '/securityVerificationEmail';
  static const String changePassword = '/changePassword';
  static const String changeNewPassword = '/changeNewPassword';
  static const String successPasswordScreen = '/successPasswordScreen';
  static const String loginMethod = '/loginMethod';
  static const String deleteAccount = '/deleteAccount';
  static const String selfBan = '/selfBan';
  static const String connectedAccount = '/connectedAccount';
  static const String notificationScreen = '/notificationScreen';
  static const String privateMessagesNotification =
      '/privateMessagesNotification';
  static const String broadcastNotification = '/broadcastNotification';
  static const String smartLiveNotification = '/smartLiveNotification';
  static const String boostNotification = '/boostNotification';
  static const String discoverNotification = '/discoverNotification';
  static const String momentNotification = '/momentNotification';
  static const String privacySettingScreen = '/privacySettingScreen';
  static const String generalSetting = '/generalSetting';
  static const String dislikeSetting = '/dislikeSetting';
  static const String createPostScreen = '/createPostScreen';


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
        name: profileDashBoardScreen,
        page: () => const ProfileDashBoardScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ThemeController());
        })),
    GetPage(
        name: streamerLivePreview,
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
    GetPage(name: userProfileView, page: () => UserProfileView()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: transactionHistory, page: () => TransactionHistory()),
    GetPage(name: bag, page: () => Bag()),
    GetPage(name: level, page: () => Level()),
    GetPage(name: subscription, page: () => Subscription()),
    GetPage(name: subscribers, page: () => Subscribers()),
    GetPage(name: wallet, page: () => Wallet()),
    GetPage(name: store, page: () => Store()),
    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: accountAndSecurity, page: () => AccountAndSecurity()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: retrievePasswordScreen, page: () => RetrievePasswordScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPassword()),
    GetPage(name: linkEmail, page: () => LinkEmail()),
    GetPage(name: verifyEmail, page: () => VerifyEmail()),
    GetPage(name: successEmailScreen, page: () => SuccessEmailScreen()),
    GetPage(name: changeEmail, page: () => ChangeEmail()),
    GetPage(
        name: securityVerificationEmail,
        page: () => SecurityVerificationEmail()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: changeNewPassword, page: () => ChangeNewPasswordScreen()),
    GetPage(name: successPasswordScreen, page: () => SuccessPasswordScreen()),
    GetPage(name: loginMethod, page: () => LoginMethod()),
    GetPage(name: deleteAccount, page: () => DeleteAccount()),
    GetPage(name: selfBan, page: () => SelfBan()),
    GetPage(name: connectedAccount, page: () => ConnectedAccount()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: privateMessagesNotification, page: () => PrivateMessage()),
    GetPage(name: broadcastNotification, page: () => BroadcastNotification()),
    GetPage(name: smartLiveNotification, page: () => SmartLiveNotification()),
    GetPage(name: boostNotification, page: () => BoostNotification()),
    GetPage(name: discoverNotification, page: () => DiscoverNotification()),
    GetPage(name: momentNotification, page: () => MomentNotification()),
    GetPage(name: privacySettingScreen, page: () => PrivacySettingScreen()),
    GetPage(name: generalSetting, page: () => GeneralSetting()),
    GetPage(name: dislikeSetting, page: () => DislikeSetting()),
    GetPage(name: createPostScreen, page: () => CreatePostScreen()),


  ];
}