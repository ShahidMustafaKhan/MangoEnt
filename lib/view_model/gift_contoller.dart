import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../utils/constants/app_constants.dart';

class GiftViewModel extends GetxController with GetTickerProviderStateMixin {
  String _giftToShow = "";
  SVGAAnimationController? animationController;
  bool playing=false;
  RxString selectedPath=''.obs;

  List path=[AppImagePath.lamborghini, AppImagePath.bearCastle , AppImagePath.yachtIsland,
    AppImagePath.babyDragon, AppImagePath.hearts, AppImagePath.kissingGift , AppImagePath.motorCycleEntry ];

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
    selectedPath.value = path ;
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

  bool get lamborghiniAnimation{
    return selectedPath.value == path[0];
  }

  bool get bearCastle{
    return selectedPath.value == path[1];
  }

  bool get yachtIsland{
    return selectedPath.value == path[2];
  }

  bool get babyDragon{
    return selectedPath.value == path[3];
  }

  bool get hearts{
    return selectedPath.value == path[4];
  }

  bool get kissingGift{
    return selectedPath.value == path[5];
  }

  bool get motorCycleEntry{
    return selectedPath.value == path[6];
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
