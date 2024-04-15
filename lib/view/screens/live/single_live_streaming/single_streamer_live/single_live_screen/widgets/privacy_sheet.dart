import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

import '../../../../../../../view_model/live_controller.dart';


class PrivacySheet extends StatelessWidget {
   PrivacySheet();

  final LiveViewModel liveViewModel= Get.find();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Text(
            'Publish',
            style: sfProDisplaySemiBold.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.grey300),
          const SizedBox(height: 16),
          InkWell(
            onTap: (){
              liveViewModel.mode.value="Public";
            },
            child: Text(
              'Public',
              style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.grey300),
          const SizedBox(height: 16),
          InkWell(
            onTap: (){
              liveViewModel.mode.value="Subscribers";
            },
            child: Text(
              'Subscribers',
              style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
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
    );
  }
}
