import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teego/utils/constants/app_constants.dart';
import '../../utils/theme/colors_constant.dart';

class YouMayLike extends StatelessWidget {
  const YouMayLike({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          return Container(
            width: 110.w,
            height: 110.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    index % 2 == 0
                        ? AppImagePath.multiGuestImage
                        : AppImagePath.multiGuestNumberIcon2,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Row(
                    children: [
                      Image.asset(AppImagePath.trendPic),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        '343',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Row(
                    children: [
                      Text(
                        'Kyle',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
