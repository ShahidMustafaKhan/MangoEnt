import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/audio_coHost_view.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/audio_host_view.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/multi_live_view.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/three_multi_guest.dart';
import 'package:teego/view/screens/live/multi_live_streaming/widgets/multi_live_view/youtube_view.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_bottom_bar.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../view_model/youtube_controller.dart';
import '../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../widgets/bottom_card.dart';
import '../streamer_live_preview/audio_live/audio_live_top_bar.dart';


class MultiLiveWidget extends StatelessWidget {

  MultiLiveWidget();


  @override
  Widget build(BuildContext context) {
    final AnimationViewModel animationViewModel = Get.find();
    YoutubeController youtubeController = Get.put(YoutubeController());
    return GetBuilder<LiveViewModel>(builder: (liveViewModel)  {
        return Column(
          children: [
            SizedBox(height: 45),
            AudioLiveTopBar(),
            if(liveViewModel.liveStreamingModel.getYoutube==false)
              MultiGuestView(),
            if(liveViewModel.liveStreamingModel.getYoutube==true)
              Expanded(child: YoutubeView()),
              BottomCard()
          ],
        );
         }
    );
  }
}
