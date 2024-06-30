import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/WhisperListModel.dart';
import 'package:teego/view/screens/live/widgets/whisper/whisper_sheet.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/whisper_list_controller.dart';
import 'greeting_sheet.dart';

class WhisperModal extends StatefulWidget {
  WhisperModal();

  @override
  State<WhisperModal> createState() => _WhisperModalState();
}

class _WhisperModalState extends State<WhisperModal> {
  String selectedTab = 'Whisper';

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget buildContent() {
    switch (selectedTab) {
      case 'Whisper':
        return WhisperSheet();
      case 'Greeting':
        return GreetingSheet();
      default:
        return WhisperSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onTabSelected('Whisper'),
                  child: Column(
                    children: [
                      Text(
                        'Whisper',
                        style: sfProDisplaySemiBold.copyWith(fontSize: 20.sp),
                      ),
                      // if (selectedTab == 'Whisper')
                      //   Container(
                      //     margin: const EdgeInsets.only(top: 4),
                      //     height: 4,
                      //     width: 20,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: AppColors.white,
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 30.w,
                // ),
                // GestureDetector(
                //   onTap: () => onTabSelected('Greeting'),
                //   child: Column(
                //     children: [
                //       Text(
                //         'Greeting',
                //         style: sfProDisplayMedium.copyWith(fontSize: 20),
                //       ),
                //       if (selectedTab == 'Greeting')
                //         Container(
                //           margin: const EdgeInsets.only(top: 4),
                //           height: 4,
                //           width: 20,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: AppColors.white,
                //           ),
                //         ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.grey300, thickness: 1.2),
            const SizedBox(height: 24),
            Expanded(child: buildContent()),
          ],
        ),
      ),
    );
  }
}
