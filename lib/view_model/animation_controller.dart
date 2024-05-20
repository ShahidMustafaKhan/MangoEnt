
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart' hide Response;
import 'package:lottie/lottie.dart';

import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';
import '../utils/constants/app_constants.dart';


class AnimationViewModel extends GetxController with GetTickerProviderStateMixin
    {

  List<Uint8List?> pkAnimationBuffers=[];
  List<dynamic> pkAnimationsList = [];
  RxString appDocumentsPath = ''.obs;

  late SVGAAnimationController indexAnimationController;
  late AnimationController loseAnimationController;
  late AnimationController winAnimationController;
  late AnimationController drawAnimationController;


  Future<void> runAnimation(AnimationController controller, Function() whenComplete, {bool repeat=false} ) async {
    controller
        .duration = const Duration(milliseconds: 600);
     if(repeat==false){
       controller.forward().whenComplete(() {
         whenComplete();
       });
     }
     else{
       controller.repeat().whenComplete(() {
         whenComplete();
       });
     }
  }

  void loadSvgaAnimation(SVGAAnimationController controller, String path) async {
    final videoItem = await SVGAParser.shared.decodeFromAssets(path);
    controller.videoItem = videoItem;
  }

  void runSvgaAnimation(SVGAAnimationController controller, Function() whenComplete, {bool repeat=false}){
    if(repeat==false) {
      controller.forward().whenComplete(() {
        whenComplete();
      });
    }
    else{
      controller.repeat().whenComplete(() {
        whenComplete();
      });
    }
  }


  void loadBattleAnimation(){
    loadIndexAnimation();
  }


  void loadIndexAnimation(){
    loadSvgaAnimation(indexAnimationController, AppImagePath.indexAnimation);
  }

  void runIndexAnimation(){
    runSvgaAnimation(indexAnimationController, (){}, repeat: true);
  }

  void runWinAnimation(Function() whenComplete){
    runAnimation(winAnimationController, whenComplete, repeat: true);
  }

  void runLoseAnimation(Function() whenComplete){
    runAnimation(loseAnimationController, whenComplete, repeat: true);
  }

  void runDrawAnimation(Function() whenComplete){
    runAnimation(drawAnimationController, whenComplete, repeat: true);
  }

  void resetWinAnimation(Function() whenComplete){
    winAnimationController.reset();
  }

  void resetLoseAnimation(Function() whenComplete){
    loseAnimationController.reset();
  }

  void resetDrawAnimation(Function() whenComplete){
    drawAnimationController.reset();
  }

  void resetJsonAnimationsController(){
    this.loseAnimationController.reset();
    this.winAnimationController.reset();
    this.drawAnimationController.reset();
  }

  void resetAllAnimationsController(){
    this.indexAnimationController.videoItem=null;
    this.loseAnimationController.reset();
    this.winAnimationController.reset();
    this.drawAnimationController.reset();
  }


  AnimationViewModel();


  @override
  void onInit() {
    this.indexAnimationController = SVGAAnimationController(vsync: this);
    this.loseAnimationController = AnimationController(vsync: this);
    this.winAnimationController = AnimationController(vsync: this);
    this.drawAnimationController = AnimationController(vsync: this);
      super.onInit();
    }
  }

