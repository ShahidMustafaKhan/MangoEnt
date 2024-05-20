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
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'multiguest/widgets/three_live_widget.dart';

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
          if(cameraReady.value==true && hideNavigator.value==false){
            hideNavigator.value=true;
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
          }
          return !cameraReady.value ?  SplashScreen() : Container(
            child: Stack(
              children: [
                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.multiLiveIndex])
                  Positioned.fill(top:0, bottom:0, child: Container(color: AppColors.darkPurple,)),
                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                Positioned(top:0, bottom:0, child: CameraPreview(cameraController)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      RoomAnnouncementCard(),
                      const SizedBox(height: 16),
                      LiveViewTopMenu(),
                      const SizedBox(height: 4),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                      LanguageCard(),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                        Spacer(),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.multiLiveIndex])
                        Expanded(child: ThreeLiveWidget(cameraController: cameraController,)),
                      LiveBottomCard(liveViewModel),
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
