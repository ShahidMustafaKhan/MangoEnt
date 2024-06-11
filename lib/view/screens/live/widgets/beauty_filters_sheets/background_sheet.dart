import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/app_constants.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget();

  @override
  Widget build(BuildContext context) {
    final List<String> stickerPaths = [
      AppImagePath.sticker1,
      AppImagePath.background1,
      AppImagePath.background2,
      AppImagePath.background3,
      AppImagePath.background4,
      AppImagePath.background5,
      AppImagePath.background6,
      AppImagePath.background7,
      AppImagePath.background8,
      AppImagePath.background9,
      AppImagePath.background10,
      AppImagePath.background11,
      AppImagePath.background12,
      AppImagePath.background13,
      AppImagePath.background14,
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
              return Container(
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
              );
            },
          ),
        ),
      ],
    );
  }
}
