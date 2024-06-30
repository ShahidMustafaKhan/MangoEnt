import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/audio_coHost_view.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/audio_host_view.dart';
import 'package:teego/view_model/animation_controller.dart';
import 'package:teego/view_model/live_controller.dart';
import '../../../../view_model/whisper_list_controller.dart';
import '../widgets/bottom_card.dart';
import '../widgets/audio_live_top_bar.dart';
import '../widgets/chat_text_field.dart';


class AudioLiveWidget extends StatelessWidget {

  AudioLiveWidget();


  @override
  Widget build(BuildContext context) {
    final AnimationViewModel animationViewModel = Get.find();
    WhisperListViewModel whisperListViewModel = Get.put(WhisperListViewModel());
    return GetBuilder<LiveViewModel>(builder: (liveViewModel)  {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 45),
                  AudioLiveTopBar(),
                  AudioHostView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  AudioCoHostView(),
                  BottomCard()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx((){
                if(liveViewModel.chatField.value==true)
                  return ChatTextField();
                else
                  return SizedBox();
              }),
            )

          ],
        );
         }
    );
  }
}
