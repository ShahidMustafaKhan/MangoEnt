import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/routes/app_routes.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import 'package:teego/view_model/live_controller.dart';

class LiveBottomCard extends StatefulWidget {
  const LiveBottomCard();

  @override
  State<LiveBottomCard> createState() => _LiveBottomCardState();
}

class _LiveBottomCardState extends State<LiveBottomCard> {
  List bottomTab = [
    'Multi-guest Live',
    'Live',
    'Audio Live',
    'Game Live',
  ];

  String selectedTab = 'Live';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Image.asset(AppImagePath.makeup, width: 30, height: 30),
            const SizedBox(width: 40),
            Expanded(
              child: PrimaryButton(
                title: 'Go Live',
                borderRadius: 35,
                bgColor: AppColors.yellowBtnColor,
                onTap: () {
                  Get.find<LiveViewModel>().createLive(context);
                  // Get.toNamed(AppRoutes.streamerSingleLivePreview);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                bottomTab.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = bottomTab[index];
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          bottomTab[index],
                          style: sfProDisplayMedium.copyWith(
                            fontSize: selectedTab == bottomTab[index] ? 16.sp : 14.sp,
                            color: selectedTab == bottomTab[index] ? AppColors.white : AppColors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CircleAvatar(
                          backgroundColor: selectedTab == bottomTab[index] ? Colors.white : Colors.transparent,
                          radius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
