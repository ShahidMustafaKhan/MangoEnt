import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/theme_controller.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'dart:io';
import '../../data/app/setup.dart';
import '../../helpers/quick_help.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../parse/UserModel.dart';


class PermissionHandler{


static Future<void> checkPermission(bool isAvatar, BuildContext context, {bool liveStreamingFile=false}) async {
  if (QuickHelp.isAndroidPlatform()) {
    PermissionStatus status = await Permission.storage.status;
    PermissionStatus status2 = await Permission.camera.status;
    print('Permission android');

    checkStatus(status, status2, isAvatar, context);
  } else if (QuickHelp.isIOSPlatform()) {
    PermissionStatus status = await Permission.photos.status;
    PermissionStatus status2 = await Permission.camera.status;
    print('Permission ios');

    checkStatus(status, status2, isAvatar, context);
  } else {
    print('Permission other device');

    _choosePhoto(isAvatar, context);
  }
}

static void checkStatus(
    PermissionStatus status, PermissionStatus status2, bool isAvatar, BuildContext context, {bool liveStreamingFile=false}) {
  if (status.isDenied || status2.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.

    QuickHelp.showDialogPermission(
        context: context,
        title: "permissions.photo_access".tr(),
        confirmButtonText: "permissions.okay_".tr().toUpperCase(),
        message: "permissions.photo_access_explain"
            .tr(namedArgs: {"app_name": Setup.appName}),
        onPressed: () async {
          QuickHelp.hideLoadingDialog(context);

          //if (await Permission.camera.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          //}

          // You can request multiple permissions at once.
          Map<Permission, PermissionStatus> statuses = await [
            Permission.camera,
            Permission.photos,
            Permission.storage,
          ].request();

          if (statuses[Permission.camera]!.isGranted &&
              statuses[Permission.photos]!.isGranted ||
              statuses[Permission.storage]!.isGranted) {
            _choosePhoto(isAvatar, context);
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
    //_uploadPhotos(ImageSource.gallery);
    _choosePhoto(isAvatar,context);
  }

  print('Permission $status');
  print('Permission $status2');
}

static _choosePhoto(bool isAvatar, BuildContext context, {bool liveStreamingFile=false}) async {

  final List<AssetEntity>? result = await AssetPicker.pickAssets(
    context,
    pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        //gridCount: 3,
        //pageSize: ,
        requestType: RequestType.image,
        filterOptions: FilterOptionGroup(
          containsLivePhotos: false,
        )),
  );

  if (result != null && result.length > 0) {
    final File? image = await result.first.file;
    cropPhoto(image!.path, isAvatar, context);
  } else {
    print("Photos null");
  }
}

static void cropPhoto(String path, bool isAvatar, BuildContext context, {bool liveStreamingFile=false}) async {
  QuickHelp.showLoadingDialog(context);

  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        isAvatar == true ? CropAspectRatioPreset.square : CropAspectRatioPreset.ratio16x9,
      ],
      //maxHeight: 480,
      //maxWidth: 740,
      aspectRatio: isAvatar == true ? CropAspectRatio(ratioX: 4, ratioY: 4) : CropAspectRatio(ratioX: 16, ratioY: 9),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "edit_photo".tr(),
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: isAvatar == true ? CropAspectRatioPreset.square : CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ]);

  if (croppedFile != null) {

    compressImage(croppedFile.path, isAvatar,context);
  } else {
    QuickHelp.hideLoadingDialog(context);
    return;
  }
}

static void compressImage(String path, bool isAvatar, BuildContext context, {bool liveStreamingFile=false}) {

  QuickHelp.showLoadingDialogWithText(context, description: "crop_image_scree.optimizing_image".tr(), useLogo: true);

  Future.delayed(Duration(seconds: 1), () async{
    var result = await QuickHelp.compressImage(path);

    if(result != null){

      liveStreamingFile==true ? uploadLiveStreamingFile(result, isAvatar, context) : uploadFile(result, isAvatar, context);

    } else {

      QuickHelp.hideLoadingDialog(context);

      QuickHelp.showAppNotificationAdvanced(
        context: context,
        title: "crop_image_scree.cancelled_by_user".tr(),
        message: "crop_image_scree.image_not_cropped_error".tr(),
      );
    }
  });
}

static uploadFile(File imageFile, bool isAvatar, BuildContext context) async {
  ParseFileBase? parseFile;

  if(imageFile.absolute.path.isNotEmpty){
    parseFile = ParseFile(File(imageFile.absolute.path), name: "avatar.jpg");
  } else {
    parseFile = ParseWebFile(imageFile.readAsBytesSync(), name: "avatar.jpg");
  }

  if (isAvatar == true) {
    Get.find<UserViewModel>().currentUser.setAvatar = parseFile;
  } else {
    Get.find<UserViewModel>().currentUser.setCover = parseFile;
  }

  ParseResponse parseResponse = await Get.find<UserViewModel>().currentUser.save();

  if(parseResponse.success){
    QuickHelp.hideLoadingDialog(context);
    QuickHelp.hideLoadingDialog(context);
    Get.find<UserViewModel>().currentUser = parseResponse.results!.first as UserModel;
    Get.find<UserViewModel>().updateViewModel() ;

  } else {

    QuickHelp.hideLoadingDialog(context);
    QuickHelp.showAppNotificationAdvanced(
      context: context,
      title: "error".tr(),
      message: "try_again_later".tr(),
    );
  }
}

static uploadLiveStreamingFile(File imageFile, bool isAvatar, BuildContext context) async {
  ParseFileBase? parseFile;

  if(imageFile.absolute.path.isNotEmpty){
    parseFile = ParseFile(File(imageFile.absolute.path), name: "avatar.jpg");
  } else {
    parseFile = ParseWebFile(imageFile.readAsBytesSync(), name: "avatar.jpg");
  }

    Get.find<LiveViewModel>().addParseFile(parseFile);

}


}