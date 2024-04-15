import 'package:flutter/cupertino.dart';
import 'package:teego/view/screens/dispatch_screen.dart';
import 'package:teego/view/screens/onBoarding.dart';
import 'package:upgrader/upgrader.dart';
import '../../data/app/setup.dart';
import '../../helpers/quick_help.dart';
import '../../parse/UserModel.dart';
import '../../view/screens/splash_screen.dart';

class InitialRoute{
  
 static Widget initialRoute() {
    return UpgradeAlert(
      upgrader: Upgrader(
        debugDisplayAlways: false,
        debugLogging: Setup.isDebug,
        showIgnore: false,
        showLater: false,
        canDismissDialog: false,
        shouldPopScope: () => false,
        durationUntilAlertAgain: Duration(seconds: 10),
        minAppVersion: Setup.appVersion,
      ),
      child: FutureBuilder<UserModel?>(
        future: QuickHelp.getUserAwait(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SplashScreen();
            default:
              if (snapshot.hasData) {
                return DispatchScreen(
                  // preferences: preferences,
                  currentUser: snapshot.data, preferences: null,
                );
              } else {
                // logoutUserPurchase();
                return OnBoardingScreen();
              }
          }
        },
      ),
    );
  }
}