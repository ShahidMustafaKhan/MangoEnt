import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/widgets/beauty_filters_sheets/background_single_live_sheet.dart';
import 'package:teego/view/screens/live/widgets/beauty_filters_sheets/sticker_sheet.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import 'background_sheet.dart';
import 'beauty_sheet.dart';
import 'filter_sheet.dart';

class StickerModalSheet extends StatefulWidget {
  StickerModalSheet();

  @override
  State<StickerModalSheet> createState() => _StickerModalSheetState();
}

class _StickerModalSheetState extends State<StickerModalSheet> {
  int selectedIndex = -1;
  String selectedTab = 'Background';

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget buildContent() {
    switch (selectedTab) {
      case 'Sticker':
        return StickerWidget();
      case 'Filter':
        return FilterWidget();
      case 'Beauty':
        return BeautyWidget();
      case 'Background':
        return
          Get.find<LiveViewModel>().isSingleLive ? BackgroundSingleLiveWidget() :
          BackgroundWidget();
      default:
        return StickerWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => onTabSelected('Sticker'),
                  child: Column(
                    children: [
                      Text(
                        'Sticker',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Sticker')
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabSelected('Filter'),
                  child: Column(
                    children: [
                      Text(
                        'Filter',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Filter')
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabSelected('Beauty'),
                  child: Column(
                    children: [
                      Text(
                        'Beauty',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Beauty')
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabSelected('Background'),
                  child: Column(
                    children: [
                      Text(
                        'Background',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Background')
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
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
