// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:lottie/lottie.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:svgaplayer_flutter/player.dart';
// import 'package:teego/utils/constants/app_constants.dart';
// import 'package:teego/utils/theme/colors_constant.dart';
// import 'package:teego/view_model/animation_controller.dart';
//
// import '../../../../../../../../view_model/battle_controller.dart';
//
//
//
//
// class VersusAnimation extends StatelessWidget {
//   final BattleViewModel battleViewModel;
//   final AnimationViewModel animationViewModel;
//
//   VersusAnimation({required this.battleViewModel, required this.animationViewModel});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: -95.h ,
//       child: Container(
//         width: Get.width,
//         child: Lottie.asset(AppImagePath.versus2Json,
//               controller: animationViewModel.vsAnimationController,
//           fit: BoxFit.cover,
//           ),
//       ),
//     );
//   }
// }
