
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/app/setup.dart';
import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../utils/datoo_exeption.dart';
import '../view/screens/authentication/social_login.dart';

class AuthViewModel extends GetxController {


  Future<User?> signUpWithGoogle(GoogleSignIn _googleSignIn, FirebaseAuth firebaseAuth, BuildContext context, SharedPreferences preferences) async {
    try {
      // await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'number': user.phoneNumber,
          'photoUrl': user.photoURL,
          'id': user.uid
        }, SetOptions(merge: true));


        final ParseResponse response = await ParseUser.loginWith(
            'google',
            google(
                googleSignInAuthentication.accessToken!,
                _googleSignIn.currentUser!.id,
                googleSignInAuthentication.idToken!));

        if (response.success) {
          UserModel? user = await ParseUser.currentUser();
          if (user != null) {
            if (user.getUid == null) {
              getGoogleUserDetails(user, googleSignInAccount,
                  googleSignInAuthentication.idToken!,context,preferences);
            } else {
              QuickHelp.showAppNotificationAdvanced(
                  context: context, title: "An account with this username already exists");
              await _googleSignIn.signOut();
              user.logout();
              // SocialLogin.goHome(context, user, preferences);
            }
          } else {
            QuickHelp.hideLoadingDialog(context);
            QuickHelp.showAppNotificationAdvanced(
                context: context, title: "auth.gg_login_error");
            await _googleSignIn.signOut();
          }
        } else {
          QuickHelp.hideLoadingDialog(context);
          QuickHelp.showAppNotificationAdvanced(
              context: context, title: response.error!.message);
          await _googleSignIn.signOut();
        }
      } else {
        await _googleSignIn.signOut();
      }
      return user;
    } catch (error) {
      if (error == GoogleSignIn.kSignInCanceledError) {
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: "auth.gg_login_cancelled");
      } else if (error == GoogleSignIn.kNetworkError) {
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: "not_connected");
      } else {
        print(error.toString());
        print(error.toString());
        print(error.toString());
        print(error.toString());
        print(error.toString());
        print(error.toString());
        print(error.toString());
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: error.toString());
      }


      await _googleSignIn.signOut();
      return null;
    }
  }

  Future<User?> signInWithGoogle(GoogleSignIn _googleSignIn, FirebaseAuth firebaseAuth, BuildContext context, SharedPreferences preferences) async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount=
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'number': user.phoneNumber,
          'photoUrl': user.photoURL,
          'id': user.uid
        }, SetOptions(merge: true));

        final ParseResponse response = await ParseUser.loginWith(
            'google',
            google(
                googleSignInAuthentication.accessToken!,
                _googleSignIn.currentUser!.id,
                googleSignInAuthentication.idToken!));

        if (response.success) {
          UserModel? user = await ParseUser.currentUser();
          if (user != null) {
            if (user.getUid == null) {
              QuickHelp.showAppNotificationAdvanced(
                  context: context, title: "No account with this user exists. Please proceed to create a new account.");
              await _googleSignIn.signOut();
              user.logout();

            } else {
              SocialLogin.goHome(context, user, preferences);
            }
          } else {
            QuickHelp.hideLoadingDialog(context);
            QuickHelp.showAppNotificationAdvanced(
                context: context, title: "auth.gg_login_error");
            await _googleSignIn.signOut();
          }
        } else {
          QuickHelp.hideLoadingDialog(context);
          QuickHelp.showAppNotificationAdvanced(
              context: context, title: response.error!.message);
          await _googleSignIn.signOut();
        }
      } else {
        await _googleSignIn.signOut();
      }
      return user;
    } catch (error) {
      if (error == GoogleSignIn.kSignInCanceledError) {
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: "auth.gg_login_cancelled");
      } else if (error == GoogleSignIn.kNetworkError) {
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: "not_connected");
      } else {
        QuickHelp.showAppNotificationAdvanced(
            context: context, title: "auth.gg_login_error");
      }


      await _googleSignIn.signOut();
      return null;
    }
  }
  
  void getGoogleUserDetails(
      UserModel user, GoogleSignInAccount googleUser, String idToken,BuildContext context, SharedPreferences preferences) async {
    Map<String, dynamic>? idMap = QuickHelp.getInfoFromToken(idToken);

    String firstName = idMap!["given_name"];
    String lastName = idMap["family_name"];

    String username =
        lastName.replaceAll(" ", "") + firstName.replaceAll(" ", "");

    user.setFullName = googleUser.displayName!;
    user.setGoogleId = googleUser.id;
    user.setFirstName = firstName;
    user.setLastName = lastName;
    user.username = username.toLowerCase().trim()+ QuickHelp.generateRandomNumber().toString();
    user.setEmail = googleUser.email;
    user.setEmailPublic = googleUser.email;
    //user.setGender = await getGender();
    user.setUid = QuickHelp.generateUId();
    user.setPopularity = 0;
    user.setUserRole = UserModel.roleUser;
    user.setPrefMinAge = Setup.minimumAgeToRegister;
    user.setPrefMaxAge = Setup.maximumAgeToRegister;
    user.setLocationTypeNearBy = true;
    user.addCredit = Setup.welcomeCredit;
    user.setBio = Setup.bio;
    user.setHasPassword = false;
    ParseResponse response = await user.save();

    if (response.success) {
      SocialLogin.getPhotoFromUrl(
          context, user, googleUser.photoUrl!, preferences);
    } else {
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showErrorResult(context, response.error!.code);
    }
  }

  signInWithApple(BuildContext context){
    if(QuickHelp.getPlatform() == "IOS"){

    }
    else{
      QuickHelp.showAppNotificationAdvanced(title: "SignIn method not supported on device", context: context);
    }

  }

  signupWithApple(BuildContext context) {
    if (QuickHelp.getPlatform() == "IOS") {

    }
    else {
      QuickHelp.showAppNotificationAdvanced(
          title: "SignUp method not supported on device", context: context);
    }
  }




 void signUpWithUserName( BuildContext context, SharedPreferences preferences, String userName, String password) async {
    try {
      QuickHelp.showLoadingDialog(context);


      var user =  UserModel(userName, password, null);


          var response = await user.signUp(allowWithoutEmail: true);

          if (response.success)
            {
              UserModel user = response.result;
              getUserDetails(user,context,preferences);
            }
          else{
            QuickHelp.hideLoadingDialog(context);
            QuickHelp.showAppNotificationAdvanced(title: response.error!.message, context: context);
          }


    } catch(e) {
      QuickHelp.hideLoadingDialog(context);

      QuickHelp.showAppNotificationAdvanced(title: e.toString(), context: context);
      print(e.toString());

    }
  }


 void signInWithUserName( BuildContext context, SharedPreferences preferences, String userName, String password) async {
    try {
      QuickHelp.showLoadingDialog(context);

      var user =  UserModel(userName, password, null);


          var response = await user.login();

          if (response.success)
            {
              UserModel user = response.result;
              SocialLogin.goHome(context, user, preferences,isUserNameIncluded: null );
            }
          else{
            QuickHelp.hideLoadingDialog(context);
            QuickHelp.showAppNotificationAdvanced(title: response.error!.message, context: context);
          }


    } catch (error) {
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(title: 'response.error!.message', context: context);

    }
  }


 void guestSignIn( BuildContext context,) async {
    try {
      QuickHelp.showLoadingDialog(context);
      // String userName=getEmailUserName(email);

      var user =  UserModel("guest", "123456", null);


          var response = await user.login();
          print(response.statusCode);
          print(response.error);
          print(response.result);
          if (response.success)
            {
              UserModel user = response.result;
              SocialLogin.goHome(context, user, null,isUserNameIncluded: true);
            }
          else{
            QuickHelp.hideLoadingDialog(context);
            QuickHelp.showAppNotificationAdvanced(title: response.error!.message, context: context);
          }


    } catch (error) {
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showAppNotificationAdvanced(title: 'response.error!.message', context: context);

    }
  }



  void getUserDetails(
      UserModel user,BuildContext context, SharedPreferences preferences, {bool isUserNameIncluded=false}) async {

    user.setUid = QuickHelp.generateUId();
    user.setPopularity = 0;
    user.setUserRole = UserModel.roleUser;
    user.setPrefMinAge = Setup.minimumAgeToRegister;
    user.setPrefMaxAge = Setup.maximumAgeToRegister;
    user.setLocationTypeNearBy = true;
    user.addCredit = Setup.welcomeCredit;
    user.setBio = Setup.bio;
    user.setHasPassword = true;
    //user.setBirthday = QuickHelp.getDateFromString(_userData!['birthday'], QuickHelp.dateFormatFacebook);
    ParseResponse response = await user.save();

    if (response.success) {
      SocialLogin.goHome(context, user, preferences, isUserNameIncluded: isUserNameIncluded);
    } else {
      QuickHelp.hideLoadingDialog(context);
      QuickHelp.showErrorResult(context, response.error!.code);
    }
  }




  String getEmailUserName(String email) {
    List<String> parts = email.split('*');

    // Ensure that there is at least one part before the asterisk
    if (parts.length > 1) {
      return parts.first;
    } else {
      // If there is no asterisk, return the entire email
      return email;
    }
  }

  Future<void> forgetPassword(_emailOrAccountText, BuildContext context) async {

    QuickHelp.showLoadingDialog(context);


    if(!_emailOrAccountText.contains('@')){

      QueryBuilder<UserModel> queryBuilder = QueryBuilder<UserModel>(UserModel.forQuery());
      queryBuilder.whereEqualTo(UserModel.keyUsername, _emailOrAccountText);
      ParseResponse apiResponse = await queryBuilder.query();

      if (apiResponse.success && apiResponse.results != null) {

        UserModel userModel = apiResponse.results!.first;
        _processLogin(userModel.getEmailPublic, context);

      } else {

        showError(apiResponse.error!.code, context);
      }

    } else {

      _processLogin(_emailOrAccountText, context);
    }
  }

  Future<void> _processLogin(String? email, BuildContext context) async {

    final user = ParseUser(null, null, email);


    var response = await user.requestPasswordReset();

    if (response.success) {
      showSuccess(context);
    } else {
      showError(response.error!.code, context);
    }
  }

  Future<void> showSuccess(BuildContext context) async {

    QuickHelp.hideLoadingDialog(context);

    QuickHelp.showAppNotificationAdvanced(context: context, title: "auth.forgot_sent".tr(), message: "auth.email_explain".tr(), isError: false);
  }

  void showError(int error, BuildContext context) {
    QuickHelp.hideLoadingDialog(context);

    if(error == DatooException.connectionFailed){
      // Internet problem
      QuickHelp.showAppNotificationAdvanced(context: context, title: "error".tr(), message: "not_connected".tr(), isError: true);
    } /*else if(error == DatooException.accountBlocked){
      // Internet problem
      QuickHelp.showAlertError(context: context, title: "error".tr(), message: "auth.account_blocked".tr());
    }*/ else {
      // Invalid credentials
      QuickHelp.showAppNotificationAdvanced(context: context, title: "error".tr(), message: "auth.invalid_credentials".tr(), isError: true);
    }

  }



  @override
  void onInit() {
    super.onInit();
  }
}

