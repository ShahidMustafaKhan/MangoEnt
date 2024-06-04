import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../../view_model/zego_controller.dart';
import '../../zegocloud/zim_zego_sdk/internal/sdk/basic/zego_sdk_user.dart';



class ActiveSeat extends StatelessWidget {
  final ZegoSDKUser userInfo;
  ActiveSeat(this.userInfo);

  @override
  Widget build(BuildContext context) {
    ZegoController zegoController = Get.find();
    return Column(
      children: [
        Stack(
          children: [
            ValueListenableBuilder<String?>(
                valueListenable: userInfo.avatarUrlNotifier,
                builder: (context, avatarUrl, _) {
                if (avatarUrl != null && avatarUrl.isNotEmpty)
                return Container(
                  height: 54.r,
                  width: 54.r,
                  decoration: BoxDecoration(
                    color: Color(0xFF2C2931),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.yellowBtnColor,
                        width: 1.5),
                    image: DecorationImage(
                      image: NetworkImage(avatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
                else
                  return SizedBox(
                    width: 55,
                    height: 55,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              border: Border(
                                bottom: BorderSide.none,
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                  height: 20,
                                  child: Text(
                                    userInfo.userID.substring(0, 1),
                                    style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            ))),
                  );
              }
            ),
            Positioned(
                top: 0,
                right: 0,
                left: 40,
                child: ValueListenableBuilder<bool?>(
                    valueListenable: userInfo.isMicOnNotifier,
                    builder: (context, isMicOn, _) {
                    return Visibility(
                      visible: isMicOn==false,
                      child: Container(
                        height: 16.w,
                        width: 16.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white),
                        child: Center(
                            child: Image.asset(
                                AppImagePath.mic_off)),
                      ),
                    );
                  }
                ))
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          userInfo.userName.split(' ')[0],
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Color(0xFF231E28),
                child: Image.asset(
                  AppImagePath.audioLiveCoin,
                  width: 8.w,
                  height: 8.w,
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            ValueListenableBuilder<int?>(
                valueListenable: userInfo.coinsNotifier,
                builder: (context, coins, _) {
                return Text(
                  "${coins ?? 0}",
                  style: TextStyle(
                      color: AppColors.yellowBtnColor),
                );
              }
            )
          ],
        )
      ],
    );
  }
}
