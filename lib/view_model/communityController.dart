
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../parse/PostsModel.dart';
import '../parse/UserModel.dart';
import '../utils/constants/status.dart';
import '../view/screens/reels/feed/videoutils/api.dart';
import '../view/screens/reels/feed/videoutils/video.dart';



class CommunityController<V extends VideoInfo>  extends GetxController with GetSingleTickerProviderStateMixin {


  RxInt currentPage=0.obs;
  List<VideoInfo> videosList = [];
  List<VideoInfo> following = [];
  late QueryBuilder<PostsModel> queryBuilder;
  late final VideoNewFeedApi<V> api;
  Status status = Status.Loading;
  LiveQuery liveQuery = LiveQuery();
  Subscription? subscription;




  Future<FileInfo?> checkedCacheFor(String url) async {
    final FileInfo? value= await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  Future cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value){
      print('successfully downloaded done for ');
      return value;

    });
  }

  Future<void> getListVideo({bool? exclusive}) async {
     loadFeedsVideo(Get.find<UserViewModel>().currentUser,
        false, isVideo: true);
  }


  Future<void> loadMore(List<VideoInfo> currentList) async {
    // TODO: implement loadMore

    print("implement loadMore ${currentList.length}");

     loadFeedsVideo(Get.find<UserViewModel>().currentUser,false, skip: currentList.length, isVideo: true);
    //throw UnimplementedError();
  }

  Future<void> loadFeedsVideo(UserModel currentUser, bool? isExclusive,
      {bool? isVideo, int? skip = 0, bool updateBuild=true}) async {
    List<VideoInfo> videos = [];

    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);
    // queryUsers..whereStartsWith(PostsModel.keyObjectId, widget.post!.objectId!);

    QueryBuilder<PostsModel> queryBuilder = QueryBuilder<PostsModel>(PostsModel());

    queryBuilder.whereValueExists(PostsModel.keyVideo, true);
    // queryBuilder.w(PostsModel.keyObjectId, widget.post!.objectId!);
    // queryBuilder.whereEqualTo(PostsModel.keyObjectId, widget.post!.objectId!);

    queryBuilder.orderByDescending(PostsModel.keyCreatedAt);


    //queryBuilder.whereEqualTo(PostsModel.keyExclusive, isExclusive);
    queryBuilder.whereNotContainedIn(
        PostsModel.keyAuthor, currentUser.getBlockedUsers!);
    // queryBuilder.whereNotContainedIn(
    //     currentUser.objectId, PostsModel.keyG );

    queryBuilder.whereDoesNotMatchQuery(PostsModel.keyAuthor, queryUsers);
    //queryBuilder.setAmountToSkip(skip!);


    queryBuilder.includeObject([
      PostsModel.keyAuthor,
      PostsModel.keyAuthorName,
      PostsModel.keyLastLikeAuthor,
      PostsModel.keyLastDiamondAuthor
    ]);

    //queryBuilder.setLimit(2);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {

        for (PostsModel postsModel in apiResponse.results!) {

              VideoInfo videoInfo = VideoInfo(
                  postModel: postsModel,
                  currentUser: currentUser,
                  url: postsModel.getVideo!.url,
              );
              videos.add(videoInfo);


        }
        status = Status.Completed;
        videosList = videos;
        if(updateBuild)
        update();


      } else {
        status = Status.Completed;
        videosList = [];
        if(updateBuild)
          update();
      }
    }
    else{
      status = Status.Completed;
      videosList = [];
      if(updateBuild)
        update();
    }

  }


  Future<List<VideoInfo>> profileVideos(UserModel user, bool? isExclusive,
      {bool? isVideo, int? skip = 0, bool updateBuild=true}) async {
    List<VideoInfo> videos = [];

    // queryUsers..whereStartsWith(PostsModel.keyObjectId, widget.post!.objectId!);

    QueryBuilder<PostsModel> queryBuilder = QueryBuilder<PostsModel>(PostsModel());

    queryBuilder.whereValueExists(PostsModel.keyVideo, true);
    // queryBuilder.w(PostsModel.keyObjectId, widget.post!.objectId!);
    // queryBuilder.whereEqualTo(PostsModel.keyObjectId, widget.post!.objectId!);

    queryBuilder.orderByDescending(PostsModel.keyCreatedAt);


    queryBuilder.whereEqualTo(PostsModel.keyAuthorId, user.objectId);

    // queryBuilder.whereNotContainedIn(
    //     currentUser.objectId, PostsModel.keyG );

    //queryBuilder.setAmountToSkip(skip!);

    queryBuilder.includeObject([
      PostsModel.keyAuthor,
      PostsModel.keyAuthorName,
      PostsModel.keyLastLikeAuthor,
      PostsModel.keyLastDiamondAuthor
    ]);

    //queryBuilder.setLimit(2);

    ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success) {
      if (apiResponse.results != null) {

        for (PostsModel postsModel in apiResponse.results!) {

          VideoInfo videoInfo = VideoInfo(
            postModel: postsModel,
            currentUser: Get.find<UserViewModel>().currentUser,
            url: postsModel.getVideo!.url,
          );
          videos.add(videoInfo);


        }

        return videos;

      } else {
        return [];
      }
    }
    else{
      return [];
    }

  }





  @override
  Future<void> onInit() async {
    getListVideo();
    super.onInit();
  }


}

