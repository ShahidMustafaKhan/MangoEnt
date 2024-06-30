import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_streamer_live/single_live_screen/widgets/tags_chip.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

import '../../../../../../../view_model/live_controller.dart';


class TagsSheet extends StatefulWidget {
  const TagsSheet();

  @override
  State<TagsSheet> createState() => _TagsSheetState();
}

class _TagsSheetState extends State<TagsSheet> {
  List data = ['#Housewife', '#Christmas', '#Charmer', '#Lonely', '#Avaiable', '#Newbie'];
  List<String> selectedData = [];
  LiveViewModel liveViewModel= Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Text(
            'Select tag',
            style: sfProDisplaySemiBold.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 12),
          Text(
            'Tag will help you to reach to the wider audience',
            style: sfProDisplaySemiBold.copyWith(fontSize: 12, color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                ...List.generate(
                  data.length,
                  (index) => TagsChip(
                    text: data[index],
                    isSelected: liveViewModel.tagList.contains(data[index]),
                    onSelect: () {
                      if (liveViewModel.tagList.contains(data[index])) {
                        liveViewModel.tagList.remove(data[index]);
                      } else {
                        liveViewModel.tagList.insert(0,data[index]);
                      }
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            title: 'Confirm',
            borderRadius: 35,
            textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
            bgColor: AppColors.yellowBtnColor,
            onTap: () {
              Navigator.pop(context, selectedData);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
