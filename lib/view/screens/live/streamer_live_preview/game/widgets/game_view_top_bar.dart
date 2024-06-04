import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';

class GameViewTopBar extends StatelessWidget {
  final RxInt index;

  GameViewTopBar({required this.index});
  final RxList<Widget> personList = <Widget>[
    Image.asset(
      AppImagePath.mobileIcon,
      height: 21.64.h,
      width: 21.64.w,
    ),
    Image.asset(
      AppImagePath.pcIcon,
      height: 21.64.h,
      width: 21.64.w,
    ),
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Spacer(),
          ...List.generate(
            personList.length,
            (i) => GestureDetector(
              onTap: () {
                index.value = i;
                // Index.value = i;
              },
              child: Obx(
                () => Container(
                  height: 28.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    color: index.value == i
                        ? AppColors.yellowBtnColor
                        : AppColors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: i == 0 ? Radius.circular(50.r) : Radius.zero,
                      bottomLeft: i == 0 ? Radius.circular(50.r) : Radius.zero,
                      topRight: i == 1 ? Radius.circular(50.r) : Radius.zero,
                      bottomRight: i == 1 ? Radius.circular(50.r) : Radius.zero,
                    ),
                  ),
                  child: Center(
                    child: personList[i],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90.w,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.black.withOpacity(0.7),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
