import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';
import 'package:teego/view_model/userViewModel.dart';
import 'package:teego/view_model/zego_controller.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../../view_model/battle_controller.dart';
import '../../../../../../../view_model/live_controller.dart';
import '../../../../../../../view_model/popular_controller.dart';
import '../../../../../../widgets/custom_buttons.dart';


class BattleInviteSheet extends StatefulWidget {
  BattleInviteSheet({required this.time, required this.round, required this.top});

  final int time;
  final int round;
  final int top;

  @override
  State<BattleInviteSheet> createState() => _BattleInviteSheetState();
}

class _BattleInviteSheetState extends State<BattleInviteSheet> {
  int selectedIndex=-1;
  int selectedUserUid=-1;

  PopularViewModel popularViewModel = Get.find();

  @override
  void initState() {
    popularViewModel.loadLive(battle: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularViewModel>(
        init: popularViewModel,
        builder: (controller) {
          return Container(
          height: Get.height*0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.search, color: Colors.white, size: 28),
                    Text(
                      'Battles',
                      style: quinlliykRegular.copyWith(fontSize: 24),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: AppColors.grey300, thickness: 1.2),
                const SizedBox(height: 24),
                Text(
                  // 'Friends (80)',
                  'People who are live',
                  style: sfProDisplayBold.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 24),
                if(controller.popularAllModelList.isEmpty)
                  Column(
                    children: [
                      Container(
                        height: 200.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                            Text("No host is currently live", style: sfProDisplayMedium.copyWith(
                              fontSize: 14.sp,

                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                if(controller.popularAllModelList.isNotEmpty)
                ...List.generate(
                  controller.popularAllModelList.length,
                  (index) => GestureDetector(
                    onTap: (){
                      selectedIndex=index;
                      selectedUserUid=controller.popularAllModelList[index].liveModel.getAuthor!.getUid!;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.grey300,
                            backgroundImage: NetworkImage(controller.popularAllModelList[index].avatar),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(controller.popularAllModelList[index].name),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(
                                    controller.popularAllModelList[index].flag,
                                    width: 24,
                                    height: 17,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'id: ${controller.popularAllModelList[index].liveModel.getAuthor!.getUid!}',
                                    style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(Icons.copy, size: 15, color: AppColors.white.withOpacity(0.7)),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.white.withOpacity(0.7), width: 2),
                              color: selectedIndex==index ? AppColors.yellowColor : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'see more',
                //       style: sfProDisplayBold.copyWith(fontSize: 13, color: AppColors.white.withOpacity(0.7)),
                //     ),
                //     const Icon(Icons.keyboard_arrow_down),
                //   ],
                // ),
                // const SizedBox(height: 24),
                // Text(
                //   'People who are live',
                //   style: sfProDisplayBold.copyWith(fontSize: 18),
                // ),
                // const SizedBox(height: 25),
                // ...List.generate(
                //   3,
                //       (index) => Padding(
                //     padding: const EdgeInsets.only(bottom: 18),
                //     child: Row(
                //       children: [
                //         const CircleAvatar(
                //           radius: 24,
                //           backgroundColor: AppColors.grey300,
                //           backgroundImage: AssetImage(AppImagePath.cardImage2),
                //         ),
                //         const SizedBox(width: 16),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: [
                //                 const Text('Savannah Nguyen'),
                //                 const SizedBox(width: 16),
                //                 SvgPicture.asset(
                //                   AppImagePath.franceFlag,
                //                   width: 24,
                //                   height: 17,
                //                 ),
                //               ],
                //             ),
                //             const SizedBox(height: 8),
                //             Row(
                //               children: [
                //                 Text(
                //                   'id: 01251421',
                //                   style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.white.withOpacity(0.7)),
                //                 ),
                //                 const SizedBox(width: 10),
                //                 Icon(Icons.copy, size: 15, color: AppColors.white.withOpacity(0.7)),
                //               ],
                //             ),
                //           ],
                //         ),
                //         const Spacer(),
                //         Container(
                //           padding: const EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             border: Border.all(color: AppColors.white.withOpacity(0.7), width: 2),
                //             color: AppColors.yellowColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Spacer(),
                PrimaryButton(
                  title: 'Invite',
                  borderRadius: 35,
                  textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {
                    if(selectedIndex!=-1){
                      Navigator.pop(context);
                      Get.find<ZegoController>().sendPkBattleRequest(selectedUserUid, context);
                      Get.find<BattleViewModel>().initializeBattle(time: widget.time, rounds: widget.round, host: Get.find<UserViewModel>().currentUser, liveObjectId: Get.find<LiveViewModel>().liveStreamingModel.objectId!, liveObject: Get.find<LiveViewModel>().liveStreamingModel );

                    }
                    else{
                      QuickHelp.showAppNotificationAdvanced(title: "Please choose a user to invite to a PK battle", context: context);
                    }

                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      }
    );
  }
}
