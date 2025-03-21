import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../generated/assets.dart';
import '../../utils/constants/typography.dart';
import '../../utils/theme/colors_constant.dart';
import '../../view_model/broadcaster_controller.dart';
import '../../view_model/search_controller.dart';

class BroadCasters extends StatelessWidget {
  final int index;

  const BroadCasters({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BroadCastersController());
    final controller = Get.find<BroadCastersController>();
    final searchController = Get.find<SearchController>();

    return InkWell(
      onTap: () {
        controller.toggleSelection(index);
      },
      child: Obx(() {
        return Column(
          children: [
            if(searchController.recentPopular[index].getAvatar!=null)
            CircleAvatar(
              radius: ScreenUtil().setWidth(30),
              backgroundImage: NetworkImage(searchController.recentPopular[index].getAvatar!.url!),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            Text(
              '${searchController.recentPopular[index].getFullName}',
              style: sfProDisplayMedium.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.isSelected(index)
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.yellow,
                        size: 20.0,
                      )
                    : SizedBox(),
                SizedBox(width: 5),
                Icon(
                  Icons.person,
                  color: AppColors.yellow,
                  size: ScreenUtil().setHeight(20),
                ),
                Text(
                  '${searchController.recentPopular[index].getFollowers!.length}',
                  style: sfProDisplayRegular.copyWith(color: AppColors.dHintColor, fontSize: 12),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
