
import 'dart:convert';

import 'package:get/get.dart' hide Response;
import 'package:teego/utils/constants/status.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/youtube_model.dart';
import 'package:http/http.dart' as http;




class YoutubeController extends GetxController with GetTickerProviderStateMixin
{

  final String apiKey = 'AIzaSyDyXATBFYqD_n-LzY6vWLyontNvw88VaLw';
  final String baseUrl = 'https://www.googleapis.com/youtube/v3/search';
  Status status = Status.Loading;
  late YoutubePlayerController youtubePlayerController;
  YouTubeSearchResult? youTubeSearchResult;
  List<YouTubeVideo>? youtubeVideoList;
  String videoId='';

  Future<void> fetchYouTubeVideos(String query) async {
    status = Status.Loading;
    update();
    final response = await http.get(
      Uri.parse('$baseUrl?key=$apiKey&q=$query&type=video&part=snippet'),
    );

    if (response.statusCode == 200) {
      youTubeSearchResult = YouTubeSearchResult.fromJson(json.decode(response.body));
      youtubeVideoList = youTubeSearchResult!.items;
      status = Status.Completed;
      update();
    } else {
      throw Exception('Failed to load videos');
    }
  }


  YoutubeController();


  @override
  void onInit() {
    fetchYouTubeVideos("Top English Song");
    super.onInit();
  }

  @override
  void onClose() {
    youtubePlayerController.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}

