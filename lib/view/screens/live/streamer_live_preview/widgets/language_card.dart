import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../../../../view_model/live_controller.dart';
import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/language_sheet.dart';


class LanguageCard extends StatelessWidget {
  LanguageCard();

  @override
  Widget build(BuildContext context) {
    LiveViewModel liveViewModel = Get.find();
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColors.grey500,
          builder: (context) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                const LanguageSheet(),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.black.withOpacity(0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx((){
                      return Text(
                        liveViewModel.selectedLanguage.value,
                        style: sfProDisplayBold.copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Set your live stream language to attract target audience',
                    style: sfProDisplayRegular.copyWith(
                      fontSize: 13,
                      color: AppColors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          ],
        ),
      ),
    );
  }
}
