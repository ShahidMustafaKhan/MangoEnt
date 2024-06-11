import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teego/data/app/constants.dart';
import 'package:teego/data/app/setup.dart';
import 'package:teego/parse/BattleStreamingModel.dart';
import 'package:teego/parse/CommentsModel.dart';
import 'package:teego/parse/GiftsModel.dart';
import 'package:teego/parse/GiftsSentModel.dart';
import 'package:teego/parse/InvitedUsersModel.dart';
import 'package:teego/parse/MessageListModel.dart';
import 'package:teego/parse/MessageModel.dart';
import 'package:teego/parse/NotificationsModel.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/parse/PostsModel.dart';
import 'package:teego/parse/RankingModel.dart';
import 'package:teego/parse/ReportModel.dart';
import 'package:teego/parse/TimerModel.dart';
import 'package:teego/parse/WithdrawModel.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:teego/data/app/navigation_service.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teego/utils/theme/theme_helper.dart';
import 'parse/MusicModel.dart';
import 'parse/PaymentsModel.dart';
import 'parse/ReplyModel.dart';
import 'services/dynamic_link_service.dart';
import 'data/app/config.dart';
import 'parse/LiveMessagesModel.dart';
import 'parse/LiveStreamingModel.dart';
import 'view_model/animation_controller.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Error firebase initialize');
  }
  print('End firebase initialize');
  await EasyLocalization.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light// Change 'Colors.blue' to your desired color.
  ));

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (QuickHelp.isMobile()) {
    MobileAds.instance.initialize();
  }

  initPlatformState();

  Stripe.publishableKey =
      'pk_live_51I7PORFscf0wcwAmgLtfR6UIpCzSWiTwpAjPSQb85cO5hjhgP1WBJJvImDjveuYv0ATsnQcXYSoFu6gdQczwlh7y00ypU4BVXb';



  Map<String, ParseObjectConstructor> subClassMap =
      <String, ParseObjectConstructor>{
    PostsModel.keyTableName: () => PostsModel(),
    RankingModel.keyTableName: () => RankingModel(),
    NotificationsModel.keyTableName: () => NotificationsModel(),
    CommentsModel.keyTableName: () => CommentsModel(),
    GiftsModel.keyTableName: () => GiftsModel(),
    GiftsSentModel.keyTableName: () => GiftsSentModel(),
    LiveStreamingModel.keyTableName: () => LiveStreamingModel(),
    LiveMessagesModel.keyTableName: () => LiveMessagesModel(),
    LiveMessagesModel.keyTableName: () => LiveMessagesModel(),
    MessageModel.keyTableName: () => MessageModel(),
    MessageListModel.keyTableName: () => MessageListModel(),
    WithdrawModel.keyTableName: () => WithdrawModel(),
    PaymentsModel.keyTableName: () => PaymentsModel(),
    InvitedUsersModel.keyTableName: () => InvitedUsersModel(),
    MusicModel.keyTableName: () => MusicModel(),
    ReplyModel.keyTableName: () => ReplyModel(),
    ReportModel.keyTableName: () => ReportModel(),
    BattleModel.keyTableName: () => BattleModel(),
    TimerModel.keyTableName: () => TimerModel()
  };

  await Parse().initialize(
    Config.appId,
    Config.serverUrl,
    clientKey: Config.clientKey,
    liveQueryUrl: Config.liveQueryUrl,
    autoSendSessionId: true,
    coreStore: QuickHelp.isWebPlatform()
        ? await CoreStoreSharedPrefsImp.getInstance()
        : await CoreStoreSembastImp.getInstance(password: Config.appId),
    debug: Setup.isDebug,
    appName: Setup.appName,
    appPackageName: Setup.appPackageName,
    appVersion: Setup.appVersion,
    locale: await Devicelocale.currentLocale,
    parseUserConstructor: (username, password, email,
            {client, debug, sessionToken}) =>
        UserModel(username, password, email),
    registeredSubClassMap: subClassMap,
  );

  runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      DynamicLinkService().retrieveDynamicLink();

      runApp(
        EasyLocalization(
          supportedLocales: Config.languages,
          path: 'assets/translations',
          fallbackLocale: Locale(Config.defaultLanguage),
          child: App(),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> initPlatformState() async {
  if (Setup.isDebug) {
    await Purchases.setLogLevel(LogLevel.verbose);
  }

  PurchasesConfiguration? configuration;

  if (QuickHelp.isAndroidPlatform()) {
    configuration = PurchasesConfiguration(Config.publicGoogleSdkKey);
  } else if (QuickHelp.isIOSPlatform()) {
    configuration = PurchasesConfiguration(Config.publicIosSdkKey);
  }
  await Purchases.configure(configuration!);
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late SharedPreferences preferences;
  AnimationViewModel animationController =Get.put(AnimationViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(Duration(seconds: 2), () {
      DynamicLinkService().listenDynamicLink(context);
    });

    initSharedPref();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (_ , child) {
        return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return GetMaterialApp(
                title: Setup.appName,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                navigatorKey: NavigationService.navigatorKey,
                locale: context.locale,
                scrollBehavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
                theme: ThemeHelper.darkTheme,
                darkTheme: ThemeHelper.darkTheme,
                themeMode: ThemeMode.system,
                getPages: AppRoutes.pages,
                initialRoute: AppRoutes.initial,
              );

        });});
  }

  logoutUserPurchase() async {
    if (!await Purchases.isAnonymous) {
      await Purchases.logOut().then((value) => print("purchase logout"));
    }
  }

  initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    Constants.queryParseConfig(preferences);
  }
}
