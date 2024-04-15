import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view_model/battle_live_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../generated/assets.dart';
import '../../../parse/LiveStreamingModel.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/typography.dart';
import '../../../utils/permission/go_live_permission.dart';
import '../../../utils/theme/colors_constant.dart';
import '../../widgets/bottom_nav_shape.dart';
import '../../widgets/nothing_widget.dart';

class Battle extends StatefulWidget {
   Battle({Key? key}) : super(key: key);

  @override
  State<Battle> createState() => _BattleState();
}

class _BattleState extends State<Battle> {
  final BattleLiveViewModel battleLiveViewModel = Get.put(BattleLiveViewModel());


  @override
  void initState() {
    // battleLiveViewModel.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // battleLiveViewModel.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBattleContent(),
      ],
    );
  }

  Widget _buildBattleContent() {
    return GetBuilder<BattleLiveViewModel>(
        builder: (controller) {
          return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h,),
            // if(battleLiveViewModel.battleModelList.isNotEmpty)
            // Expanded(
            //   child: ListView.builder(itemBuilder: (context, index) {
            //     return InkWell(
            //       onTap: ()=>LivePermissionHandler.checkPermission(LiveStreamingModel.keyTypeSingleLive, context, liveStreamingModel: controller.battleModelList[index].liveModel),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 16.8, vertical: 16),
            //         child: Container(
            //           width: ScreenUtil().setWidth(150),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.white),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               _buildBattleInfo(
            //                 hostName: controller.battleModelList[index].hostName,
            //                 player2Name: controller.battleModelList[index].player2Name,
            //                 hostBgImage: controller.battleModelList[index].hostBgImage,
            //                 player2BgImage: controller.battleModelList[index].player2BgImage,
            //                 team1Score: controller.battleModelList[index].team1Score,
            //                 team2Score: controller.battleModelList[index].team2Score,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },padding: EdgeInsets.only(bottom: 65.h), itemCount: controller.battleModelList.length,),
            // ),
            // if(battleLiveViewModel.battleModelList.isEmpty)
              NothingIsHere()

          ],
        );
      }
    );
  }

  Widget _buildBattleInfo({
     required String hostName,
     required String player2Name,
     required String hostBgImage,
     required String player2BgImage,
     required int team1Score,
     required int team2Score,

}) {
    return SizedBox(
      width: 340.w,
      child: Stack(
        children: [
          _buildBackGroundImages(hostBgImage, player2BgImage),
          _buildHostName(hostName),
          _buildPlayer2Name(player2Name),
          _buildVsImage(),
          _buildProgressBar(
            team1Score: team1Score,
            team2Score: team2Score,
          )
        ],
      ),
    );
  }

  Widget _buildHostName(String name){
    return Positioned(
      bottom: 25.h, left: 9.w,
      child: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

   Widget _buildPlayer2Name(String name){
     return Positioned(
       bottom: 25.h, right: 9.w ,
       child: Text(
         name,
         style: const TextStyle(fontWeight: FontWeight.w500),
       ),
     );
   }

  Widget _buildBackGroundImages(String leftBackgroundImage, String rightBackgroundImage){
    return Row(
      children: [

        ClipRRect(
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          child: SizedBox(width:170.w,child: Image.network(leftBackgroundImage,fit: BoxFit.cover,)),
        ),

        ClipRRect(
          borderRadius:const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          child: SizedBox(width:170.w,child: Image.network(rightBackgroundImage,fit: BoxFit.cover,)),
        ),
      ],
    );
  }

  Widget _buildVsImage(){
    return Positioned(
      left: 153.h, top: 70.45.w ,
      child: Image.asset(Assets.pngVs),
    );
  }

  Widget _buildProgressBar({
     required int team1Score,
     required int team2Score,
}){
    return Positioned(
      bottom: 0.7.h,
      child: ClipRRect(
        borderRadius:const BorderRadius.only( bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkPurple
            ),
            height: 16.h,
            width: 340.w,
            child: Stack(
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  child: LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    padding: EdgeInsets.zero,
                    width: 340.w,
                    lineHeight: 16.h,
                    percent: 0.5,
                    clipLinearGradient: true,
                    animationDuration: 500,
                    backgroundColor: Colors.transparent,
                    linearGradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: AppColors.orangeGradientColor),
                  ),
                ),

                Positioned(
                  left:16.w,
                  top:2.5.h,
                  child: Text(team1Score.toString(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff),
                    ),),
                ),

                Positioned(
                  right:16.w,
                  top:2.5.h,
                  child: Text(team2Score.toString(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff),
                    ),),
                ),
              ],
            )
        ),
      ),
    );
  }
}
