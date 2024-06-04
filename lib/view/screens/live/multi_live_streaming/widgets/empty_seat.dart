import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/multi_guest_grid_controller.dart';
import '../../../../../../../view_model/zego_controller.dart';
import '../../../../../parse/LiveStreamingModel.dart';
import '../../../../../utils/theme/colors_constant.dart';



class EmptySeatMultiLive extends StatelessWidget {
  final int seat;
  EmptySeatMultiLive(this.seat);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    GridController gridController = Get.find();
    if(liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiThreeSeat && liveViewModel.liveStreamingModel.getYoutube == false)
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.2),
      ),
      child: Icon(Icons.add, size: 32.w,),
    );
    else
      if(gridController.isExpanded.value)
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.2),
              border: !liveViewModel.isMultiSeat6 ? Border.all(color: AppColors.grey300) : null),
          child: Center(
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey300,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                  color: AppColors.black.withOpacity(0.2),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 24.sp,
                    color: AppColors.grey300,
                  ),
                ),
              )),
        );
      if(liveViewModel.liveStreamingModel.getYoutube == true)
        if(seat < 5)
        return Container(
          height: 75.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.3),
              border: Border(
                right: BorderSide(color: AppColors.grey300)
              ),
        ),
          child: Center(
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey300,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                  color: AppColors.black.withOpacity(0.2),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 24.sp,
                    color: AppColors.grey300,
                  ),
                ),
              )),
        );
      else
        return  Container(
          height: 75.h,
          width: 75.w,
          decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.3),
              border: Border.all(color: AppColors.grey300)),
          child: Center(
              child:
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey300,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                  color: AppColors.black.withOpacity(0.2),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 24.sp,
                    color: AppColors.grey300,
                  ),
                ),
              )
          ),
        );
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.2),
            border: liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiNineSeat || liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiTwelveSeat ?
            Border.all(color: AppColors.grey300) : Border(
                right: BorderSide(
                    color: liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiSixSeat && (seat==3 || seat==4) ?
                    AppColors.grey300 : Colors.transparent,
                    width: 1.0)),
        ),
        child: Center(
            child:
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color:AppColors.grey300,
                  width: 1.0,
                ),
                shape: BoxShape.circle,
                color: AppColors.black.withOpacity(0.2),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 24.sp,
                  color: AppColors.grey300,
                ),
              ),
            )

        ),
      );
  }
}
