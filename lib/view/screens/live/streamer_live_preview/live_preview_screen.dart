import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/language_card.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/live_bottom_card.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/live_view_top_menu.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/room_announcement.dart';
import 'package:teego/view/screens/splash_screen.dart';
import '../../../../view_model/live_controller.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';

class LivePreviewScreen extends StatelessWidget {


  late final CameraController cameraController;

  RxBool cameraReady=false.obs;

  RxBool hideNavigator=false.obs;

  Future<void> initializeCamera() async {
    final cameras =  await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    cameraController.initialize().whenComplete((){

      cameraReady.value=true;

    });
  }

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
        await Future.delayed(const Duration(seconds: 5));
          SystemChrome.restoreSystemUIOverlays();
        });
      LiveViewModel liveViewModel=Get.put(LiveViewModel(ZegoLiveRole.host, null));
      initializeCamera();

      return Scaffold(
        body: Obx(() {
          if(cameraReady.value==true && hideNavigator==false){
            hideNavigator.value=true;
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
          }

          return !cameraReady.value ?  SplashScreen() : Container(
            child: Stack(
              children: [
                Positioned(top:0, bottom:0, child: CameraPreview(cameraController)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      RoomAnnouncementCard(),
                      const SizedBox(height: 16),
                      LiveViewTopMenu(),
                      const SizedBox(height: 4),
                      LanguageCard(),
                      const Spacer(),
                      const LiveBottomCard(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        ),
    );}
}
