import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../../utils/theme/colors_constant.dart';

class StickerWidget extends StatelessWidget {
  const StickerWidget();

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 30.obs;

    final List<String> stickerPaths = [
      AppImagePath.sticker1,
      AppImagePath.sticker2,
      AppImagePath.sticker3,
      AppImagePath.sticker4,
      AppImagePath.sticker5,
      AppImagePath.sticker6,
      AppImagePath.sticker7,
      AppImagePath.sticker8,
      AppImagePath.sticker9,
      AppImagePath.sticker10,
      AppImagePath.sticker11,
      AppImagePath.sticker12,
      AppImagePath.sticker13,
      AppImagePath.sticker14,
      AppImagePath.sticker15,
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
