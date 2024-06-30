import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_cropper/image_cropper.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../helpers/quick_actions.dart';
import '../helpers/quick_help.dart';
import '../parse/UserModel.dart';
import '../utils/theme/colors_constant.dart';

class ReportController extends GetxController {
  
  UserModel? mUser;

  var uploadPhoto;
 


  choosePhotoFromGallery(BuildContext context, {bool upload=false}) async {

    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          filterOptions: FilterOptionGroup(
            containsLivePhotos: false,
          )),
    );

    if (result != null && result.length > 0) {
      final File? image = await result.first.file;
      cropPhoto(image!.path, context, upload: upload);
    } else {
      print("Photos null");
    }
  }

  void cropPhoto(String path, BuildContext context, {bool upload=false}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "edit_photo".tr(),
              toolbarColor: AppColors.navBarColor,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]);

    if (croppedFile != null) {
      compressImage(croppedFile.path, context, upload: upload);
    }
  }

  void compressImage(String path, BuildContext context, {bool upload=false}) {

    // QuickHelp.showLoadingAnimation();

    Future.delayed(Duration(seconds: 1), () async{
      var result = await QuickHelp.compressImage(path);

      if(result != null){

        uploadFile(result, upload: upload);

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



  uploadFile(File imageFile, {bool upload=false}) async {

    // if(imageFile.absolute.path.isNotEmpty){
    //   parseFile = ParseFile(File(imageFile.absolute.path), name: "avatar.jpg");
    //
    //   //print("Image path ${imageFile.absolute.path}");
    //
    //   setState(() {
    //     uploadPhoto = imageFile.absolute.path;
    //   });
    //
    // } else {

    // if(upload==true){
      uploadPhoto = await imageFile.readAsBytes();
      update();
  // }
    // else{
    //   parseFile = ParseWebFile(imageFile.readAsBytesSync(), name: "avatar.jpg");
    //   if (parseFile != null) {
    //     saveMessage(
    //         MessageModel.messageTypePicture,
    //         messageType:
    //         MessageModel.messageTypePicture,
    //         pictureFile: parseFile, onTap: () {  });
    //     // QuickHelp.hideLoadingDialog(context);
    //     parseFile = null;
    //     uploadPhoto = null;
    //     update();
    //     // Navigator.of(context).pop();
    //   }
    // }


    // }

    // QuickHelp.showLoadingDialog(context);
    //
    // ParseResponse parseResponse = await parseFile!.save();
    // if (parseResponse.success) {
    //   QuickHelp.hideLoadingDialog(context);
    // } else {
    //   QuickHelp.showLoadingDialog(context);
    //   QuickHelp.showAppNotification(
    //       context: context, title: parseResponse.error!.message);
    //
    // }
  }



  ReportController(this.mUser);


  @override
  void onInit() {
    mUser=this.mUser;
    super.onInit();
  }
}
