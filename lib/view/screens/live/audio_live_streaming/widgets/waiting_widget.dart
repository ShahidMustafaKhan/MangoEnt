import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/app_constants.dart';

import '../../../../../helpers/quick_help.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import '../../../../widgets/custom_buttons.dart';
import '../../zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../zegocloud/zim_zego_sdk/zego_sdk_manager.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget();

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();

    int numberOfItems = 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
                valueListenable:
                ZEGOSDKManager.instance.zimService.roomRequestMapNoti,
                builder: (context, Map<String, dynamic> requestMap, _) {
                  final requestList = requestMap.values.toList();
                  List userIdList = requestList.map((obj) => obj.senderID).toList();
                  print(userIdList);
                  numberOfItems=requestMap.values
                      .toList()
                      .length;
                  return FutureBuilder<List?>(
                      future: liveViewModel.fetchUserdataRequest(userIdList),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot
                              .error}'));
                        }
                        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                                    Text("Nothing is here", style: sfProDisplayMedium.copyWith(
                                      fontSize: 14.sp,

                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.data!.length == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("*  ", style: sfProDisplayBlack.copyWith(color: Colors.red),),
                                    Text("Nothing is here", style: sfProDisplayMedium.copyWith(
                                      fontSize: 14.sp,
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return Column(
                            children: List.generate(
                                snapshot.data!.length,
                                    (index) {
                                  final user = snapshot
                                      .data![index] as UserModel;
                                  final roomRequest = requestList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: AppColors.grey300,
                                          backgroundImage: NetworkImage(
                                              user.getAvatar!.url!),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(user.getFullName ?? ''),
                                                const SizedBox(width: 16),
                                                SvgPicture.asset(
                                                  AppImagePath.franceFlag,
                                                  width: 24,
                                                  height: 17,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  user.getUid.toString(),
                                                  style: sfProDisplayRegular
                                                      .copyWith(
                                                      fontSize: 12,
                                                      color: AppColors.white
                                                          .withOpacity(0.7)),
                                                ),
                                                const SizedBox(width: 10),
                                                Icon(Icons.copy,
                                                    size: 15,
                                                    color: AppColors.white
                                                        .withOpacity(0.7)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        if(Get.find<LiveViewModel>().role==ZegoLiveRole.host)
                                        PrimaryButton(
                                          width: 65.w,
                                          height: 32.h,
                                          title: 'Add',
                                          borderRadius: 35,
                                          textStyle: sfProDisplayMedium
                                              .copyWith(
                                              fontSize: 16,
                                              color: AppColors.black),
                                          bgColor: AppColors.yellowBtnColor,
                                          onTap: () {
                                            ZEGOSDKManager.instance.zimService
                                                .acceptRoomRequest(
                                                roomRequest.requestID ?? '')
                                                .then((value) {
                                                  Get.back();
                                            })
                                                .catchError((error) {
                                              QuickHelp.showAppNotificationAdvanced(title: 'Agree cohost failed!', context: context);

                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      } );
              }
            ),
          ),
        ),
      ],
    );
  }
}
