import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teego/parse/LiveMessagesModel.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/constants/typography.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class ChatCard extends StatelessWidget {
  final LiveMessagesModel liveMessagesModel;
  const ChatCard({required this.liveMessagesModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.darkPurple,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(1.9.r),
                child: CircleAvatar(
                  radius: 13.r,
                  backgroundColor: AppColors.grey300,
                  backgroundImage: NetworkImage(liveMessagesModel.getAuthorAvatarUrl!),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
              constraints: BoxConstraints(
                maxWidth: 151.w,
              ),
              child: FittedBox(child: Text(liveMessagesModel.getMessage ?? '', maxLines: 7, style: sfProDisplayRegular.copyWith(fontSize: 11.sp),))),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios, size:12)
        ],
      ),
    );
  }
}
