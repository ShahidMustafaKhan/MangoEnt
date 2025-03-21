import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:teego/view_model/communityController.dart';
import 'package:teego/view_model/userViewModel.dart';

import '../../../helpers/quick_actions.dart';
import '../../../helpers/quick_help.dart';
import '../../../parse/PostsModel.dart';
import '../../../parse/UserModel.dart';
import '../../../ui/app_bar_reels.dart';
import '../../../utils/colors.dart';
import '../../../utils/colors_hype.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/routes/app_routes.dart';
import '../trending/create/create_post.dart';
import 'feed/videoutils/api.dart';
import 'feed/videoutils/screen_config.dart';
import 'feed/videoutils/video.dart';
import 'feed/videoutils/video_item_config.dart';
import 'feed/videoutils/video_newfeed_screen.dart';


// ignore: must_be_immutable
class ReelsHomeScreen<V extends VideoInfo> extends StatefulWidget {
  static String route = "/home/reels";

  PostsModel? post;
  SharedPreferences? preferences;

  ReelsHomeScreen({this.post, this.preferences});

  @override
  _ReelsHomeScreenState createState() => _ReelsHomeScreenState();
}

class _ReelsHomeScreenState extends State<ReelsHomeScreen>
    with SingleTickerProviderStateMixin
    implements VideoNewFeedApi<VideoInfo> {
  bool hasNotification = false;

  late QueryBuilder<PostsModel> queryBuilder;

  late PreloadPageController _pageController;
  late TabController _tabController;
  CommunityController communityController = Get.find();

  @override
  void initState() {
    QuickHelp.saveCurrentRoute(route: ReelsHomeScreen.route);

    _tabController = TabController(length: 2, vsync: this);
    _pageController = PreloadPageController(keepPage: true);
    communityController.getListVideo();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: GetBuilder<CommunityController>(
          init: communityController,
          builder: (controller) {
            return ToolBarReels(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            showAppBar: true,
            backgroundColor: kTransparentColor,
            centerTitle: true,
            child: reelsVideoWidget(userViewModel.currentUser),
            // leftWidget: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            rightWidgetTwo: Padding(
              padding: EdgeInsets.only(top: 0, right: 0.w),
              child: GestureDetector(
                onTap: () {
                  goToVideoScreen();
                },
                child: Image.asset(AppImagePath.post_logo, width: 42, height: 42),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget initTabs(UserModel? currentUser) {
    return PreloadPageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: 2,
      preloadPagesCount: 2,
      onPageChanged: (page) {
        setState(() {
          _tabController.animateTo(page);
        });
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return reelsVideoWidget(currentUser!, exclusive: false);
        } else {
          return reelsVideoWidget(currentUser! ,exclusive: true);
        }
      },
    );
  }

  Widget reelsVideoWidget(UserModel? currentUser, {bool? exclusive}) {
    return Container(
      color: kContentColorLightTheme,
      child: VideoNewFeedScreen(
        api: this,
        keepPage: true,
        screenConfig: ScreenConfig(
            backgroundColor: kContentColorLightTheme,
            loadingWidget: CircularProgressIndicator.adaptive(),
            emptyWidget: Center(
              child: GestureDetector(
                onTap: () {
                  getListVideo(exclusive: exclusive);
                },
                child: QuickActions.noContentFoundReels(
                  "feed.no_reels_title".tr(),
                  "feed.no_reels_explain".tr(),
                ),
              ),
            )),
        config: VideoItemConfig(
          itemLoadingWidget: CircularProgressIndicator(),
          loop: true,
          autoPlayNextVideo: false,
        ),
        videoEnded: () {},
        pageChanged: (page, user, post) {
          print("Page changed $page, ${user.objectId}, ${post.objectId}");

          setViewer(post, currentUser);
        },
      ),
    );
  }

  setViewer(PostsModel post, UserModel? currentUser) async {
    if (currentUser!.objectId! != post.getAuthor!.objectId!) {
      post.setViewer = currentUser.objectId!;
      post.addView = 1;
      await post.save();
    }
  }

  @override
  Future<List<VideoInfo>> getListVideo({bool? exclusive}) {
    return _loadFeedsVideos(false, isVideo: true);
  }

  @override
  Future<List<VideoInfo>> loadMore(List<VideoInfo> currentList) {
    // TODO: implement loadMore

    print("implement loadMore ${currentList.length}");

    return _loadFeedsVideos(false, skip: currentList.length, isVideo: true);
    //throw UnimplementedError();
  }

  Future<List<VideoInfo>> _loadFeedsVideos(bool? isExclusive,
      {bool? isVideo, int? skip = 0}) async {
    List<VideoInfo> videos = [];

    QueryBuilder<UserModel> queryUsers = QueryBuilder(UserModel.forQuery());
    queryUsers.whereValueExists(UserModel.keyUserStatus, true);
    queryUsers.whereEqualTo(UserModel.keyUserStatus, true);

    queryBuilder = QueryBuilder<PostsModel>(PostsModel());

    queryBuilder.whereValueExists(PostsModel.keyVideo, true);
    queryBuilder.orderByDescending(PostsModel.keyCreatedAt);

    if (widget.post != null) {
      queryBuilder.whereEqualTo(PostsModel.keyObjectId, widget.post!.objectId);
    } else {
      //queryBuilder.whereEqualTo(PostsModel.keyExclusive, isExclusive);
      queryBuilder.whereNotContainedIn(
          PostsModel.keyAuthor, Get.find<UserViewModel>().currentUser.getBlockedUsers!);
      queryBuilder.whereNotContainedIn(
          PostsModel.keyObjectId, Get.find<UserViewModel>().currentUser.getReportedPostIDs!);

      queryBuilder.whereDoesNotMatchQuery(PostsModel.keyAuthor, queryUsers);
      //queryBuilder.setAmountToSkip(skip!);
    }

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
            /*userName: postsModel.getAuthor!.getFullName!,
              liked: postsModel.getLikes!.contains(widget.currentUser!.objectId),
              dateTime: postsModel.createdAt!,
              songName: postsModel.getText,
              likes: postsModel.getLikes,*/
              postModel: postsModel,
              currentUser: Get.find<UserViewModel>().currentUser,
              url: postsModel.getVideo!
                  .url); //"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"); //postsModel.getVideo!.url);

          videos.add(videoInfo);
        }

        return videos;
      } else {
        return [];
      }
    } else {
      return []; //apiResponse.error as dynamic;
    }
  }

  goToVideoScreen() {
    QuickHelp.goToNavigatorScreen(
      context,
      PostScreen(
          0
        // currentUser: widget.currentUser,
        // preferences: widget.preferences,
      ),
    );
  }
}


