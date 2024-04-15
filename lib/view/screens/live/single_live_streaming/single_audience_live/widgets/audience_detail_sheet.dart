import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../../helpers/quick_help.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';
import '../../../../../../view_model/live_controller.dart';
import '../../../../../widgets/custom_buttons.dart';


class AudienceDetailSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveViewModel>(builder: (liveViewModel)  {
      return SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            color: AppColors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Live'),
                              const SizedBox(width: 10),
                              Image.asset(AppImagePath.statsIcon, height: 10, width: 10),
                            ],
                          ),
                        ),
                      ),
                      Text('🦊 ${liveViewModel.liveStreamingModel.getAuthor!.getFullName!} 🦊', style: sfProDisplayBold.copyWith(fontSize: 16)),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'id: ${liveViewModel.liveStreamingModel.getAuthor!.getUid!}',
                            style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.white.withOpacity(0.7)),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.copy, size: 15),
                          const SizedBox(width: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(35)),
                              color: AppColors.progressPinkColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppImagePath.marsIcon, height: 15, width: 15),
                                const SizedBox(width: 5),
                                Text(QuickHelp.getBirthdayFromDate(liveViewModel.liveStreamingModel.getAuthor!.getBirthday!)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(35)),
                              color: AppColors.darkOrange,
                            ),
                            child: Text('Lv. ${liveViewModel.liveStreamingModel.getAuthor!.getLevel ?? 1}'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(liveViewModel.liveStreamingModel.getAuthor!.getFollowers!.length.toString(), style: sfProDisplayBold.copyWith(fontSize: 18)),
                              const SizedBox(height: 5),
                              Text(
                                'Following',
                                style: sfProDisplayRegular.copyWith(
                                  fontSize: 12,
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 1,
                            color: AppColors.yellowColor,
                          ),
                          Column(
                            children: [
                              Text(liveViewModel.liveStreamingModel.getAuthor!.getFollowing!.length.toString(), style: sfProDisplayBold.copyWith(fontSize: 18)),
                              const SizedBox(height: 5),
                              Text(
                                'Followers',
                                style: sfProDisplayRegular.copyWith(
                                  fontSize: 12,
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 1,
                            color: AppColors.yellowColor,
                          ),
                          Column(
                            children: [
                              Text('0', style: sfProDisplayBold.copyWith(fontSize: 18)),
                              const SizedBox(height: 5),
                              Text(
                                'Likes',
                                style: sfProDisplayRegular.copyWith(
                                  fontSize: 12,
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.orangeContainer,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset(AppImagePath.bubblesIcon, width: 60, height: 50),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subscribe',
                                        style: sfProDisplaySemiBold.copyWith(fontSize: 20),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Watch all the exclusive context and live streames',
                                        style: sfProDisplayRegular.copyWith(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(AppImagePath.subscribeBadge, width: 126, height: 64),
                              ],
                            ),
                            Positioned(
                              top: -20,
                              left: 13,
                              child: Image.asset(AppImagePath.warningIcon, width: 43, height: 43),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {},
                              bgColor: AppColors.yellowColor,
                              borderRadius: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add, color: AppColors.black),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Follow',
                                    style: sfProDisplayMedium.copyWith(color: AppColors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.progressPinkColor,
                                  AppColors.progressPinkColor2,
                                ],
                              ),
                            ),
                            child: Image.asset(AppImagePath.giftIcon, width: 25, height: 25),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {},
                              bgColor: AppColors.black,
                              borderRadius: 50,
                              borderColor: AppColors.yellowColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.message_outlined, color: AppColors.yellowColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Chat',
                                    style: sfProDisplayMedium.copyWith(color: AppColors.yellowColor, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  top: -25,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.yellowColor, width: 2),
                      borderRadius: BorderRadius.circular(80),
                      image: DecorationImage(image: NetworkImage(liveViewModel.liveStreamingModel.getAuthor!.getAvatar!.url!), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
