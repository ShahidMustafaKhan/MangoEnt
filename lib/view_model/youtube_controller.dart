
import 'dart:convert';

import 'package:get/get.dart' hide Response;

import '../model/youtube_model.dart';
import 'package:http/http.dart' as http;




class YoutubeController extends GetxController with GetTickerProviderStateMixin
{

  final String apiKey = 'AIzaSyDyXATBFYqD_n-LzY6vWLyontNvw88VaLw';
  final String baseUrl = 'https://www.googleapis.com/youtube/v3/search';

  Future<YouTubeSearchResult> fetchYouTubeVideos(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?key=$apiKey&q=$query&type=video&part=snippet'),
    );

    if (response.statusCode == 200) {
      return YouTubeSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load videos');
    }
  }


  YoutubeController();


  @override
  void onInit() {
    super.onInit();
  }
}

