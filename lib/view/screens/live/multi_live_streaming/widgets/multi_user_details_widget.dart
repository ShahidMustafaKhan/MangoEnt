import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/main.dart';
import 'package:teego/parse/LiveStreamingModel.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';
import 'package:teego/view_model/live_controller.dart';
import 'package:teego/view_model/multi_guest_grid_controller.dart';
import '../../../../../../../view_model/zego_controller.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';



class MultiUserDetails extends StatelessWidget {
  final ZegoSDKUser user;
  final int index;
  MultiUserDetails(this.user, this.index);

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    GridController gridController = Get.find();
    bool seats12 = liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiTwelveSeat;
    bool seats9 = liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiNineSeat;
    bool seats6 = liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiSixSeat;
    bool seats4 = liveViewModel.liveStreamingModel.getMultiSeats == LiveStreamingModel.keyTypeMultiFourSeat;
    int selectedIndex = gridController.seat ?? -1 ;
    bool isExpanded = gridController.isExpanded.value && index != selectedIndex;
    return Obx(() {
      isExpanded = gridController.isExpanded.value && index != selectedIndex;
      if(liveViewModel.liveStreamingModel.getYoutube == false)
        return Stack(
          children: [
            Positioned(
              top: isExpanded ? 7 : 10,
              left: isExpanded ? 5.5 : 8,
              child: Visibility(
                visible: index == 0,
                child: Container(
                  width: isExpanded ? 16.w : 24.w,
                  height: isExpanded ? 16.h : 24.h,
                  child: Image.asset(
                    AppImagePath.multiGuestNumberIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: isExpanded ? 7 : 10,
              left: isExpanded ? 5.5 : 8,
              child: Visibility(
                visible: index != 0,
                child: Container(
                  width: isExpanded ? 16.w : 24.w,
                  height: isExpanded ? 16.h : 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(3.r)),
                  ),
                  child: Center(
                    child: Text('$index', style: sfProDisplayRegular.copyWith(
                      fontSize: isExpanded ? 12.sp : 14.sp
                    ),),
                  ),
                ),
              ),
            ),

            Positioned(
              top:isExpanded ? 11.5 : 8.5,
              right: seats12 ? 5 :10,
              child: ValueListenableBuilder<bool>(
                  valueListenable: user.isMicOnNotifier,
                  builder: (context, isMicOn, _) {
                    if(!isExpanded)
                    return Visibility(
                      visible: isMicOn==false,
                      child: Image.asset(
                      AppImagePath.muteIcon,
                      width: 30.w,
                      height: 30.h,
                  ),
                    );
                    else
                      return Visibility(
                        visible: isMicOn==false,
                        child: Image.asset(
                          AppImagePath.mic_off,

                        ),
                      );

                }
              ),
            ),
            Positioned(
              bottom: isExpanded ? 20 : seats12 || seats9 || seats6 || seats4 ? 25 : 32,
              left: isExpanded? 5 : 10,
              child: Row(
                children: [
                  Text(
                    user.userName.split(' ')[0].capitalizeFirst ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isExpanded ? 12.sp : seats12 || seats9 || seats4  ? 12.sp : 14.sp,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            Positioned(
                bottom: isExpanded? 5 : 8,
                left: isExpanded? 5 : 10,
                child: Row(
                  children: [
                    Image.asset(
                      AppImagePath.coinsIcon,
                      height: isExpanded? 11.5.h :12.h,
                      width: isExpanded? 11.5.w : 12.w,
                    ),
                    SizedBox(
                      width: isExpanded? 4.w : 5.w,
                    ),
                    Center(
                      child: ValueListenableBuilder<int?>(
                          valueListenable: user.coinsNotifier,
                          builder: (context, coins, _) {
                            return Text(
                            "${coins ?? 0}",
                            style: TextStyle(
                              fontSize: isExpanded? 11.sp : 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.yellowBtnColor),
                          );
                        }
                      ),
                    ),
                  ],
                )),
            // Positioned(
            //   bottom: 8,
            //   right:  10,
            //   child: Visibility(
            //     visible: !seats9 && !seats12 && !seats4 && !isExpanded,
            //     child: Row(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment:
            //       MainAxisAlignment.center,
            //       children: [
            //         Stack(
            //           children: [
            //             Container(
            //               padding: const EdgeInsets.only(
            //                   left: 28),
            //               child: Image.asset(
            //                   AppImagePath.topPerson3,
            //                   width: 17.w,
            //                   height: 17.w),
            //             ),
            //             Container(
            //               padding: const EdgeInsets.only(
            //                   left: 15),
            //               child: Image.asset(
            //                   AppImagePath.topPerson2,
            //                   width: 17.w,
            //                   height: 17.w),
            //             ),
            //             Container(
            //               padding: const EdgeInsets.only(
            //                   left: 3),
            //               child: Image.asset(
            //                   AppImagePath.topPerson1,
            //                   width: 17.w,
            //                   height: 17.w),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        );
      else
        return Stack(
          children: [
            Positioned(
              top: 2,
              left: 2,
              child: Visibility(
                visible: index == 0,
                child: Container(
                  width: 15.w,
                  height: 15.h,
                  child: Image.asset(
                    AppImagePath.multiGuestNumberIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 2,
              left: 2,
              child: Visibility(
                visible: index != 0,
                child: Container(
                  width: 15.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(3.r)),
                  ),
                  child: Center(
                    child: Text('$index', style: sfProDisplayRegular.copyWith(
                        fontSize: 10.sp
                    ),),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 2,
              right: 2,
              child: ValueListenableBuilder<bool>(
                  valueListenable: user.isMicOnNotifier,
                  builder: (context, isMicOn, _) {
                    if(!isExpanded)
                      return Visibility(
                        visible: isMicOn==false,
                        child: Image.asset(
                          AppImagePath.muteIcon,
                          width: 15.w,
                          height: 15.h,
                        ),
                      );
                    else
                      return Visibility(
                        visible: isMicOn==false,
                        child: Image.asset(
                          AppImagePath.mic_off,

                        ),
                      );

                  }
              ),
            ),
            Positioned(
              bottom: 16,
              left: 5,
              child: Row(
                children: [
                  Text(
                    user.userName.split(' ')[0].capitalizeFirst ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(width: 2),
                ],
              ),
            ),
            Positioned(
                bottom: 2,
                left: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImagePath.coinsIcon,
                      height: 6.h,
                      width: 6.w,
                    ),
                    SizedBox(width: 2,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: ValueListenableBuilder<int?>(
                            valueListenable: user.coinsNotifier,
                            builder: (context, coins, _) {
                              return Text(
                                "${coins ?? 0}",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.yellowBtnColor),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                )),

          ],
        );
      }
    );
  }
}
