import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/app/setup.dart';
import '../helpers/quick_help.dart';

class Utils{
  Future<void> checkPermission(BuildContext context, Function _pickFile2(StateSetter setState),StateSetter setState) async {
    if (QuickHelp.isAndroidPlatform()) {
      PermissionStatus status = await Permission.storage.status;
      PermissionStatus status2 = await Permission.camera.status;
      print('Permission android');

      checkStatus(status, status2,context,_pickFile2, setState );
    } else if (QuickHelp.isIOSPlatform()) {
      PermissionStatus status = await Permission.photos.status;
      PermissionStatus status2 = await Permission.camera.status;
      print('Permission ios');

      await checkStatus(status, status2,context,_pickFile2, setState );
    } else {
      print('Permission other device');
      _pickFile2(setState);
      // _showCreatePostBottomSheet(context);
    }
  }

  Future<void> checkStatus(PermissionStatus status, PermissionStatus status2, BuildContext context,Function _pickFile2(StateSetter setState),StateSetter setState) async {
    if (status.isDenied || status2.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.

      QuickHelp.showDialogPermission(
          context: context,
          title: "permissions.photo_access".tr(),
          confirmButtonText: "permissions.okay_".tr().toUpperCase(),
          message: "permissions.photo_access_explain"
              .tr(namedArgs: {"app_name": "Hype"}),
          onPressed: () async {
            QuickHelp.hideLoadingDialog(context);

            //if (await Permission.camera.request().isGranted) {
            // Either the permission was already granted before or the user just granted it.
            //}

            // You can request multiple permissions at once.
            Map<Permission, PermissionStatus> statuses = await [
              Permission.camera,
              Permission.photos,
              Permission.videos,
              Permission.storage,
            ].request();

            if (statuses[Permission.camera]!.isGranted &&
                statuses[Permission.photos]!.isGranted ||
                statuses[Permission.storage]!.isGranted) {
              _pickFile2(setState);
            }
          });
    } else if (status.isPermanentlyDenied || status2.isPermanentlyDenied) {
      QuickHelp.showDialogPermission(
          context: context,
          title: "permissions.photo_access_denied".tr(),
          confirmButtonText: "permissions.okay_settings".tr().toUpperCase(),
          message: "permissions.photo_access_denied_explain"
              .tr(namedArgs: {"app_name": Setup.appName}),
          onPressed: () {
            QuickHelp.hideLoadingDialog(context);

            openAppSettings();
          });
    } else if (status.isGranted && status2.isGranted) {
      _pickFile2(setState);
      //_uploadPhotos(ImageSource.gallery);
      // _showCreatePostBottomSheet(context);
    }

    print('Permission $status');
    print('Permission $status2');
  }


}

Widget emailTextField(double fem, double ffem, TextEditingController emailController, var key,{required RxString errorText, double space=5.8}){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        // statusdefaulttypeemailstatedef (1:1661)
        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
        padding: EdgeInsets.fromLTRB(21.67*fem, 14.5*fem, 0*fem, 14.5*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          boxShadow: [
            BoxShadow(
              color: const Color(0x3f000000),
              offset: Offset(0*fem, 4*fem),
              blurRadius: 2*fem,
            ),
          ],
          color: Color(0xfffafafa),
          borderRadius: BorderRadius.circular(12*fem),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // iconlyboldmessageZid (I1:1661;124:239)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13.67*fem, 0*fem),
              width: 16.67*fem,
              height: 15*fem,
              child: Image.asset(
                'assets/dino/iconly-bold-ic_live.png',
                width: 16.67*fem,
                height: 15*fem,
              ),
            ),
            SizedBox(
              height: 20*fem,
              width: 279*fem,
              child: TextFormField(
                key: key,
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  if (value.isEmpty) {
                    errorText.value= 'Email is required';
                  }
                  else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                    errorText.value= 'Enter a valid email address';
                  }
                  else{
                    errorText.value= '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.4000000272 * ffem / fem,
                    letterSpacing: 0.200000003 * fem,
                    color: Color(0xff9e9e9e),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10*fem),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.4000000272 * ffem / fem,
                  letterSpacing: 0.200000003 * fem,
                  color: Color(0xff9e9e9e),
                ),
              ),
            ),

          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(10*fem, 0, 0, 0),
        child: Obx(() {
            return Text(errorText.value, style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 12 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.4000000272 * ffem / fem,
              letterSpacing: 0.200000003 * fem,
              color: Colors.red.shade300,
            ),);
          }
        ),
      ),
      SizedBox(height: 31-space*fem,)


    ],
  );
}

Widget passwordTextField(double fem, double ffem, RxBool isObscure,TextEditingController passwordController,{required RxString errorText}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        // statusdefaulttypepasswordstate (1:1662)
        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
        padding: EdgeInsets.fromLTRB(22.92*fem, 14.5*fem, 21.67*fem, 14.5*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0*fem, 4*fem),
              blurRadius: 2*fem,
            ),
          ],
          color: Color(0xfffafafa),
          borderRadius: BorderRadius.circular(12*fem),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // iconlyboldlockf9P (I1:1662;124:252)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.92*fem, 0*fem),
              width: 14.17*fem,
              height: 16.67*fem,
              child: Image.asset(
                'assets/dino/iconly-bold-lock.png',
                width: 14.17*fem,
                height: 16.67*fem,
              ),
            ),
            Obx(() {
                return Container(
                  height: 20*fem,
                  width: 199*fem,
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isObscure.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        errorText.value= 'Password is required';
                      }
                      else if (value.length > 8 ) {
                        if(!RegExp(r'(?=.*\d)').hasMatch(value)){
                          errorText.value = 'Password must contain at least one number';
                        }
                        else{
                          errorText.value= '';
                        }
                      }
                      else if (value.length < 8 || !RegExp(r'(?=.*\d)').hasMatch(value)) {
                        errorText.value = 'Password should be 8+ characters with at least 1 number';
                      }
                      else{
                        errorText.value= '';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.4000000272 * ffem / fem,
                        letterSpacing: 0.200000003 * fem,
                        color: Color(0xff9e9e9e),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10*fem),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.4000000272 * ffem / fem,
                      letterSpacing: 0.200000003 * fem,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                );
              }
            ),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: (){
                isObscure.value=!isObscure.value;
              },
              child: Container(
                // iconlyboldhide4xD (I1:1662;125:161)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                width: 16.67*fem,
                height: 14.17*fem,
                child: Image.asset(
                  'assets/dino/iconly-bold-hide.png',
                  width: 16.67*fem,
                  height: 14.17*fem,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(10*fem, 0, 0, 0),
        child: Obx(() {
          return Text(errorText.value, style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 12 * ffem,
            fontWeight: FontWeight.w500,
            height: 1.4000000272 * ffem / fem,
            letterSpacing: 0.200000003 * fem,
            color: Colors.red.shade300,
          ),);
        }
        ),
      ),
      SizedBox(height: 31-15*fem,)
    ],
  );
}

Widget rememberMeCheckBox(double fem, double ffem, RxBool isChecked, StateSetter setState){
  return Container(
    margin: EdgeInsets.fromLTRB(124.5*fem, 0*fem, 94.5*fem, 20*fem),
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // rectanglegih (I1:1663;442:2459)
          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 0*fem),
          width: 24*fem,
          height: 24*fem,
          // decoration: BoxDecoration (
          //   borderRadius: BorderRadius.circular(8*fem),
          //   border: Border.all(color: const Color(0xff50b0ed),width: 2),
          // ),
          child:  Theme(
            data: ThemeData(
                primaryColor: Color(0xFF57AAFF),
                unselectedWidgetColor: Color(0xFF57AAFF),
            ),
            child: Obx(() {
                return Checkbox(
                  value: isChecked.value,
                  onChanged: (bool? value) {
                      isChecked.value = value ?? false;

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Set the border radius
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }
            ),
          ),
        ),
        Text(
          'Remember me',
          style: SafeGoogleFont (
            'Urbanist',
            fontSize: 14*ffem,
            fontWeight: FontWeight.w600,
            height: 1.4000000272*ffem/fem,
            letterSpacing: 0.200000003*fem,
            color: Color(0xff212121),
          ),
        ),
      ],
    ),
  );
}

TextStyle SafeGoogleFont(
    String fontFamily, {
      TextStyle? textStyle,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      Locale? locale,
      Paint? foreground,
      Paint? background,
      List<Shadow>? shadows,
      List<FontFeature>? fontFeatures,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
    }) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    print("erorr in text$ex");
    print(ex);
    print(ex);
    print(ex);
    print(ex);
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

String capitalizeAllWords(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return word;
    }
    return word[0].toUpperCase() + word.substring(1);
  }).toList();
  return capitalizedWords.join(' ');
}

String limitedWords(String text, int split){
  List<String> words = text.split(' '); // Split the text into words

  String firstTwoWords = words.take(split).join(' ');
  return firstTwoWords;
}

void openKeyboardAndFocusTextField(BuildContext context, FocusNode myFocusNode) {
  FocusScope.of(context).requestFocus(myFocusNode);
}

void unFocusTextField(FocusNode myFocusNode){
  myFocusNode.unfocus();
}