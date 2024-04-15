import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class GiftViewModel extends GetxController with GetTickerProviderStateMixin {
  String _giftToShow = "";
  SVGAAnimationController? animationController;
  bool playing=false;

  String get giftToShow => _giftToShow;

  set setGiftToShow(String value) {
    _giftToShow = value;
    update();
  }

  set setAnimationController(SVGAAnimationController value) {
    animationController = value;
    update();
  }

  void loadAnimation(String path, String audioPath) async {
    if(playing==true){
      return;
    }
    playing=true;
    final videoItem = await SVGAParser.shared.decodeFromAssets(path);
    playAudio(audioPath);
    animationController!.videoItem = videoItem;
    animationController!.forward().whenComplete((){
      playing=false;
      animationController!.videoItem = null;
    });
  }

  void playAudio(String audioPath) async {
    try {
      AudioPlayer player = AudioPlayer();
      player.play(AssetSource(audioPath));
    } catch (t) {
      log(t.toString());
    }
  }

  GiftViewModel();

  @override
  void onInit() {
    this.animationController = SVGAAnimationController(vsync: this);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    if(this.animationController!=null){
      this.animationController?.dispose();
    }
    // TODO: implement onClose
    super.onClose();
  }
}
