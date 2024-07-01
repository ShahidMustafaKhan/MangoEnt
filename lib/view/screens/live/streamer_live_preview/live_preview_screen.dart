import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/camera_off_widget.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/camera_preview.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/language_card.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/live_bottom_card.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/live_view_top_menu.dart';
import 'package:teego/view/screens/live/streamer_live_preview/widgets/room_announcement.dart';
import 'package:teego/view/screens/splash_screen.dart';
import 'package:teego/view/widgets/base_scaffold.dart';
import 'package:teego/view_model/cameraController.dart';
import '../../../../utils/theme/colors_constant.dart';
import '../../../../view_model/live_controller.dart';
import '../widgets/background_image.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'audio_live/audio_preview.dart';
import 'game/game_live_preview_screen.dart';
import 'multiguest/widgets/multi_live_preview.dart';
import 'multiguest/widgets/three_multi_guest_preview.dart';

class LivePreviewScreen extends StatelessWidget {

  late final CameraController cameraController;

  RxBool cameraReady=false.obs;

  RxBool hideNavigator=false.obs;

  Future<void> initializeCamera() async {
    if(cameraReady.value == false){
      final cameras = await availableCameras();
      cameraController = CameraController(cameras[1], ResolutionPreset.medium);
      cameraController.initialize().whenComplete(() {
        cameraReady.value = true;
      });

  }}


  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
        await Future.delayed(const Duration(seconds: 5));
          SystemChrome.restoreSystemUIOverlays();
        });
      initializeCamera();
      LiveViewModel liveViewModel=Get.put(LiveViewModel(ZegoLiveRole.host, null));


      return BaseScaffold(
        safeArea: true,
        body: Obx(() {
          if(cameraReady.value==true && hideNavigator.value==false){
            hideNavigator.value=true;
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
          }
          return  Container(
            child: Stack(
              children: [
                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.multiLiveIndex] || liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.gameLiveIndex] || liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                  Positioned.fill(top:0, bottom:0, child: Container(decoration: BoxDecoration( gradient: LinearGradient(
                    begin: Alignment(-1.656, -6.337),
                    end: Alignment(-0.583, -1.589),
                    colors: <Color>[Color(0xFFA036FF), Color(0xFF3B0073)],
                    stops: <double>[0, 1],
                  ),),)),
                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.audioLiveIndex])
                  Positioned.fill(top:0, bottom:0, child: Container(color: Color(0xFF12323A),)),
                BackgroundImage(),
                  if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                    !cameraReady.value ?  Container(color: Colors.black) : CameraPreviewWidget(cameraController),
                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                  CameraOffPreviewWidget(),

                if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.gameLiveIndex])
                  GameLivePreviewScreen(),
                if(liveViewModel.selectedLiveType.value!=liveViewModel.bottomTab[liveViewModel.gameLiveIndex])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      RoomAnnouncementCard(),
                      const SizedBox(height: 16),
                      LiveViewTopMenu(cameraController: cameraReady.value==true ? cameraController : null,),
                      const SizedBox(height: 4),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.audioLiveIndex])
                      Expanded(child: AudioEmptyPreview()),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                      LanguageCard(),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.singleLiveIndex])
                        Spacer(),
                      if(liveViewModel.selectedLiveType.value==liveViewModel.bottomTab[liveViewModel.multiLiveIndex] )
                        Expanded(child: MultiGuestPreview(cameraController: cameraController,)),
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
