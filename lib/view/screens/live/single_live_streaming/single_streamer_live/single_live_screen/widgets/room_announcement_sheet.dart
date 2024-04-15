import 'package:flutter/material.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

class RoomAnnouncementSheet extends StatefulWidget {
  const RoomAnnouncementSheet();

  @override
  State<RoomAnnouncementSheet> createState() => _RoomAnnouncementSheetState();
}

class _RoomAnnouncementSheetState extends State<RoomAnnouncementSheet> {
  TextEditingController _announcementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Text(
            'Room Announcement',
            style: sfProDisplaySemiBold.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),
          AppTextFormField(
            controller: _announcementController,
            borderRadius: 0,
            fillColor: AppColors.grey500,
            borderColor: AppColors.grey300,
            validator: (value) {},
            maxLines: 6,
            hintText: "Welcome to Peyton-390562765's live room",
            hintStyle: sfProDisplayBold.copyWith(fontSize: 13, color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  title: 'Cancel',
                  borderRadius: 35,
                  textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.yellowColor),
                  bgColor: AppColors.grey500,
                  borderColor: AppColors.yellowColor,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  title: 'Ok',
                  borderRadius: 35,
                  textStyle: sfProDisplayBold.copyWith(fontSize: 16, color: AppColors.black),
                  bgColor: AppColors.yellowBtnColor,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
