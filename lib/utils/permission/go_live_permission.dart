import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:permission_handler/permission_handler.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../data/app/setup.dart';
import '../../helpers/quick_help.dart';
import '../../parse/LiveStreamingModel.dart';
import '../../parse/UserModel.dart';
import '../../view/screens/location_screen.dart';


class LivePermissionHandler{
  static Future<void> checkPermission(String? streamingType, BuildContext context,
      {LiveStreamingModel? liveStreamingModel}) async {
    if (QuickHelp.isAndroidPlatform()) {

      PermissionStatus status2 = await Permission.camera.status;
      PermissionStatus status3 = await Permission.microphone.status;
      print('Permission android');

      checkStatus( status2, status3, streamingType, context,
           liveStreamingModel: liveStreamingModel);
    } else if (QuickHelp.isIOSPlatform()) {

      PermissionStatus status2 = await Permission.camera.status;
      PermissionStatus status3 = await Permission.microphone.status;
      print('Permission ios');

      checkStatus( status2, status3, streamingType, context,
          liveStreamingModel: liveStreamingModel);
    } else {
      print('Permission other device');
      _gotoLiveScreen( streamingType, context,
           liveStreamingModel: liveStreamingModel);
    }
  }

  static void checkStatus( PermissionStatus status2,
      PermissionStatus status3,String? streamingType, BuildContext context,
      {LiveStreamingModel? liveStreamingModel}) {
    if ( status2.isDenied || status3.isDenied) {

      QuickHelp.showDialogPermission(
          context: context,
          title: "permissions.photo_access".tr(),
          confirmButtonText: "permissions.okay_".tr().toUpperCase(),
          message: "permissions.photo_access_explain"
              .tr(namedArgs: {"app_name": Setup.appName}),
          onPressed: () async {
            QuickHelp.hideLoadingDialog(context);

            // You can request multiple permissions at once.
            Map<Permission, PermissionStatus> statuses = await [
              Permission.camera,
              Permission.microphone,
            ].request();

            if (statuses[Permission.camera]!.isGranted &&

                statuses[Permission.microphone]!.isGranted) {
              _gotoLiveScreen(streamingType, context,
                  liveStreamingModel: liveStreamingModel);
            }
          });
    } else if (
    status2.isPermanentlyDenied ||
        status3.isPermanentlyDenied) {
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
    } else if ( status2.isGranted && status3.isGranted) {

      _gotoLiveScreen(streamingType, context, liveStreamingModel: liveStreamingModel);
    }


  }

  static _gotoLiveScreen(String? streamingType, BuildContext context,
      {LiveStreamingModel? liveStreamingModel}) async {
    if (Get.find<UserViewModel>().currentUser.getGeoPoint == null) {
      QuickHelp.showDialogLivEend(
        context: context,
        dismiss: true,
        title: 'live_streaming.location_needed'.tr(),
        confirmButtonText: 'live_streaming.add_location'.tr(),
        message: 'live_streaming.location_needed_explain'.tr(),
        onPressed: () async {
          QuickHelp.goBackToPreviousPage(context);
          //QuickHelp.goToNavigator(context, LocationScreen.route, arguments: widget.currentUser);

          UserModel? user = await QuickHelp.goToNavigatorScreenForResult(
              context,
              LocationScreen(
                currentUser: Get.find<UserViewModel>().currentUser,
              ));
          if (user != null) {
            Get.find<UserViewModel>().currentUser = user;
          }
        },
      );
    } else {
      Get.toNamed(
       liveStreamingModel!.getStreamingType==LiveStreamingModel.keyTypeSingleLive ?  AppRoutes.audienceSingleLive :
       liveStreamingModel.getStreamingType==LiveStreamingModel.keyTypeAudioLive ? AppRoutes.audienceAudioLive :
       liveStreamingModel.getStreamingType==LiveStreamingModel.keyTypeMultiGuestLive ? AppRoutes.audienceMultiLive
           : AppRoutes.audienceSingleLive ,

          arguments: liveStreamingModel)?.then((value) => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]));

    }

  }


}