import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/widgets/app_text_field.dart';
import 'package:teego/view/widgets/custom_buttons.dart';

import '../../../../../../../view_model/live_controller.dart';

class RoomAnnouncementSheet extends StatefulWidget {
  final bool fromPreview;
  const RoomAnnouncementSheet({this.fromPreview=false});

  @override
  State<RoomAnnouncementSheet> createState() => _RoomAnnouncementSheetState();
}

class _RoomAnnouncementSheetState extends State<RoomAnnouncementSheet> {
  TextEditingController _announcementController = TextEditingController();
  LiveViewModel liveViewModel = Get.find();

  @override
  void initState() {
    if(widget.fromPreview==false)
    _announcementController.text = liveViewModel.liveStreamingModel.getRoomAnnouncement ?? '';
    else{
      if(liveViewModel.roomAnnouncement.value.isNotEmpty){
        _announcementController.text = liveViewModel.roomAnnouncement.value;
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom : MediaQuery.of(context).viewInsets.bottom),
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
                  onTap: () {
                    Get.back();
                    if(_announcementController.text.isNotEmpty){
                      if(widget.fromPreview==false) {
                        liveViewModel.liveStreamingModel.setRoomAnnouncement =
                            _announcementController.text;
                        liveViewModel.liveStreamingModel.save();
                      }
                      else
                        liveViewModel.roomAnnouncement.value =  _announcementController.text;
                    }
                  },
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
