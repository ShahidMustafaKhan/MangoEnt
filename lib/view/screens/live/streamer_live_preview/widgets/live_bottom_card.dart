import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/live_controller.dart';

import '../../widgets/beauty_filters_sheets/sticker_modal_sheets.dart';

class LiveBottomCard extends StatelessWidget {
  final LiveViewModel liveViewModel;

  LiveBottomCard(this.liveViewModel);

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              if(liveViewModel.selectedLiveType.value != liveViewModel.bottomTab[liveViewModel.gameLiveIndex] && liveViewModel.selectedLiveType.value != liveViewModel.bottomTab[liveViewModel.audioLiveIndex])
              GestureDetector(
                  onTap: () => openBottomSheet(StickerModalSheet(),context),
                  child: Image.asset(AppImagePath.makeup, width: 30, height: 30)),
              if(liveViewModel.selectedLiveType.value != liveViewModel.bottomTab[liveViewModel.gameLiveIndex] && liveViewModel.selectedLiveType.value != liveViewModel.bottomTab[liveViewModel.audioLiveIndex])
                const SizedBox(width: 40),
              Expanded(
                child: PrimaryButton(
                  title: 'Go Live',
                  borderRadius: 35,
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {
                    Get.find<LiveViewModel>().createLive(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      liveViewModel.bottomTab.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: GestureDetector(
                          onTap: () {
                              liveViewModel.selectedLiveType.value = liveViewModel.bottomTab[index];
                          },
                          child: Column(
                            children: [
                              Text(
                                liveViewModel.bottomTab[index],
                                style: sfProDisplayMedium.copyWith(
                                  fontSize: liveViewModel.selectedLiveType.value == liveViewModel.bottomTab[index] ? 16.sp : 14.sp,
                                  color: liveViewModel.selectedLiveType.value == liveViewModel.bottomTab[index] ? AppColors.white : AppColors.white.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 8),
                              CircleAvatar(
                                backgroundColor: liveViewModel.selectedLiveType.value == liveViewModel.bottomTab[index] ? Colors.white : Colors.transparent,
                                radius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
