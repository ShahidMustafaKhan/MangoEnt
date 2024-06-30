import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';
import 'package:teego/view_model/live_controller.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return
      Positioned.fill(top:0, bottom:0,
      child:
      Obx((){
        if(liveViewModel.backgroundImage.isNotEmpty)
          return Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(liveViewModel.backgroundImage.value)
          ),

          ),);
        return SizedBox();
        }
      ));

  }
}
