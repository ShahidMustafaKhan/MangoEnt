import 'package:flutter/material.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.darkPurple,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.grey300,
            backgroundImage: AssetImage(AppImagePath.cardImage2),
          ),
          const SizedBox(width: 5),
          Text('The broadcaster invites you to join a PK', style: sfProDisplayRegular.copyWith(fontSize: 12),),
        ],
      ),
    );
  }
}
