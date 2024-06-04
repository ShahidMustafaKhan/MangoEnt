import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/view/screens/live/audio_live_streaming/widgets/waiting_widget.dart';
import 'package:teego/view/screens/live/zegocloud/zim_zego_sdk/internal/business/business_define.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../../../../view_model/live_controller.dart';
import 'guest_widget.dart';
import 'invite_widget.dart';

class AudioBottomModalSheet extends StatefulWidget {
  AudioBottomModalSheet();

  @override
  State<AudioBottomModalSheet> createState() => _AudioBottomModalSheetState();
}

class _AudioBottomModalSheetState extends State<AudioBottomModalSheet> {
  int selectedIndex = -1;
  String selectedTab = 'Waiting';

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget buildContent() {
    switch (selectedTab) {
      case 'Guests':
        return GuestsWidget();
      case 'Waiting':
        return WaitingWidget();
      case 'Invite':
        return InviteWidget();
      default:
        return InviteWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: selectedTab=='Invite' ? MediaQuery.of(context).size.height * 0.7 : MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: Get.find<LiveViewModel>().role==ZegoLiveRole.host ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onTabSelected('Guests'),
                  child: Column(
                    children: [
                      if(Get.find<LiveViewModel>().role==ZegoLiveRole.host)
                        Text(
                        'Guests',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Guests')
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
                if(Get.find<LiveViewModel>().role==ZegoLiveRole.host)
                GestureDetector(
                  onTap: () => onTabSelected('Invite'),
                  child: Column(
                    children: [
                      Text(
                        'Invite',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Invite')
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
                  onTap: () => onTabSelected('Waiting'),
                  child: Column(
                    children: [
                      Text(
                        'Waiting',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Waiting')
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
