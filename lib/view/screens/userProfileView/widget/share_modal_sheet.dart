import 'package:flutter/material.dart';
import 'package:teego/view/screens/userProfileView/widget/recent_sheet.dart';
import 'package:teego/view/screens/userProfileView/widget/social_sheet.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import 'fans_sheet.dart';
import 'friends_sheet.dart';

class ShareModalSheet extends StatefulWidget {
  ShareModalSheet();

  @override
  State<ShareModalSheet> createState() => _ShareModalSheetState();
}

class _ShareModalSheetState extends State<ShareModalSheet> {
  int selectedIndex = -1;
  String selectedTab = 'Social';

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget buildContent() {
    switch (selectedTab) {
      case 'Social':
        return SocialWidget();
      case 'Friends':
        return FriendsWidget();
      case 'Fans':
        return FansWidget();
      case 'Recent':
        return RecentWidget();
      default:
        return SocialWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => onTabSelected('Social'),
                  child: Column(
                    children: [
                      Text(
                        'Social',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Social')
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
                  onTap: () => onTabSelected('Friends'),
                  child: Column(
                    children: [
                      Text(
                        'Friends',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Friends')
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
                  onTap: () => onTabSelected('Fans'),
                  child: Column(
                    children: [
                      Text(
                        'Fans',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Fans')
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
                  onTap: () => onTabSelected('Recent'),
                  child: Column(
                    children: [
                      Text(
                        'Recent',
                        style: sfProDisplayMedium.copyWith(fontSize: 20),
                      ),
                      if (selectedTab == 'Recent')
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
