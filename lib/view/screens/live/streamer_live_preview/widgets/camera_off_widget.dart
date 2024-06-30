import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/userViewModel.dart';



class CameraOffPreviewWidget extends StatelessWidget {
  final double radius;
  CameraOffPreviewWidget({this.radius=45});

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    UserViewModel userViewModel = Get.find();
    String hostAvatar = userViewModel.currentUser.getAvatar!.url!;
      return Obx((){
        if(liveViewModel.isCameraOn.value==false)
          return Stack(children: [
              Align(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Color(0xffBD8DF4), width: 3)
                    ),
                    child: CircleAvatar(
                      radius: radius.r,
                      backgroundImage: NetworkImage(hostAvatar),
                    ),
                  ),
                       ),

          ]);
        return SizedBox();
        }
      );

  }
}
