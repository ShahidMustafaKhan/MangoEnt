import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teego/parse/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:teego/view/screens/authentication/language_screen.dart';
import 'package:teego/view/screens/dashboard_screen.dart';
import 'package:teego/view/screens/splash_screen.dart';
import '../../services/push_service.dart';
import '../../view_model/userViewModel.dart';
import 'authentication/newUser.dart';
import 'location_screen.dart';
import 'onBoarding.dart';


// ignore_for_file: must_be_immutable
class DispatchScreen extends StatefulWidget {

  static String route = "/check";

  UserModel? currentUser;
  SharedPreferences? preferences;
  bool fromProfile;
  bool? isUserNameIncluded;

  DispatchScreen({Key? key, this.currentUser, required this.preferences, this.fromProfile=false, this.isUserNameIncluded=false}) : super(key: key);

  @override
  _DispatchScreenState createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  late UserViewModel userViewModel;

  @override
  void initState() {
    userViewModel=Get.put(UserViewModel(widget.currentUser!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.currentUser != null){

      loginUserPurchase(widget.currentUser!.objectId!);

      if(widget.currentUser!.getFirstName == null
          || widget.currentUser!.getGender == null
          || widget.currentUser!.getBirthday == null){

        return NewUser();

      } else {
            PushService(
          currentUser: widget.currentUser,
          context: context,
          preferences: widget.preferences,
        ).initialise();

        return DashboardView();
      }

    } else {

      logoutUserPurchase();

      return OnBoardingScreen();
    }
  }

  loginUserPurchase(String userId) async {
    LogInResult result = await Purchases.logIn(userId);
    if(result.created){
      print("purchase created");
    } else {
      print("purchase logged");
    }
  }

  Widget checkLocation(){

    Location location =  Location();

    return Scaffold(
      body: FutureBuilder<PermissionStatus>(
          future: location.hasPermission(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              PermissionStatus permissionStatus = snapshot.data as PermissionStatus;
              if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.grantedLimited) {
                return DashboardView();
              } else {
                return LocationScreen(currentUser: widget.currentUser,);
              }

            } else if(snapshot.hasError){
              return LocationScreen(currentUser: widget.currentUser);
              //return AddCityScreen(currentUser: widget.currentUser,);
            } else {
              return SplashScreen();
            }
          }),
    );
  }

  logoutUserPurchase() async {
    await Purchases.logOut().then((value) => print("purchase logout"));
  }
}
