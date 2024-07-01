import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../../parse/LiveStreamingModel.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../../../../../view_model/youtube_controller.dart';
import '../../../../../../view_model/zego_controller.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';
import '../zego_multi_live_view.dart';

class YoutubeView extends StatefulWidget {
  YoutubeView({
    Key? key,
  }) : super(key: key);

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  
  LiveViewModel liveViewModel = Get.find();
  YoutubeController youtubeController = Get.find();
  bool playing = true;
  @override
  void initState() {
    if(liveViewModel.role == ZegoLiveRole.host){
      liveViewModel.youtubePlaying(true);
    }
    Get.find<YoutubeController>().videoId=liveViewModel.liveStreamingModel.getYoutubeVideoId!;

    youtubeController.youtubePlayerController = YoutubePlayerController(
      initialVideoId: liveViewModel.liveStreamingModel.getYoutubeVideoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: liveViewModel.role == ZegoLiveRole.host ? false :  true, // Hides the controls bar

      ),
    );

    if(liveViewModel.role == ZegoLiveRole.host)
    youtubeController.youtubePlayerController.addListener(() {
      if (youtubeController.youtubePlayerController.value.isPlaying) {
        if(playing==false){
          playing=true;
          liveViewModel.youtubePlaying(true);
        }
      } else if (youtubeController.youtubePlayerController.value.isPlaying==false) {
        if(playing==true){
          playing=false;

          liveViewModel.youtubePlaying(false);
        }
      } else {
        // Player is buffering, stopped, or ended
        print('Player is buffering, stopped, or ended.');
      }
    });
    super.initState();
  }

  // void dispose() {
  //   youtubeController.youtubePlayerController.dispose();
  //   youtubeController.youtubePlayerController.removeListener(() { });
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: youtubeController.youtubePlayerController,
        ),
        builder: (context, player) {
          return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.black.withOpacity(0.2),
                            ),
                            child: YoutubePlayer(
                              controller: youtubeController.youtubePlayerController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: const ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent,
                              ),
                              onReady: () {
                                youtubeController.youtubePlayerController.play();
                              },
                            ),),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ValueListenableBuilder<ZegoSDKUser?>(
                          valueListenable: zegoController
                              .liveStreamingManager.hostNoti,
                          builder: (context, host, _) {
                            return ValueListenableBuilder<List<ZegoSDKUser>>(
                                valueListenable: zegoController.liveStreamingManager
                                    .coHostUserListNoti,
                                builder: (context, coHostList, _) {
                                  int length = coHostList.length;
                                  return Column(
                                  children: [
                                  Divider(color: AppColors.grey300, height: 1),
                                  Row(
                                    children: [
                                      Container(
                                        height: 75.h,
                                        width: 75.w,
                                        child: ZegoMultiLiveView(userInfo: host, seat: 0,),
                                      ),
                                      Container(
                                        height: 75.h,
                                        width: 75.w,
                                        child: ZegoMultiLiveView(userInfo: length>=1 ? coHostList[0] : null , seat: 1,),
                                      ),
                                      Container(
                                        height: 75.h,
                                        width: 75.w,
                                        child: ZegoMultiLiveView(userInfo: length>=2 ? coHostList[1] : null , seat: 2,),
                                      ),
                                      Container(
                                        height: 75.h,
                                        width: 75.w,
                                        child: ZegoMultiLiveView(userInfo: length>=3 ? coHostList[2] : null , seat: 3,),
                                      ),
                                      Container(
                                        height: 75.h,
                                        width: 75.w,
                                        child: ZegoMultiLiveView(userInfo: length>=4 ? coHostList[3] : null , seat: 4,),
                                      ),
                                    ],
                                  ),
                                  Divider(color: AppColors.grey300, height: 1),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 75.h,
                                          width: 75.w,
                                          child: ZegoMultiLiveView(userInfo: length>=5 ? coHostList[4] : null , seat: 5,),
                                        ),
                                        Container(
                                          height: 75.h,
                                          width: 75.w,
                                          child: ZegoMultiLiveView(userInfo: length>=6 ? coHostList[5] : null , seat: 6,),
                                        ),
                                        Container(
                                          height: 75.h,
                                          width: 75.w,
                                          child: ZegoMultiLiveView(userInfo: length>=7 ? coHostList[6] : null , seat: 7,),
                                        ),
                                        Container(
                                          height: 75.h,
                                          width: 75.w,
                                          child: ZegoMultiLiveView(userInfo: length>=8 ? coHostList[7] : null , seat: 8,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                          );
                              }
                            );
                        }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      }
    );
  }
}
