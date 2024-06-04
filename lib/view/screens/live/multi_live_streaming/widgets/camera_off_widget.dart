import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/multi_guest_grid_controller.dart';
import '../../../../../utils/theme/colors_constant.dart';



class CameraOffWidget extends StatelessWidget {
  final ZegoSDKUser user;
  final int seat;
  CameraOffWidget(this.seat, this.user);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    GridController gridController = Get.find();
    bool expandedCoHost = seat == gridController.seat ;
    bool expanded = gridController.isExpanded.value && !expandedCoHost;
    bool seat4 = liveViewModel.isMultiSeat4 && gridController.isExpanded.value==false;
    bool seat6 = liveViewModel.isMultiSeat6 && gridController.isExpanded.value==false;
    bool seat9 = liveViewModel.isMultiSeat9  && gridController.isExpanded.value==false;
    bool seat9Expanded = liveViewModel.isMultiSeat9  && gridController.isExpanded.value==true;
    bool seat12 =  liveViewModel.isMultiSeat12  && gridController.isExpanded.value==false;
    bool coHost = seat != 0 && gridController.isExpanded.value==false;
    bool host = seat == 0 ;
    String hostAvatar = liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!;
    if(liveViewModel.liveStreamingModel.getYoutube == false)
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border:  !seat9 && !seat9Expanded && !seat12 ? Border(
              right: BorderSide(color: seat4 && !host ? Colors.transparent : AppColors.grey300),
              bottom: BorderSide(color: seat6 ? AppColors.grey300 : Colors.transparent)
          ): Border.all(color: AppColors.grey300),
        ),
        child: Stack(children: [
          if(seat !=0)
          Align(
              child: ValueListenableBuilder<String?>(
                  valueListenable: user.avatarUrlNotifier,
                  builder: (context, url, _) {
                    if(url!=null)
                      return Padding(
                        padding: EdgeInsets.only(bottom: expanded ? 12.0 : 0),
                        child: CircleAvatar(
                         radius: expanded ? seat9Expanded ? 13.r : 10 :
                         coHost ? seat4 ? 14.r : seat6 ? 16.r : seat9 ? 17.r  :  seat12 ? 16.r :25.r :
                         seat6 ? 33 :
                         seat9 ? 17.r :
                         seat12 ? 16.r : 35,
                        backgroundImage: NetworkImage( user.avatarUrlNotifier.value!),
                     ),
                      );
                    else
                      return SizedBox();
                  }
              )),

          if(seat ==0)
            Align(
                child: Padding(
                          padding: EdgeInsets.only(bottom: expanded ? 12.0 : 0),
                          child: CircleAvatar(
                            radius: expanded ? seat9Expanded ? 13.r : 10 :
                            coHost ? seat4 ? 14.r : seat6 ? 16.r : seat9 ? 17.r  :  seat12 ? 16.r :25.r :
                            seat6 ? 33 :
                            seat9 ? 17.r :
                            seat12 ? 16.r : 35,
                            backgroundImage: NetworkImage(hostAvatar),
                          ),
                        ),
                     ),

        ]),
      );
    else
      if(seat != 0)
      return ValueListenableBuilder<String?>(
        valueListenable: user.avatarUrlNotifier,
        builder: (context, url, _) {
          if(url!=null)
            return Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: AppColors.grey300)
                ),
              ),
              child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundImage: NetworkImage( user.avatarUrlNotifier.value!),
                ),
              ),),
            );
          else
            return SizedBox();
      }
        );
      else
        return Container(
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: AppColors.grey300)
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CircleAvatar(
                        radius: 10.r,
                        backgroundImage: NetworkImage( hostAvatar),
                      ),
                    ),),
                );

  }
}
