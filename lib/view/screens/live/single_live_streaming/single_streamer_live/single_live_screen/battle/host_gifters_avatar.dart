import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import 'package:teego/utils/theme/colors_constant.dart';



class HostGifters extends StatelessWidget {
  HostGifters();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Row(
          children: [
            ...List.generate(3, (index) {
              int reversedIndex = 2 - index;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 26.w,
                      height: 26.w,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AppImagePath.cardImage2),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.yellowColor, width: 1),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        '${reversedIndex + 1}',
                        style: TextStyle(
                          inherit: true,
                          fontSize: 10.sp,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              // bottomLeft
                              offset: const Offset(-1, -1),
                              color: AppColors.darkOrange,
                            ),
                            Shadow(
                              // bottomRight
                              offset: const Offset(1, -1),
                              color: AppColors.darkOrange,
                            ),
                            Shadow(
                              // topRight
                              offset: const Offset(1, 1),
                              color: AppColors.darkOrange,
                            ),
                            Shadow(
                              // topLeft
                              offset: const Offset(-1, 1),
                              color: AppColors.darkOrange,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
