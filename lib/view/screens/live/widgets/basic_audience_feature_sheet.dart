import 'package:flutter/material.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/screen_recording_sheet.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/widgets/settings_sheet.dart';

import '../../../../helpers/quick_actions.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/typography.dart';
import '../../../../utils/theme/colors_constant.dart';
import 'basic_feature_sheets/live_setting_sheet.dart';


class BasicAudienceFeatureSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Padding(
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
              'Other',
              style: sfProDisplaySemiBold.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ToolWidget(title: 'Dislike', icon: AppImagePath.dislikeIcon),
                  ),
                  SizedBox(width: 32),
                  ToolWidget(title: 'Whispers', icon: AppImagePath.whisperIcon),
                  SizedBox(width: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: AppColors.grey500,
                        builder: (context) => ScreenRecordingSheet(),
                      );
                    },
                    child: ToolWidget(title: 'Record', icon: AppImagePath.recordIcon),
                  ),
                  SizedBox(width: 32),
                  GestureDetector(
                    onTap: ()=> openBottomSheet(LiveSettingSheet(), context, back: true),
                    child: ToolWidget(title: 'Setting', icon: AppImagePath.settings),
                  ),
                  SizedBox(width: 32),
                ],
              ),
            ),
          ],
        ),
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
