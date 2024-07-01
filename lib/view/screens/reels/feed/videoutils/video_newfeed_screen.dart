import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:lottie/lottie.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/status.dart';
import 'package:teego/view/screens/reels/feed/videoutils/screen_config.dart';
import 'package:teego/view/screens/reels/feed/videoutils/video.dart';
import 'package:teego/view/screens/reels/feed/videoutils/video_item.dart';
import 'package:teego/view/screens/reels/feed/videoutils/video_item_config.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

import '../../../../../helpers/quick_help.dart';
import '../../../../../parse/PostsModel.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../view_model/communityController.dart';
import '../../../../../view_model/userViewModel.dart';
import 'api.dart';

class VideoNewFeedScreen<V extends VideoInfo> extends StatefulWidget {
  /// Is case you want to keep the screen
  ///
  final bool keepPage;
  final bool singleReel;
  final PostsModel? post;

  /// Screen config
  final ScreenConfig screenConfig;

  ///
  /// Video Item config
  final VideoItemConfig config;

  final VideoNewFeedApi<V> api;

  /// Video ended callback
  ///
  final void Function()? videoEnded;
  final Function(int page, UserModel user, PostsModel post)? pageChanged;

  //final void Function()? pageChanged;

  /// Video Info Customizable
  ///
  final Widget Function(BuildContext context, V v)? customVideoInfoWidget;

  const VideoNewFeedScreen({
    this.keepPage = false,
    this.singleReel = false,
    this.screenConfig = const ScreenConfig(
      backgroundColor: Colors.black,
      loadingWidget: CircularProgressIndicator(),
    ),

    /// video config
    this.config = const VideoItemConfig(
        loop: true,
        itemLoadingWidget: CircularProgressIndicator(),
        autoPlayNextVideo: true),
    this.customVideoInfoWidget,
    this.videoEnded,
    this.pageChanged,
    required this.api, this.post,
  });

  @override
  State<StatefulWidget> createState() => _VideoNewFeedScreenState();
}

class _VideoNewFeedScreenState <V extends VideoInfo>
    extends State<VideoNewFeedScreen<VideoInfo>> {
  /// PageController
  ///
  //late PageController _pageController;
  late PreloadPageController _pageController;

  /// Current page is on screen
  ///
  int _currentPage = 0;

  /// Page is on turning or off, use to check how much percent the next video will render and play
  ///
  bool _isOnPageTurning = false;

  final _listVideoStream = StreamController<List<VideoInfo>>();

  CommunityController communityController = Get.find();


  /// Temp to update list video data
  ///
  List<V> temps = [];

  void setList(List<V> items) {
    if (!_listVideoStream.isClosed) {
      _listVideoStream.sink.add(items);
    }
  }

  void _notifyDataChanged() => setList(temps);

  /// Check to play next video when user scroll
  /// If the next video appear about 30% (0.7) the next video will play
  ///
  void _scrollListener() {
    if (_isOnPageTurning &&
        _pageController.page == _pageController.page!.roundToDouble()) {
      setState(() {
        _currentPage = _pageController.page!.toInt();
        _isOnPageTurning = false;
      });
    } else if (!_isOnPageTurning &&
        _currentPage.toDouble() != _pageController.page) {
      if ((_currentPage.toDouble() - _pageController.page!).abs() > 0.7) {
        setState(() {
          _isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(keepPage: widget.keepPage);
    _pageController.addListener(_scrollListener);

    _getListVideo();
  }

  void _getListVideo() {
    // if(communityController.videosList.isNotEmpty){
    //   temps.addAll(communityController.videosList);
    //   _notifyDataChanged();
    // }
    // else{
      widget.api.getListVideo().then((value) {
        _notifyDataChanged();
      });
    // }

  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      topSafeArea: true,
      resizeToAvoidBottomInset: false,
      body: _renderVideoPageView(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listVideoStream.close();
    super.dispose();
  }

  /// Page View
  ///
  Widget _renderVideoPageView() {
    return GetBuilder<CommunityController>(
        init: communityController,
        builder: (controller) {
          if(controller.status == Status.Loading && widget.singleReel==false) {
            return Center(
              child: QuickHelp.showLoadingAnimation(),
            );
          }
      if(controller.videosList.isEmpty && widget.singleReel==false) {
        return Center(
          child: widget.screenConfig.emptyWidget ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/no_result.json"),
                  Text("No result.")
                ],
              ),
        );
      }
        return PreloadPageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    itemCount: widget.singleReel==false ? controller.videosList.length : 1,
                    preloadPagesCount: 5,
                    pageSnapping: true,
                    onPageChanged: (page) {
                      UserModel? user = widget.singleReel==false ?  controller.videosList[page].currentUser : Get.find<UserViewModel>().currentUser;
                      PostsModel? post = widget.singleReel==false ? controller.videosList[page].postModel : widget.post;

                      if (widget.pageChanged != null && user != null) {
                        widget.pageChanged!(page, user, post!) as void Function()?;
                      }
                    },
                    itemBuilder: (context, index) {
                      VideoInfo videoInfo = VideoInfo() ;
                      if(widget.singleReel == true)
                        videoInfo = VideoInfo(
                          postModel: widget.post!,
                          currentUser: Get.find<UserViewModel>().currentUser,
                          url: widget.post!.getVideo!.url,
                        );
                      return VideoItemWidget(
                        videoInfo: widget.singleReel == true ? videoInfo : controller.videosList[index],
                        pageIndex: index,
                        singleReel: widget.singleReel,
                        currentPageIndex: _currentPage,
                        isPaused: _isOnPageTurning,
                        config: widget.config,
                        videoEnded: widget.videoEnded,
                        customVideoInfoWidget: widget.customVideoInfoWidget != null
                            ? widget.customVideoInfoWidget!(context, temps[index])
                            : null,
                      );
                    },
                  );

          }
        );
  }
}

