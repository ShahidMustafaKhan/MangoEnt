
import 'dart:convert';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../parse/MusicModel.dart';



class MusicController extends GetxController {

  late Audio audioModel;
  List<MusicModel> audioList = [];

  RxInt length = 0.obs;
  RxString selectedAudioName = ''.obs;

  RxDouble progressValue = 0.0.obs;
  RxInt secondsRemaining = 0.obs;
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();
  bool isMusicSelected=false;
  String selectedMusicURL='';



  List<RxBool> itemPressed = List.generate(15, (index) => false.obs);
  List<RxBool> isPlaying = List.generate(15, (index) => false.obs);


  void toggleItemPressed(int index) {
    for (int i = 0; i < itemPressed.length; i++) {
      if (i == index) {
        itemPressed[index].value = !itemPressed[index].value;
      }
      else {
        itemPressed[i].value = false;
      }
    }

  }

  void togglePlayItemPressed(int index) {
    for (int i = 0; i < isPlaying.length; i++) {
      if (i == index) {
        isPlaying[index].value = !isPlaying[index].value;
      }
      else {
        isPlaying[i].value = false;
      }
      update();
    }
  }

  Future<void> loadAudio(String url) async {
    await player.setUrl(url);  //load a url in audio player
  }

  Future<void> loadAudio2(String url) async {
    await player.setUrl(url);  //load a url in audio player
  }

  Future<void> playMusic()  async {

    await player.setLoopMode(LoopMode.all);
    await player.play();
  }

  Future<void> stopMusic()  async {
    await player.stop();
  }


  @override
  void onInit() {

    init();

    super.onInit();
  }

  Future<void> init() async {
    audioList = await getAudioData();
  }


  static Future<List<MusicModel>> getAudioData() async {
    List<MusicModel> audios = [];

    QueryBuilder<MusicModel> queryBuilder = QueryBuilder<MusicModel>(
        MusicModel());
    queryBuilder.orderByDescending(MusicModel.keyCreatedAt);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {
        // Iterate through the fetched results
        for (MusicModel musicModel in apiResponse.results!) {
          audios.add(musicModel);
        }

        return audios;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<void> _playMusic()  async {

    // await player.set(LoopMode.all);
    await player.play();
  }

  Future<void> _stopMusic()  async {
    await player.stop();
  }



  @override
  void onClose() {
    player.stop();
    player.dispose();
    player2.stop();
    player2.dispose();
    super.onClose();
  }
}
