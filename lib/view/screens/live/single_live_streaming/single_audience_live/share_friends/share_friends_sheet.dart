import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/share_friends/recent_tab.dart';
import 'package:teego/view/screens/live/single_live_streaming/single_audience_live/share_friends/social_tab.dart';

import 'all_friends_tab.dart';
import 'fans_tab.dart';


class ShareFriendsSheet extends StatefulWidget {

  @override
  State<ShareFriendsSheet> createState() => _ShareFriendsSheetState();
}

class _ShareFriendsSheetState extends State<ShareFriendsSheet> {
  List<String> tabs = ['Social', 'Friends', 'Fans', 'Recent'];
  String selectedTab = 'Social';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  tabs.length,
                      (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tabs[index];
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          tabs[index],
                          style: sfProDisplayMedium.copyWith(
                            fontSize: selectedTab == tabs[index] ? 19.sp : 14.sp,
                            color: selectedTab == tabs[index] ? AppColors.white : AppColors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 5),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: selectedTab == tabs[index] ? AppColors.white : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Expanded(
              child: selectedTab == 'Social'
                  ? SocialTab()
                  : selectedTab == 'Friends'
                  ?  AllFriendsView()
                  : selectedTab == 'Fans'
                  ?  FansView()
                  :  RecentTab(),
            ),
          ],
        ),
      ),
    );
  }
}