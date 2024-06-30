import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';



class CameraPreviewWidget extends StatelessWidget {
  final CameraController cameraController;
  CameraPreviewWidget(this.cameraController);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    UserViewModel userViewModel = Get.find();
    String hostAvatar = userViewModel.currentUser.getAvatar!.url!;
    return Obx((){
      if(liveViewModel.isCameraOn.value==true)
        return Positioned(top:0, bottom:0, child: CameraPreview(cameraController));
      return SizedBox();
    }
    );

  }
}
