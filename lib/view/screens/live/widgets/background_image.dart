import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
      return GetBuilder<LiveViewModel>(
          init: liveViewModel,
          builder: (liveViewModel) {
            if(liveViewModel.backgroundImage!=null)
            return Positioned.fill(top:0, bottom:0,
                child: Container(
                decoration: BoxDecoration(
                 image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(liveViewModel.backgroundImage!.url!)
              ),

              ),));
            else
              return SizedBox();
        }
      );



  }
}
