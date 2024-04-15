import 'package:flutter/material.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

import '../../single_live_streaming/single_streamer_live/single_live_screen/widgets/room_announcement_sheet.dart';



class RoomAnnouncementCard extends StatelessWidget {
  const RoomAnnouncementCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
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
              builder: (context) => const RoomAnnouncementSheet(),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.black.withOpacity(0.6),
            ),
            child: Row(
              children: [
                Text(
                  'Set Room announcement',
                  style: sfProDisplayRegular.copyWith(
                    fontSize: 13,
                    color: AppColors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.black.withOpacity(0.7),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
