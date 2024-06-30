import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' hide Trans;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

import 'package:teego/helpers/quick_help.dart';
import 'package:teego/ui/app_bar.dart';
import 'package:teego/ui/rounded_gradient_button.dart';
import 'package:teego/ui/text_with_tap.dart';
import 'package:teego/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:location/location.dart' as LocationForAll;
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../../data/app/setup.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/theme/colors_constant.dart';

class AddLocation extends StatefulWidget {



  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  TextEditingController locationController=TextEditingController();
  String city='';
  String country='';



  Future<void> _determinePosition(BuildContext context) async {
    print("Location: _determinePosition clicked");

    LocationForAll.Location location = LocationForAll.Location();

    bool _serviceEnabled;
    LocationForAll.PermissionStatus _permissionGranted;
    LocationForAll.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.location_not_supported".tr(),
            message: "permissions.add_location_manually"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);

        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == LocationForAll.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted == LocationForAll.PermissionStatus.granted ||
          _permissionGranted ==
              LocationForAll.PermissionStatus.grantedLimited) {
        QuickHelp.showLoadingDialog(context);

        _locationData = await location.getLocation();
        getAddressFromLatLng(_locationData.latitude!,_locationData.longitude!,);
      } else if (_permissionGranted == LocationForAll.PermissionStatus.denied) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.location_access_denied".tr(),
            message: "permissions.location_explain"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);
      } else if (_permissionGranted ==
          LocationForAll.PermissionStatus.deniedForever) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.enable_location".tr(),
            message: "permissions.location_access_denied_explain"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);
      }
    } else if (_permissionGranted ==
        LocationForAll.PermissionStatus.deniedForever) {
      _permissionDeniedForEver(context);
    } else if (_permissionGranted == LocationForAll.PermissionStatus.granted ||
        _permissionGranted == LocationForAll.PermissionStatus.grantedLimited) {
      QuickHelp.showLoadingDialog(context);

      _locationData = await location.getLocation();
      getAddressFromLatLng(_locationData.latitude!,_locationData.longitude!,);
    }
  }

  _permissionDeniedForEver(BuildContext context) {
    QuickHelp.showDialogPermission(
        context: context,
        title: "permissions.location_access_denied".tr(),
        confirmButtonText: "permissions.okay_settings".tr().toUpperCase(),
        message: "permissions.location_access_denied_explain"
            .tr(namedArgs: {"app_name": Setup.appName}),
        onPressed: () async {
          QuickHelp.hideLoadingDialog(context);

          QuickHelp.showAppNotificationAdvanced(
              title: "permissions.enable_location".tr(),
              message: "permissions.location_access_denied_explain"
                  .tr(namedArgs: {"app_name": Setup.appName}),
              context: context);
        });
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          locationController.text = "${place.street}, ${place.locality}, ${place.country}";
          city=place.locality!;
          country=place.country!;

          QuickHelp.hideLoadingDialog(context);
        });
      } else {
        setState(() {
          locationController.text = 'Address not found';
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        locationController.text = 'Error fetching address';
      });
    }
  }


  //
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return BaseScaffold(
      appBar: AppBar(title: Text(
        'Add Location',
        style: SafeGoogleFont (
          'DM Sans',
          fontSize: 16*ffem,
          fontWeight: FontWeight.w700,
          height: 1.375*ffem/fem,
          color: Color(0xffffffff),
        ),
      ),
      actions: [
        Visibility(
          visible: locationController.text.length>0,
          child: InkWell(
            onTap: (){
              if(locationController.text.length>0)
                Navigator.pop(context, {'address': locationController.text, 'city':city ?? '', 'country':country ?? '', "isLocationAdded": true});
            },
            child: Row(
              children: [
                Container(
                  // iconsGkZ (I5:17843;514:13056)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                  width: 20*fem,
                  height: 20*fem,
                  child: Icon(
                    Icons.check,
                   size: 20*fem,
                    color: AppColors.yellowBtnColor,
                  ),
                ),
                Container(
                  // iconsGkZ (I5:17843;514:13056)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                  width: 20*fem,
                  height: 20*fem,
                  child: Icon(
                    Icons.check,
                    size: 20*fem,
                    color: AppColors.yellowBtnColor,

                  ),
                ),
              ],
            ),
          ),
        ),
      ],

      ),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          // addlocationrFb (5:17841)
          padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
          width: double.infinity,
          decoration: const BoxDecoration (
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15 * fem, 25 * fem, 15 * fem, 15 * fem),
                padding: EdgeInsets.fromLTRB(14 * fem, 10 * fem, 16 * fem, 12 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20 * fem),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Add a location',
                          hintStyle: TextStyle(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9e9e9e),
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // Change text color as needed
                        ),
                        // Additional properties as needed: controller, onChanged, etc.
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _determinePosition(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 3 * fem, 0 * fem, 0 * fem),
                        width: 15 * fem,
                        height: 15 * fem,
                        child: Icon(
                          Icons.my_location_outlined,
                          size: 15 * fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider(color: Color(0xfff1f1f1),)

              // Container(
              //   // frame516121zy (5:17844)
              //   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
              //   width: double.infinity,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       InkWell(
              //         onTap: (){
              //           locationController.text='7 Thule Drive, Sutherlands, Australia';
              //           city='Sutherlands';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcastersMJ9 (5:17845)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame51612snH (5:17846)
              //             width: 197*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcasterscjs (5:17847)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Hide location',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfansjJh (5:17848)
              //                   '7 Thule Drive, Sutherlands, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           locationController.text='65 Brown Street , New South Wales, Australia';
              //           city='New South Wales';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcastersrPK (5:17849)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame51612n25 (5:17850)
              //             width: 248*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcastersvPB (5:17851)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Brown Words',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfansqW9 (5:17852)
              //                   '65 Brown Street , New South Wales, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           locationController.text='36 Warren Avenue, Dora Creek, Sutherlands, Australia';
              //           city='Sutherlands';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcastersaCq (5:17853)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame51612i49 (5:17854)
              //             width: 295*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcastersrg9 (5:17855)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Avenue',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfansykm (5:17856)
              //                   '36 Warren Avenue, Dora Creek, Sutherlands, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           locationController.text='5 Hebbard Street, Victoria, Australia';
              //           city='Victoria';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcastersJ2M (5:17857)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame516121xM (5:17858)
              //             width: 199*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcastersMmK (5:17859)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Scoresby',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfansUL9 (5:17860)
              //                   '5 Hebbard Street, Victoria, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           locationController.text='3 Hillsdale Road, Queensland, Australia';
              //           city='Queensland';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcasterszpH (5:17861)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame51612vxq (5:17862)
              //             width: 213*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcasterss7P (5:17863)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Dykehead',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfansyw7 (5:17864)
              //                   '3 Hillsdale Road, Queensland, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           locationController.text='65 Brown Street , New South Wales, Australia';
              //           city='New South Wales';
              //           country='Australia';
              //           setState(() {
              //
              //           });
              //         },
              //         child: Container(
              //           // recommendedbroadcastersv5f (5:17865)
              //           padding: EdgeInsets.fromLTRB(15*fem, 12*fem, 15*fem, 12*fem),
              //           width: double.infinity,
              //           height: 66*fem,
              //           decoration: BoxDecoration (
              //             border: Border.all(color: Color(0xfff1f1f1)),
              //           ),
              //           child: Container(
              //             // frame51612rED (5:17866)
              //             width: 248*fem,
              //             height: double.infinity,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   // recommendedbroadcasters177 (5:17867)
              //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
              //                   child: Text(
              //                     'Warner Lands',
              //                     style: SafeGoogleFont (
              //                       'DM Sans',
              //                       fontSize: 16*ffem,
              //                       fontWeight: FontWeight.w700,
              //                       height: 1.375*ffem/fem,
              //                       color: Color(0xff1e1e1e),
              //                     ),
              //                   ),
              //                 ),
              //                 Text(
              //                   // notifieswhenyouhavenewfans8Bj (5:17868)
              //                   '65 Brown Street , New South Wales, Australia',
              //                   style: SafeGoogleFont (
              //                     'DM Sans',
              //                     fontSize: 12*ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3333333333*ffem/fem,
              //                     color: Color(0xff1e1e1e),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}