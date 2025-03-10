import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget();

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 30.obs;

    final List<String> stickerPaths = [
      AppImagePath.sticker1,
      AppImagePath.filter1,
      AppImagePath.filter2,
      AppImagePath.filter3,
      AppImagePath.filter4,
      AppImagePath.filter5,
      AppImagePath.filter6,
      AppImagePath.filter7,
      AppImagePath.filter8,
      AppImagePath.filter9,
      AppImagePath.filter10,
      AppImagePath.filter11,
      AppImagePath.filter12,
      AppImagePath.filter13,
      AppImagePath.filter14,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.w,
              childAspectRatio: 1.0,
            ),
            itemCount: stickerPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){selectedIndex.value=index;},
                child: Obx(() {
                    return Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xff323232),
                        border: Border.all(
                            width: 2,
                            color: index == selectedIndex.value ? AppColors.yellowColor : Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xff323232),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                stickerPaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (index >= 4 && index <= 14)
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Container(
                                  width: 8.77.w,
                                  height: 9.5.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(1.46.r),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      AppImagePath.arrowDown,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
