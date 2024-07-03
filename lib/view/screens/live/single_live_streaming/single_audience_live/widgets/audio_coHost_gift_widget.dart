import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/audience_gift_card.dart';
import 'package:teego/view_model/battle_controller.dart';
import 'package:teego/view_model/gift_contoller.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/zego_controller.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../../parse/UserModel.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../../../../widgets/custom_buttons.dart';
import '../../../zegocloud/zim_zego_sdk/internal/business/audioRoom/live_audio_room_seat.dart';
import '../../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';

class AudioCoHostGiftAvatar extends StatefulWidget {
  AudioCoHostGiftAvatar();

  @override
  State<AudioCoHostGiftAvatar> createState() => _AudioCoHostGiftAvatarState();
}

class _AudioCoHostGiftAvatarState extends State<AudioCoHostGiftAvatar> {
  int selectedIndex = 0;
  bool all = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    LiveViewModel liveViewModel = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
      child: Row(
        children: [
          GestureDetector(
            onTap: ()=> setState(() {
              all=!all;
            }) ,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: all ? AppColors.yellowColor : AppColors.grey,
              ),
              child: Text(
                'All',
                style: sfProDisplayRegular.copyWith(color: Colors.black),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: liveViewModel.liveStreamingModel.getAudioSeats ?? 8,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ZegoLiveAudioRoomSeat seat= zegoController.getRoomSeatWithIndex(index);
                return ValueListenableBuilder<ZegoSDKUser?>(
                    valueListenable: seat.currentUser,
                    builder: (context, user, _) {
                      if(user != null &&  user.userID != Get.find<UserViewModel>().currentUser.getUid.toString() )
                      return GestureDetector(
                      onTap: ()=> setState(() {
                        selectedIndex=index;
                        liveViewModel.receiverUid = int.parse(user.userID);

                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.loose,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: selectedIndex == index || all==true ? AppColors.yellowColor : AppColors.grey,
                                      width: 2.5
                                  )
                              ),
                              child: CircleAvatar(
                                radius: 25.r,
                                backgroundImage: NetworkImage( user.avatarUrlNotifier.value!,),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              child: Visibility(
                                visible : index==0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: selectedIndex == index || all==true ? AppColors.yellowColor : AppColors.grey,
                                  child: Image.asset(AppImagePath.chessIcon, width: 14, height: 14),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              child: Visibility(
                                visible : index!=0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: selectedIndex == index || all==true ? AppColors.yellowColor : AppColors.grey,
                                  child: Text('$index', style: sfProDisplayMedium.copyWith(fontSize: 8.sp, color: Colors.black),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                      else
                        return SizedBox();
                  }
                );
              },
            ),
          ),




        ],
      ),
    );
  }
}



