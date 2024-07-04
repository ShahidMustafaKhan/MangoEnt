import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/helpers/quick_actions.dart';
import 'package:teego/helpers/quick_help.dart';

import '../../../../../parse/RankingModel.dart';
import '../../../../../parse/UserModel.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/constants/typography.dart';
import '../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/ranking_controller.dart';
import '../../../../widgets/base_scaffold.dart';
import '../../../../widgets/nothing_widget.dart';

class TopFanView extends StatefulWidget {
  @override
  State<TopFanView> createState() => _TopFanViewState();
}

class _TopFanViewState extends State<TopFanView> {
  String activeTab = "Weekly";
  RankingViewModel rankingViewModel = Get.find();
  List<RankingModel> ranking = [];

  @override
  void initState() {
    rankingViewModel.fetchRanking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? Colors.black : Colors.white;
    final backgroundColor = isLightTheme ? Colors.white : AppColors.grey900;

    rankingViewModel.fetchRanking();
    if (activeTab == "Daily")
      ranking = rankingViewModel.dailyRanking;
    else if (activeTab == "Weekly")
      ranking = rankingViewModel.weeklyRanking;
    else
      ranking = rankingViewModel.monthRanking;

    return BaseScaffold(
      // backgroundColor: AppColors.grey700,
      body: SafeArea(
        child: GetBuilder<RankingViewModel>(
            init: rankingViewModel,
            builder: (rankingViewModel) {
              if (activeTab == "Daily")
                ranking = rankingViewModel.dailyRanking;
              else if (activeTab == "Weekly")
                ranking = rankingViewModel.weeklyRanking;
              else
                ranking = rankingViewModel.monthRanking;
              if (ranking.isNotEmpty)
                return Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios_new,
                                color: textColor),
                          ),
                          Text(
                            '15k 🚨 MICMIC',
                            style: sfProDisplayMedium.copyWith(
                                color: textColor, fontSize: 16),
                          ),
                          const Icon(Icons.arrow_back_ios_new,
                              color: Colors.transparent),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: backgroundColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Daily';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Daily'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Daily',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Daily'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Weekly';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Weekly'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Weekly',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Weekly'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Monthly';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Monthly'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Monthly',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Monthly'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(AppImagePath.levelBadge,
                            width: 120, height: 120),
                        Positioned(
                          top: 40,
                          left: 29,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                                ranking[0].getGifter!.getAvatar!.url!,
                                fit: BoxFit.contain,
                                width: 64,
                                height: 64),
                          ),
                        ),
                      ],
                    ),
                    Text(ranking[0].getGifter!.getFullName ?? '',
                        style: TextStyle(fontSize: 14.sp, color: textColor)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(35)),
                        color: AppColors.lightPurple,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImagePath.gemStone,
                              height: 15, width: 15),
                          const SizedBox(width: 5),
                          Text('LV.${ranking[0].getGifter!.getLevel ?? 1}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImagePath.diamondIcon,
                            height: 18, width: 18),
                        const SizedBox(width: 5),
                        Text(
                          '${ranking[0].getCoins}',
                          style: sfProDisplayRegular.copyWith(
                              color: AppColors.yellowColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      thickness: 3,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.separated(
                          itemCount: ranking.length - 1,
                          itemBuilder: (context, index) {
                            UserModel gifter = ranking[index + 1].getGifter!;
                            int coins = ranking[index + 1].getCoins!;
                            return Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 2}',
                                  style: sfProDisplaySemiBold.copyWith(
                                      fontSize: 15, color: textColor),
                                ),
                                const SizedBox(width: 15),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.grey300,
                                  backgroundImage:
                                  NetworkImage(gifter.getAvatar!.url!),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          gifter.getFullName ?? '',
                                          style: TextStyle(color: textColor),
                                        ),
                                        const SizedBox(width: 16),
                                        if (gifter.getHideMyLocation == false)
                                          SvgPicture.asset(
                                            QuickActions.getCountryFlag(gifter),
                                            width: 24,
                                            height: 17,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(AppImagePath.diamondIcon,
                                            height: 18, width: 18),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$coins',
                                          style: sfProDisplayRegular.copyWith(
                                              color: AppColors.yellowColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(35)),
                                      color: AppColors.lightPurple,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(AppImagePath.gemStone,
                                            height: 15, width: 15),
                                        const SizedBox(width: 5),
                                        Text('LV.${gifter.getLevel ?? 1}',
                                            style: sfProDisplayRegular.copyWith(
                                                fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 25),
                        ),
                      ),
                    )
                  ],
                );
              else
                return Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios_new,
                                color: textColor),
                          ),
                          Text(
                            '15k 🚨 MICMIC',
                            style: sfProDisplayMedium.copyWith(
                                color: textColor, fontSize: 16),
                          ),
                          Icon(Icons.arrow_back_ios_new,
                              color: Colors.transparent),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: backgroundColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Daily';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Daily'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Daily',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Daily'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Weekly';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Weekly'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Weekly',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Weekly'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeTab = 'Monthly';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: activeTab == 'Monthly'
                                    ? AppColors.yellowColor
                                    : backgroundColor,
                              ),
                              child: Text(
                                'Monthly',
                                style: sfProDisplayRegular.copyWith(
                                    color: activeTab == 'Monthly'
                                        ? AppColors.black
                                        : textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 120.h),
                    NothingIsHere(
                      height: 170.h,
                      width: 160.w,
                    )
                  ],
                );
            }),
      ),
    );
  }
}
