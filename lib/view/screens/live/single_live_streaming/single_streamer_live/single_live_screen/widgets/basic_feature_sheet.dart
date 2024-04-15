import 'package:flutter/material.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class BasicFeatureSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            'Basic Features',
            style: sfProDisplaySemiBold.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(AppImagePath.wishBadge, width: 80, height: 60),
                  Text(
                    'Wish List',
                    style: sfProDisplayRegular.copyWith(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Image.asset(AppImagePath.subscriber, width: 50, height: 50),
                  const SizedBox(height: 11),
                  Text(
                    'Subscriber',
                    style: sfProDisplayRegular.copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Tools',
            style: sfProDisplaySemiBold.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                ToolWidget(title: 'Filter word', icon: AppImagePath.filterWord),
                SizedBox(width: 32),
                ToolWidget(title: 'Beauty', icon: AppImagePath.beauty),
                SizedBox(width: 32),
                ToolWidget(title: 'BGM', icon: AppImagePath.bgm),
                SizedBox(width: 32),
                ToolWidget(title: 'Whispers', icon: AppImagePath.whisper),
                SizedBox(width: 32),
                ToolWidget(title: 'Announcement', icon: AppImagePath.announcement),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Other',
            style: sfProDisplaySemiBold.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                ToolWidget(title: 'Switch', icon: AppImagePath.switchIcon),
                SizedBox(width: 32),
                ToolWidget(title: 'Data', icon: AppImagePath.dataIcon),
                SizedBox(width: 32),
                ToolWidget(title: 'Record', icon: AppImagePath.recordIcon),
                SizedBox(width: 32),
                ToolWidget(title: 'Mirror', icon: AppImagePath.mirrorIcon),
                SizedBox(width: 32),
                ToolWidget(title: 'Admin', icon: AppImagePath.admin),
                SizedBox(width: 32),
                ToolWidget(title: 'Setting', icon: AppImagePath.settings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToolWidget extends StatelessWidget {
  final String title;
  final String icon;

  const ToolWidget({

    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.darkBlue,
          ),
          child: Image.asset(icon, width: 28, height: 28),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: sfProDisplayRegular.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
