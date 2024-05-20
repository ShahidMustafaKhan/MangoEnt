import 'package:flutter/material.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/multiguest/widgets/guest_top_menu.dart';
import 'package:teego/view/screens/live/multiguest/widgets/three_live_widget.dart';
import 'package:teego/view/screens/live/multiguest/widgets/live_bottom_card.dart';

class MultiGuestThreePeopleView extends StatelessWidget {
  const MultiGuestThreePeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // showModalBottomSheet(
                      //   context: context,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(20),
                      //       topRight: Radius.circular(20),
                      //     ),
                      //   ),
                      //   backgroundColor: AppColors.grey500,
                      //   builder: (context) => const RoomAnnouncementSheet(),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.black.withOpacity(0.2),
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
                      backgroundColor: AppColors.black.withOpacity(0.2),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GuestTopMenu(),
            ),
            SizedBox(height: 10),
            ThreeLiveWidget(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const LiveBottomCard(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
