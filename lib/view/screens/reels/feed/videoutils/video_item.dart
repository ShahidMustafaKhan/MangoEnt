import 'dart:math';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/colors_hype.dart';
import 'package:teego/view/screens/reels/feed/videoutils/video.dart';
import 'package:teego/view/screens/reels/feed/videoutils/video_item_config.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../helpers/quick_help.dart';
import 'default_video_info.dart';

class VideoItemWidget<V extends VideoInfo> extends StatefulWidget {
  final int pageIndex;
  final int currentPageIndex;
  final bool isPaused;
  final bool singleReel;


  /// Video ended callback
  ///
  final void Function()? videoEnded;

  final VideoItemConfig config;

  /// Video Information: like count, like, more, name song, ....
  ///
  final V videoInfo;

//  /// Video network url
//  ///
//  final String url;

  /// Video Info Customizable
  ///
  final Widget? customVideoInfoWidget;

  const VideoItemWidget(
      {

        /// video information
        required this.videoInfo,
        this.singleReel = false,

        /// video config
        this.config = const VideoItemConfig(
            loop: true,
            itemLoadingWidget: CircularProgressIndicator(),
            autoPlayNextVideo: true),
        required this.pageIndex,
        required this.currentPageIndex,
        required this.isPaused,
        this.customVideoInfoWidget,
        this.videoEnded});

  @override
  State<StatefulWidget> createState() => _VideoItemWidgetState<V>();
}

class _VideoItemWidgetState<V extends VideoInfo>
    extends State<VideoItemWidget<V>> {
  late CachedVideoPlayerController? _videoPlayerController;
  bool initialized = false;
  bool actualDisposed = false;
  bool isEnded = false;

  bool isPauseClicked = false;
  bool isBuffering = false;
  bool isVideoPlaying = false;

  ///
  ///
  @override
  void initState() {
    super.initState();
    if(widget.currentPageIndex == 0 && widget.pageIndex == 0)
      isBuffering=true;

    _initVideoController();
  }

  ///
  ///
  @override
  Widget build(BuildContext context) {
    bool isLandscape = false;
    _pauseAndPlayVideo();
    if (initialized && _videoPlayerController!.value.isInitialized) {
      isLandscape = _videoPlayerController!.value.size.width >
          _videoPlayerController!.value.size.height;
    }

    return GestureDetector(
      onTap: playAndPayBtn,
      child: Center(
        child: Stack(
          children: [
            initialized
                ? isLandscape
                ? _renderLandscapeVideo()
                : _renderPortraitVideo()
                :
            Stack(
              children: [
                if(widget.videoInfo.postModel!.getVideoThumbnail!=null)
                Center(
                  child: QuickActions.getVideoPlaceHolder(
                    widget.videoInfo.postModel!.getVideoThumbnail!.url!,
                    adaptive: true,
                    showLoading: false,
                  ),
                ),
              ],
            ),
            _renderVideoInfo(),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: VideoProgressIndicator(
            //     _videoPlayerController!,
            //     allowScrubbing: true,
            //     padding: EdgeInsets.only(top: 5),
            //     colors: VideoProgressColors(
            //         backgroundColor: Colors.white.withOpacity(0.3),
            //         bufferedColor: Colors.white.withOpacity(0.5),
            //         playedColor: Colors.white
            //     ),
            //   ),
            // ),
            Visibility(
              visible: isBuffering && !isVideoPlaying,
              child: QuickHelp.showLoadingAnimation(),
            ),
            Visibility(
              visible: getPlayAndPauseBtn(),
              child: Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white.withOpacity(0.5),
                  size: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void playAndPayBtn() {

    setState(() {
      print("Play and pause clicked");
      if (widget.pageIndex == widget.currentPageIndex) {
        isPauseClicked = true;

        if (initialized &&
            _videoPlayerController != null &&
            _videoPlayerController!.value.isPlaying) {
          _videoPlayerController?.pause().then((value) {});
        } else if (initialized &&
            _videoPlayerController != null &&
            !_videoPlayerController!.value.isPlaying) {
          _videoPlayerController?.play().then((value) {});
        }
      } else {
        isPauseClicked = false;
      }
    });
  }

  bool getPlayAndPauseBtn() {
    if (isPauseClicked &&
        !_videoPlayerController!.value.isPlaying &&
        _videoPlayerController!.value.isInitialized) {
      return true;
    } else {
      return false;
    }
  }

  ///
  ///
  @override
  void dispose() {
    if (initialized && _videoPlayerController != null) {
      _videoPlayerController!.removeListener(_videoListener);
      _videoPlayerController!.dispose();
      _videoPlayerController = null;
    }

    actualDisposed = true;
    super.dispose();
  }

  /// Video initialization
  ///
  Future<void> _initVideoController() async {
    if (widget.videoInfo.url == null) return;


    if(widget.videoInfo.file!=null){
      _videoPlayerController = CachedVideoPlayerController.file(
        widget.videoInfo.file,
      );
      _videoPlayerController!.addListener(_videoListener);
      _videoPlayerController!.initialize().then((_) {
        if (!mounted) return;
        print('video player initialized ${widget.currentPageIndex} fileInfo in cache');


        setState(() {
          _videoPlayerController!.setLooping(widget.config.loop);
          initialized = true;
        });
      });
    }
    else{

      final fileInfo= await checkedCacheFor(widget.videoInfo.url!);
      if(fileInfo==null){
        _videoPlayerController = CachedVideoPlayerController.network(
          widget.videoInfo.url!,
        );
        _videoPlayerController!.addListener(_videoListener);
        _videoPlayerController!.initialize().then((_) {
          if (!mounted) return;
          cachedForUrl(widget.videoInfo.url!);

          setState(() {
            _videoPlayerController!.setLooping(widget.config.loop);
            initialized = true;
          });
        });
      }
      else {
        final file= fileInfo.file;
        _videoPlayerController = CachedVideoPlayerController.file(
          file,
        );
        _videoPlayerController!.addListener(_videoListener);
        _videoPlayerController!.initialize().then((_) {
          if (!mounted) return;
          print('video player initialized ${widget.currentPageIndex} fileInfo in cache');

          setState(() {
            _videoPlayerController!.setLooping(widget.config.loop);
            initialized = true;
          });
        });
      }}
  }

  Future<FileInfo?> checkedCacheFor(String url) async {
    final FileInfo? value= await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  Future<void> cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value){
      print('successfully downloaded done for ${widget.currentPageIndex}');
    });
  }

  /// Video controller listener

  void _videoListener() {
    if (!initialized) return;

    if (widget.pageIndex == widget.currentPageIndex &&
        _videoPlayerController!.value.isBuffering) {
      // if (!isBuffering) {
        setState(() {
          isBuffering = true;
          isVideoPlaying = false;
        });

        print("This video is isBuffering: ${widget.videoInfo.url!}");
      // }
    } else if (widget.pageIndex == widget.currentPageIndex &&
        _videoPlayerController!.value.isPlaying) {
      if (!isVideoPlaying) {
        setState(() {
          isVideoPlaying = true;
          isBuffering = false;
        });

        print("This video is isPlaying: ${widget.videoInfo.url!}");
      }
    }

    if (_videoPlayerController?.value.position != null &&
        _videoPlayerController?.value.duration != null) {
      /// check if video has ended
      ///
      if (_videoPlayerController!.value.position >=
          _videoPlayerController!.value.duration) {
        if (widget.config.autoPlayNextVideo &&
            widget.videoEnded != null &&
            !isEnded) {
          isEnded = true;
          widget.videoEnded!();
        }
      }
    }
  }

  void _pauseAndPlayVideo() {
    if (initialized && _videoPlayerController != null) {
      if (widget.pageIndex == widget.currentPageIndex &&
          !widget.isPaused &&
          initialized) {
        if (isPauseClicked) {
          return;
        }
        _videoPlayerController?.play().then((value) {});
      } else {
        _videoPlayerController?.pause().then((value) {});
      }
    }
  }

  Widget _renderLandscapeVideo() {
    if (!initialized) return Container();
    if (_videoPlayerController == null) return Container();
    return Center(
      child: AspectRatio(
        child: VisibilityDetector(
            child: CachedVideoPlayer(_videoPlayerController!),
            onVisibilityChanged: _handleVisibilityDetector,
            key: Key('key_${widget.currentPageIndex}')),
        aspectRatio: _videoPlayerController!.value.aspectRatio,
      ),
    );
  }

  Widget _renderPortraitVideo() {
    if (!initialized) return Container();
    if (_videoPlayerController == null) return Container();

    var tmp = MediaQuery.of(context).size;

    var screenH = max(tmp.height, tmp.width);
    var screenW = min(tmp.height, tmp.width);
    tmp = _videoPlayerController!.value.size;

    var previewH = max(tmp.height, tmp.width);
    var previewW = min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return Center(
      child: OverflowBox(
        child: VisibilityDetector(
            onVisibilityChanged: _handleVisibilityDetector,
            key: Key('key_${widget.currentPageIndex}'),
            child: CachedVideoPlayer(_videoPlayerController!)),
        maxHeight: screenRatio > previewRatio
            ? screenH
            : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio
            ? screenH / previewH * previewW
            : screenW,
      ),
    );
  }

  Widget _renderVideoInfo() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h,
      child: widget.customVideoInfoWidget != null
          ? widget.customVideoInfoWidget
          : DefaultVideoInfoWidget(
        /*name: widget.videoInfo.userName,
              time: widget.videoInfo.dateTime,
              liked: widget.videoInfo.liked,
              text: widget.videoInfo.songName,
              likes: widget.videoInfo.likes,*/
        postModel: widget.videoInfo.postModel,
        currentIndex: widget.currentPageIndex,
        singleReel: widget.singleReel,
      ),
    );
  }

  void _handleVisibilityDetector(VisibilityInfo info) {

    var visiblePercentage = info.visibleFraction * 100;

    if(widget.currentPageIndex == widget.pageIndex && _videoPlayerController != null && !actualDisposed){

      if(visiblePercentage == 0.0){
        print("CHECK VIDEO STATE VISIBLE $visiblePercentage");
        // _videoPlayerController?.pause().then((value) {});
      } else {
        _videoPlayerController?.play().then((value) {
          setState(() {});
          print("CHECK VIDEO STATE INVISIBLE");
        });
      }

    }
    else if(_videoPlayerController != null && !actualDisposed && !widget.isPaused) {
      _videoPlayerController?.pause().then((value) {});
    }
  }


}

