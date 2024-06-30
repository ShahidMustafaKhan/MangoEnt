import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/constants/typography.dart';
import '../../../../../../../utils/theme/colors_constant.dart';
import '../../audio_live_streaming/widgets/guest_widget.dart';
import 'admin_list_sheet.dart';
import 'blocked_sheet.dart';
import 'disable_chat_sheet.dart';

class ManageModalSheet extends StatefulWidget {
  final String initialTab;

  ManageModalSheet({required this.initialTab});

  @override
  State<ManageModalSheet> createState() => _ManageModalSheetState();
}

class _ManageModalSheetState extends State<ManageModalSheet> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab;
  }

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget buildContent() {
    switch (selectedTab) {
      case 'Disable Chat':
        return DisableChatSheet();
      case 'Blocked':
        return BlockedSheet();
      case 'Admin List':
        return AdminListSheet();
      default:
        return GuestsWidget();
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
                  onTap: () => onTabSelected('Disable Chat'),
                  child: Column(
                    children: [
                      Text(
                        'Disable Chat',
                        style: sfProDisplayMedium.copyWith(fontSize: 18.sp),
                      ),
                      if (selectedTab == 'Disable Chat')
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
                  onTap: () => onTabSelected('Blocked'),
                  child: Column(
                    children: [
                      Text(
                        'Blocked',
                        style: sfProDisplayMedium.copyWith(fontSize: 18.sp),
                      ),
                      if (selectedTab == 'Blocked')
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
                  onTap: () => onTabSelected('Admin List'),
                  child: Column(
                    children: [
                      Text(
                        'Admin List',
                        style: sfProDisplayMedium.copyWith(fontSize: 18.sp),
                      ),
                      if (selectedTab == 'Admin List')
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
