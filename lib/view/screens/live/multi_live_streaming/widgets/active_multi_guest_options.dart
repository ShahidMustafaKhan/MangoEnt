import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/internal_defines.dart';
import 'package:teego/view_model/live_controller.dart';

import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/multi_guest_grid_controller.dart';
import '../../../../../parse/LiveStreamingModel.dart';
import '../../../../../view_model/zego_controller.dart';
import '../../single_live_streaming/single_audience_live/widgets/audience_gift_sheet.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';

class ActiveMultiGuestOptions extends StatelessWidget {
  final ZegoSDKUser? user;
  final int? seat;

  ActiveMultiGuestOptions(this.user,this.seat);

  @override
  Widget build(BuildContext context) {
    final GridController _controller = Get.find<GridController>();
    final LiveViewModel liveViewModel = Get.find<LiveViewModel>();
    ZegoController zegoController = Get.find();
    bool seat6 = liveViewModel.isMultiSeat6;
    bool seat9 = liveViewModel.isMultiSeat9;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12.r,
                          backgroundImage: NetworkImage(user!.avatarUrlNotifier.value!,),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          user!.userName.split(' ')[0].capitalizeFirst!,
                          style: sfProDisplayMedium.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                      zegoController.liveStreamingManager.kickOutRoom(user!.userID.toString());
                    },
                    child: Row(
                      children: [
                        Image.asset(AppImagePath.deleteUser1),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Kickout',
                          style: sfProDisplayMedium.copyWith(
                              fontSize: 14, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              const Divider(color: AppColors.grey300, thickness: 1.2),
            
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  backgroundColor: AppColors.grey500,
                  builder: (context) => Wrap(
                    children: [
                      AudienceGiftSheet(),
                    ],
                  ),
                );},
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF363339),
                      child: Image.asset(
                        AppImagePath.guestGiftIcon,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text("Gift")
                  ],
                ),
              ),
              if(user!=null)
                ValueListenableBuilder<bool>(
                    valueListenable: user!.isMicOnNotifier,
                    builder: (context, isMicOn, _) {
                      return GestureDetector(
                        onTap: (){
                          zegoController.liveStreamingManager.muteSpeaker(user!.userID.toString(), isMicOn);
                        },
                      child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF363339),
                          child: Image.asset(
                            AppImagePath.micIcon,
                            width: 29,
                            height: 29,
                            color: !isMicOn ? AppColors.yellowColor : AppColors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text("Microphone")
                      ],
                    ),
                  );
                }
              ),
              InkWell(
                onTap: (){
                  zegoController.liveStreamingManager.requestCameraOff(user!.userID.toString());
                  QuickHelp.showAppNotificationAdvanced(title: "Request sent to cohost to turn off the camera.", context: context);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF363339),
                      child: Image.asset(
                        AppImagePath.guestCameraIcon,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text("Camera")
                  ],
                ),
              ),
              if((seat6 || seat9) && (!_controller.isExpanded.value || _controller.seat ==0))
              Column(
                children: [
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          _controller.user=user!;
                          _controller.seat=seat;
                          _controller.isExpanded.value=true;
                          Get.find<LiveViewModel>().setExpandedFeature(true, _controller.seat);
                          Get.back();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF363339),
                          child: Image.asset(
                            AppImagePath.multiGuestExpandIcon,
                            width: 48,
                            height: 48,
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 8.h),
                  Text("Expanded")
                ],
              )
            ],
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
