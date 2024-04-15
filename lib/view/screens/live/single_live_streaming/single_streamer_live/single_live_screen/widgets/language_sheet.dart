import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

import '../../../../../../../view_model/live_controller.dart';


class LanguageSheet extends StatefulWidget {
  const LanguageSheet();

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  List<String> languages = ['English', 'عربى', 'हिन्दी', 'Русский язык', 'اُردُو'];
  final LiveViewModel liveViewModel= Get.find();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Text(
              'Language',
              style: sfProDisplaySemiBold.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              languages.length,
              (index) => GestureDetector(
                onTap: ()=> liveViewModel.selectedLanguage.value=languages[index],
                child: Column(
                  children: [
                    const Divider(color: AppColors.grey300),
                    const SizedBox(height: 16),
                    Text(
                      languages[index],
                      style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              title: 'Confirm',
              borderRadius: 35,
              textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
              bgColor: AppColors.yellowBtnColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
