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
    RxString mode = liveViewModel.mode.value.obs;
    return Obx(() {
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
                  mode.value="Public";
                  // liveViewModel.mode.value="Public";
                  // Get.back();
                },
                child: Text(
                  'Public',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: mode.value == "Public" ? AppColors.yellowColor : Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.grey300),
              const SizedBox(height: 16),
              InkWell(
                onTap: (){
                  mode.value="Subscribers";
                  // liveViewModel.mode.value="Subscribers";
                },
                child: Text(
                  'Subscribers',
                  style: sfProDisplaySemiBold.copyWith(fontSize: 16, color: mode.value == "Subscribers" ? AppColors.yellowColor : Colors.white),
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
                  liveViewModel.mode.value = mode.value;
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }
    );
  }
}
