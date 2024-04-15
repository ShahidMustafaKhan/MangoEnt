import 'package:flutter/material.dart';
import '../../../../../../utils/constants/typography.dart';
import '../../../../../../utils/theme/colors_constant.dart';

class ScreenRecordingSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.close, color: Colors.transparent),
                Text(
                  'Screen Recording',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 24),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.crop, size: 35),
                          const SizedBox(height: 11),
                          Text(
                            'Screenshot',
                            style: sfProDisplayRegular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.yellowColor,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: AppColors.grey500,
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: AppColors.yellowColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'click to start 5 to 60 second screen recording!',
                style: sfProDisplayRegular.copyWith(fontSize: 12, color: AppColors.white.withOpacity(0.7)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
