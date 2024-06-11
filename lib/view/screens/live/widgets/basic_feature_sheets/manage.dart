import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/custom_buttons.dart';
import '../../../../../../../view_model/live_controller.dart';
import 'manage_modal.dart';

class ManageSheet extends StatefulWidget {
  const ManageSheet();

  @override
  State<ManageSheet> createState() => _ManageSheetState();
}

class _ManageSheetState extends State<ManageSheet> {
  List<String> languages = [
    'Disable chat',
    'Kick out',
    'Block permanently',
    'Report',
    'Admin'
  ];
  final LiveViewModel liveViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
            ...List.generate(
              languages.length,
              (index) => GestureDetector(
                onTap: () {
                  switch (languages[index]) {
                    case 'Disable chat':
                      Get.back();
                      _showModal(context,
                          ManageModalSheet(initialTab: 'Disable Chat'));
                      break;
                    case 'Block permanently':
                      Get.back();
                      _showModal(
                          context, ManageModalSheet(initialTab: 'Blocked'));
                      break;
                    case 'Admin':
                      Get.back();
                      _showModal(
                          context, ManageModalSheet(initialTab: 'Admin List'));
                      break;
                  }
                },
                child: Container(
                  color: const Color(0xff363339),
                  child: Column(
                    children: [
                      const Divider(color: AppColors.grey300),
                      SizedBox(height: 16.h),
                      Text(
                        languages[index],
                        style: sfProDisplaySemiBold.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 26.h),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              title: 'Cancel',
              borderRadius: 12.r,
              textStyle: sfProDisplayBold.copyWith(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
              bgColor: AppColors.yellowBtnColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext context, Widget modalContent) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColors.grey500,
      isScrollControlled: true,
      builder: (context) => modalContent,
    );
  }
}
